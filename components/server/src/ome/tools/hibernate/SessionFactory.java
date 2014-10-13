/*
 *   $Id$
 *
 *   Copyright 2009 Glencoe Software, Inc. All rights reserved.
 *   Use is subject to license terms supplied in LICENSE.txt
 */
package ome.tools.hibernate;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.transaction.Status;
import javax.transaction.Transaction;
import javax.transaction.TransactionManager;

import ome.util.SqlAction;
import ome.util.TableIdGenerator;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.hibernate.FlushMode;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.engine.spi.SessionFactoryImplementor;
import org.hibernate.id.IdentifierGenerator;
import org.hibernate.internal.SessionImpl;
import org.hibernate.internal.SessionFactoryImpl;
import org.springframework.aop.framework.ProxyFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate4.SessionHolder;
import org.springframework.transaction.jta.SpringJtaSynchronizationAdapter;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.util.Assert;

/**
 * Simple source of Thread-aware {@link Session} instances. Wraps a
 * call to {@link SessionFactoryUtils}. Should be safe to call from
 * within any service implementation call or inside of Executor.execute.
 *
 * @author Josh Moore, josh at glencoesoftware.com
 * @since 4.0
 */
public class SessionFactory implements MethodInterceptor {

    private final static Set<String> FORBIDDEN = Collections.unmodifiableSet(
        new HashSet<String>(
            Arrays.asList(
                "createSQLQuery", "doWork",
                "connection", "disconnect", "reconnect")));

    static {
        // Check for spelling mistakes
        int found = 0;
        Method[] methods = SessionImpl.class.getMethods();
        for (Method m : methods) {
            if (FORBIDDEN.contains(m.getName())) {
                found++;
            }
        }
        if (found < FORBIDDEN.size()) {
            throw new RuntimeException("Method name not found! " + FORBIDDEN);
        }

    }


    private final org.hibernate.SessionFactory factory;

    public SessionFactory(org.hibernate.SessionFactory factory, SqlAction isolatedSqlAction) {
        Assert.notNull(factory, "No SessionFactory specified");
        this.factory = factory;
        for (Object k : this.factory.getAllClassMetadata().keySet()) {
            IdentifierGenerator ig =
                ((SessionFactoryImpl) factory).getIdentifierGenerator((String)k);
            if (ig instanceof TableIdGenerator) {
                ((TableIdGenerator) ig).setSqlAction(isolatedSqlAction);
            }
        }

    }

    /**
     * Returns a session active for the current thread. The returned
     * instance will be wrapped with AOP to prevent certain usage.
     * @see ticket:73
     */
    public Session getSession() {

        Session unwrapped = getUnwrappedSession();

        ProxyFactory proxyFactory = new ProxyFactory();
        proxyFactory.setInterfaces(new Class[]{
            Session.class,
            org.hibernate.Session.class,
            org.hibernate.event.spi.EventSource.class});
        proxyFactory.setTarget(unwrapped);
        proxyFactory.addAdvice(0, this);
        return (Session) proxyFactory.getProxy();

    }

    /**
     * Wraps all invocations to Session to prevent certain usages.
     * Note: {@link QueryBuilder} may unwrap the session in certain
     * cases.
     */
    public Object invoke(MethodInvocation mi) throws Throwable {

        final String name = mi.getMethod().getName();
        if (FORBIDDEN.contains(name)) {
            throw new ome.conditions.InternalException(String.format(
                "Usage of session.%s is forbidden. See ticket #73", name));
        }
        return mi.proceed();

    }

    /**
     * Tries various means of getting access to the current Hibernate session. Code is
     * primarily adapted from the implementation of {@code #getSession} from the Spring
     * framework's Hibernate3 version of {@code SessionFactoryUtils}.
     */
    private Session getUnwrappedSession() throws HibernateException,
           IllegalStateException {
        Object resource = TransactionSynchronizationManager.getResource(factory);

        if (resource instanceof Session) {
            return (Session) resource;
        }

        SessionHolder sessionHolder = (SessionHolder) resource;
        if (sessionHolder != null) {
            // pre-bound Hibernate Session
            Session session = null;
            if (TransactionSynchronizationManager.isSynchronizationActive()) {
                // Spring transaction management is active ->
                // register pre-bound Session with it for transactional flushing.
                session = sessionHolder.getSession();
                if (session != null && !sessionHolder.isSynchronizedWithTransaction()) {
                    TransactionSynchronizationManager.registerSynchronization(
                            new SpringSessionSynchronization(sessionHolder, factory));
                    sessionHolder.setSynchronizedWithTransaction(true);
                    // Switch to FlushMode.AUTO, as we have to assume a thread-bound Session
                    // with FlushMode.MANUAL, which needs to allow flushing within the transaction.
                    FlushMode flushMode = session.getFlushMode();
                    if (flushMode.lessThan(FlushMode.COMMIT) &&
                            !TransactionSynchronizationManager.isCurrentTransactionReadOnly()) {
                        session.setFlushMode(FlushMode.AUTO);
                        sessionHolder.setPreviousFlushMode(flushMode);
                    }
                }
            }
            else {
                // No Spring transaction management active -> try JTA transaction synchronization.
                session = getJtaSynchronizedSession(sessionHolder);
            }
            if (session != null) {
                return session;
            }
        }

        Session session = factory.openSession();

        // Use same Session for further Hibernate actions within the transaction.
        // Thread object will get removed by synchronization at transaction completion.
        if (TransactionSynchronizationManager.isSynchronizationActive()) {
            // We're within a Spring-managed transaction, possibly from JtaTransactionManager.
            SessionHolder holderToUse = new SessionHolder(session);
            if (TransactionSynchronizationManager.isCurrentTransactionReadOnly()) {
                session.setFlushMode(FlushMode.MANUAL);
            }
            TransactionSynchronizationManager.registerSynchronization(
                    new SpringSessionSynchronization(holderToUse, factory));
            holderToUse.setSynchronizedWithTransaction(true);
            TransactionSynchronizationManager.bindResource(factory, holderToUse);
        }
        else {
            // No Spring transaction management active -> try JTA transaction synchronization.
            registerJtaSynchronization(session);
        }

        // Check whether we are allowed to return the Session.
        if (!isSessionTransactional(session)) {
            session.close();
            throw new IllegalStateException("No Hibernate Session bound to thread, " +
                    "and configuration does not allow creation of non-transactional one here");
        }

        return session;
    }

    private Session getJtaSynchronizedSession(SessionHolder sessionHolder)
            throws DataAccessResourceFailureException {

        // JTA synchronization is only possible with a javax.transaction.TransactionManager.
        // We'll check the Hibernate SessionFactory: If a TransactionManagerLookup is specified
        // in Hibernate configuration, it will contain a TransactionManager reference.
        TransactionManager jtaTm = getJtaTransactionManager(sessionHolder.getSession());
        if (jtaTm != null) {
            // Check whether JTA transaction management is active ->
            // fetch pre-bound Session for the current JTA transaction, if any.
            // (just necessary for JTA transaction suspension, with an individual
            // Hibernate Session per currently active/suspended transaction)
            try {
                // Look for transaction-specific Session.
                Transaction jtaTx = jtaTm.getTransaction();
                if (jtaTx != null) {
                    int jtaStatus = jtaTx.getStatus();
                    if (jtaStatus == Status.STATUS_ACTIVE || jtaStatus == Status.STATUS_MARKED_ROLLBACK) {
                        Session session = sessionHolder.getSession();
                        if (session == null && !sessionHolder.isSynchronizedWithTransaction()) {
                            // No transaction-specific Session found: If not already marked as
                            // synchronized with transaction, register the default thread-bound
                            // Session as JTA-transactional. If there is no default Session,
                            // we're a new inner JTA transaction with an outer one being suspended:
                            // In that case, we'll return null to trigger opening of a new Session.
                            session = sessionHolder.getSession();
                            if (session != null) {
                                sessionHolder = new SessionHolder(session);
                                jtaTx.registerSynchronization(
                                        new SpringJtaSynchronizationAdapter(
                                            new SpringSessionSynchronization(sessionHolder, factory),
                                            jtaTm));
                                sessionHolder.setSynchronizedWithTransaction(true);
                                // Switch to FlushMode.AUTO, as we have to assume a thread-bound Session
                                // with FlushMode.NEVER, which needs to allow flushing within the transaction.
                                FlushMode flushMode = session.getFlushMode();
                                if (flushMode.lessThan(FlushMode.COMMIT)) {
                                    session.setFlushMode(FlushMode.AUTO);
                                    sessionHolder.setPreviousFlushMode(flushMode);
                                }
                            }
                        }
                        return session;
                    }
                }
                // No transaction active -> simply return default thread-bound Session, if any
                // (possibly from OpenSessionInViewFilter/Interceptor).
                return sessionHolder.getSession();
            }
            catch (Throwable ex) {
                throw new DataAccessResourceFailureException("Could not check JTA transaction", ex);
            }
        }
        else {
            // No JTA TransactionManager -> simply return default thread-bound Session, if any
            // (possibly from OpenSessionInViewFilter/Interceptor).
            return sessionHolder.getSession();
        }
    }

    private TransactionManager getJtaTransactionManager(Session session) {
        SessionFactoryImpl sessionFactoryImpl = null;
        if (factory instanceof SessionFactoryImplementor) {
            sessionFactoryImpl = ((SessionFactoryImpl) factory);
        }
        else if (session != null) {
            org.hibernate.SessionFactory internalFactory = session.getSessionFactory();
            if (internalFactory instanceof SessionFactoryImplementor) {
                sessionFactoryImpl = (SessionFactoryImpl) internalFactory;
            }
        }
        return (sessionFactoryImpl != null ? sessionFactoryImpl.getTransactionEnvironment().getJtaPlatform().retrieveTransactionManager() : null);
    }

    private void registerJtaSynchronization(Session session) {

        // JTA synchronization is only possible with a javax.transaction.TransactionManager.
        // We'll check the Hibernate SessionFactory: If a TransactionManagerLookup is specified
        // in Hibernate configuration, it will contain a TransactionManager reference.
        TransactionManager jtaTm = getJtaTransactionManager(session);
        if (jtaTm != null) {
            try {
                Transaction jtaTx = jtaTm.getTransaction();
                if (jtaTx != null) {
                    int jtaStatus = jtaTx.getStatus();
                    if (jtaStatus == Status.STATUS_ACTIVE || jtaStatus == Status.STATUS_MARKED_ROLLBACK) {
                        SessionHolder holderToUse = new SessionHolder(session);
                        jtaTx.registerSynchronization(
                                new SpringJtaSynchronizationAdapter(
                                    new SpringSessionSynchronization(holderToUse, factory),
                                    jtaTm));
                        holderToUse.setSynchronizedWithTransaction(true);
                        TransactionSynchronizationManager.bindResource(factory, holderToUse);
                    }
                }
            }
            catch (Throwable ex) {
                throw new DataAccessResourceFailureException(
                        "Could not register synchronization with JTA TransactionManager", ex);
            }
        }
    }

    /**
     * Return whether the given Hibernate Session is transactional, that is,
     * bound to the current thread by Spring's transaction facilities.
     * @param session the Hibernate Session to check
     * @return whether the Session is transactional
     */
    public boolean isSessionTransactional(Session session) {
        SessionHolder sessionHolder =
            (SessionHolder) TransactionSynchronizationManager.getResource(factory);
        return (sessionHolder != null && sessionHolder.getSession() == session);
    }
}
