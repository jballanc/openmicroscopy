/*
 *   $Id$
 *
 *   Copyright 2015 Glencoe Software, Inc. All rights reserved.
 *   Use is subject to license terms supplied in LICENSE.txt
 */

package ome.tools.hibernate;

import ome.model.core.OriginalFile;

import org.hibernate.event.PreInsertEvent;
import org.hibernate.event.PreInsertEventListener;

/**
 * Hibernate pre-insert event listener to fix strings for Oracle. Since Oracle treats
 * empty strings an NULL values, this listener checks for any empty strings about to be
 * inserted and updates them appropriately.
 */

public class EmptyStringEventListener implements PreInsertEventListener {

    public boolean onPreInsert(PreInsertEvent event) {
        Object entity = event.getEntity();
        if (entity instanceof OriginalFile) {
            OriginalFile file = (OriginalFile) entity;
            if ("".equals(file.getPath())) {
                // Blank paths are not allowed in Oracle
                String[] names = event.getPersister()
                    .getEntityMetamodel().getPropertyNames();
                Object[] state = event.getState();

                for (int i = 0; i < names.length; i++) {
                    if ("path".equals(names[i])) {
                        // Must update both the entity and the state:
                        file.setPath("./");
                        state[i] = "./";
                        break;
                    }
                }
            }
        }
        return false;
    }
}
