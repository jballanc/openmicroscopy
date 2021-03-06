/*
 *   $Id$
 *
 *   Copyright 2014 Glencoe Software, Inc. All rights reserved.
 *   Use is subject to license terms supplied in LICENSE.txt
 */

package ome.services.messages;

import ome.services.messages.RegisterServiceCleanupMessage;

/**
 * A trivial subclass of RegisterServiceCleanupMessage so that we can catch
 * files opened during search indexing and close them at the end of parsing
 *
 * @author Josh Ballanco, jballanc at glencoesoftware.com
 * @since 5.0.0
 */


public abstract class ParserOpenFileMessage extends RegisterServiceCleanupMessage {

    public ParserOpenFileMessage(Object source, Object resource) {
        super(source, resource);
    }

}
