/*
 * Copyright (C) 2009-2013 Glencoe Software, Inc. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 */

package ome.security.auth;

import java.security.Permissions;

import ome.security.SecuritySystem;
import ome.services.messages.LoginAttemptMessage;
import ome.system.OmeroContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * Base class for most {@link PasswordProvider} implementations, providing
 * configuration for default behaviors. There is no need for a subclass to
 * use this implementation.
 *
 * @author Josh Moore, josh at glencoesoftware.com
 * @see SecuritySystem
 * @see Permissions
 * @since 4.0
 */
public abstract class ConfigurablePasswordProvider implements PasswordProvider,
        PasswordUtility, ApplicationContextAware {

    final protected Logger log = LoggerFactory.getLogger(this.getClass());

    /**
     * Hash implementation to use for encoding passwords to check and changed
     * passwords. Default value: MD5 (For the moment, the only supported value!)
     */
    protected final String hash;

    /**
     * Whether or not salting based on the user ID should be attempted.
     */
    protected final boolean salt;

    /**
     * If true, this implementation should return a null on
     * {@link #checkPassword(String, String)} if the user is unknown, otherwise
     * a {@link Boolean#FALSE}. Default value: false
     */
    protected final boolean ignoreUnknown;

    protected final PasswordUtil util;

    protected OmeroContext ctx;

    /**
     * Call {@link #ConfigurablePasswordProvider(PasswordUtil, boolean)}
     * with "ignoreUnknown" equal to false.
     * @param util
     */
    public ConfigurablePasswordProvider(PasswordUtil util) {
        this(util, false);
    }

    /**
     * Call {@link #ConfigurablePasswordProvider(PasswordUtil, boolean, boolean)}
     * with "salt" equal to false.
     */
    public ConfigurablePasswordProvider(PasswordUtil util, boolean ignoreUnknown) {
        this(util, ignoreUnknown, false);
    }

    public ConfigurablePasswordProvider(PasswordUtil util, boolean ignoreUnknown,
            boolean salt) {
        this.util = util;
        this.hash = "MD5";
        this.salt = salt;
        this.ignoreUnknown = ignoreUnknown;
    }

    public void setApplicationContext(ApplicationContext ctx)
            throws BeansException {
        this.ctx = (OmeroContext) ctx;
    }

    protected Boolean loginAttempt(String user, Boolean success) {
        try {
            this.ctx.publishMessage(new LoginAttemptMessage(this, user, success));
        } catch (Throwable e) {
            log.error("LoginAttemptMessage error", e);
        }
        return success;
    }

    /**
     * Always returns false, override with specific logic.
     */
    public boolean hasPassword(String user) {
        return false;
    }

    /**
     * If {@link #ignoreUnknown} is true, returns null, since the base class
     * knows no users. Otherwise, return {@link Boolean#FALSE} specifying that
     * authentication should fail.
     */
    public Boolean checkPassword(String user, String password, boolean readOnly) {
        if (ignoreUnknown) {
            return null;
        } else {
            return Boolean.FALSE;
        }
    }

    /**
     * Throws by default.
     */
    public void changePassword(String user, String password)
            throws PasswordChangeException {
        throw new PasswordChangeException(
                "Cannot change password with this implementation: "
                        + getClass().getName());
    }

    /**
     * Encodes the password as it would be encoded for a check by
     * {@link #comparePasswords(String, String)}
     */
    public String encodePassword(String newPassword) {
        return util.preparePassword(newPassword);
    }

    /**
     * Encodes the password as it would be encoded for a check by
     * {@link #comparePasswords(String, String)} salting the password
     * with the given userId if it's provided.
     */
    public String encodeSaltedPassword(Long userId, String newPassword) {
        if (salt) {
            return util.prepareSaltedPassword(userId, newPassword);
        } else {
            return util.preparePassword(newPassword);
        }
    }

    /**
     * Compares the password provided by the user (unhashed) against the given
     * trusted password. A return value of null, however, is also possible
     * with the same semantics as a null from
     * {@link #checkPassword(String, String, boolean)}.
     *
     * For this implementation, if the trusted password is null, return
     * {@link Boolean.FALSE}. If the trusted password is empty (only
     * whitespace), return {@link Boolean.TRUE}. Otherwise return the results of
     * {@link String#equals(Object)}.
     */
    public Boolean comparePasswords(String trusted, String provided) {
        return comparePasswords(null, trusted, provided);
    }

    /**
     * Compares the password provided by the user (unhashed) against the given
     * trusted password. In general, if the trusted password is null, return
     * {@link Boolean.FALSE}. If the trusted password is empty (only
     * whitespace), return {@link Boolean.TRUE}. Otherwise return the results of
     * {@link String#equals(Object)}.
     */
    public Boolean comparePasswords(Long userId, String trusted, String provided) {
        if (trusted == null) {
            return Boolean.FALSE;
        } else if ("".equals(trusted.trim())) {
            return Boolean.TRUE;
        } else {
            if (userId != null && salt) {
                if (trusted.equals(encodeSaltedPassword(userId, provided))) {
                    return Boolean.TRUE;
                }
            }
            return trusted.equals(encodePassword(provided)); // ok unsalted.
        }
    }

}
