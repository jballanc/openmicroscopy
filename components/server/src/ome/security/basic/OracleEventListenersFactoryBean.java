/*
 *   ome.security.basic.OracleEventListenersFactoryBean
 *
 *   Copyright 2015 Glencoe Software, Inc. All rights reserved.
 *   Use is subject to license terms supplied in LICENSE.txt
 */

package ome.security.basic;

import ome.security.ACLVoter;
import ome.tools.hibernate.EmptyStringEventListener;


/**
 * Subclass of the {@link EventListenersFactoryBean} adding in Oracle specific listeners.
 */
public class OracleEventListenersFactoryBean extends EventListenersFactoryBean {

    public OracleEventListenersFactoryBean(CurrentDetails cd, TokenHolder th,
            ACLVoter voter, OmeroInterceptor interceptor) {
        super(cd, th, voter, interceptor);
    }

    @Override
    protected void additions() {
        super.additions();

        EmptyStringEventListener esel = new EmptyStringEventListener();
        append("pre-insert", esel);
    }
}
