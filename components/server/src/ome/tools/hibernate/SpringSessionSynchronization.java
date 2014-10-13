package ome.tools.hibernate;

import org.hibernate.FlushMode;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import org.springframework.core.Ordered;
import org.springframework.dao.DataAccessException;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.orm.hibernate4.SessionFactoryUtils;
import org.springframework.orm.hibernate4.SessionHolder;

class SpringSessionSynchronization implements TransactionSynchronization, Ordered {

    private final SessionHolder sessionHolder;

    private final SessionFactory sessionFactory;

    private boolean holderActive = true;


    public SpringSessionSynchronization(SessionHolder sessionHolder, SessionFactory sessionFactory) {
        this.sessionHolder = sessionHolder;
        this.sessionFactory = sessionFactory;
    }

    private Session getCurrentSession() {
        return this.sessionHolder.getSession();
    }


    @Override
    public int getOrder() {
        return SessionFactoryUtils.SESSION_SYNCHRONIZATION_ORDER;
    }

    @Override
    public void suspend() {
        if (this.holderActive) {
            TransactionSynchronizationManager.unbindResource(this.sessionFactory);
            // Eagerly disconnect the Session here, to make release mode "on_close" work on JBoss.
            getCurrentSession().disconnect();
        }
    }

    @Override
    public void resume() {
        if (this.holderActive) {
            TransactionSynchronizationManager.bindResource(this.sessionFactory, this.sessionHolder);
        }
    }

    @Override
    public void flush() {
        try {
            getCurrentSession().flush();
        }
        catch (HibernateException ex) {
            throw SessionFactoryUtils.convertHibernateAccessException(ex);
        }
    }

    @Override
    public void beforeCommit(boolean readOnly) throws DataAccessException {
        if (!readOnly) {
            Session session = getCurrentSession();
            // Read-write transaction -> flush the Hibernate Session.
            // Further check: only flush when not FlushMode.MANUAL.
            if (!session.getFlushMode().equals(FlushMode.MANUAL)) {
                try {
                    session.flush();
                }
                catch (HibernateException ex) {
                    throw SessionFactoryUtils.convertHibernateAccessException(ex);
                }
            }
        }
    }

    @Override
    public void beforeCompletion() {
        Session session = this.sessionHolder.getSession();
        if (this.sessionHolder.getPreviousFlushMode() != null) {
            // In case of pre-bound Session, restore previous flush mode.
            session.setFlushMode(this.sessionHolder.getPreviousFlushMode());
        }
        // Eagerly disconnect the Session here, to make release mode "on_close" work nicely.
        session.disconnect();
    }

    @Override
    public void afterCommit() {
    }

    @Override
    public void afterCompletion(int status) {
        try {
            if (status != STATUS_COMMITTED) {
                // Clear all pending inserts/updates/deletes in the Session.
                // Necessary for pre-bound Sessions, to avoid inconsistent state.
                this.sessionHolder.getSession().clear();
            }
        }
        finally {
            this.sessionHolder.setSynchronizedWithTransaction(false);
        }
    }

}
