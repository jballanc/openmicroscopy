/*
 *   $Id$
 *
 *   Copyright 2015 Glencoe Software, Inc. All rights reserved.
 *   Use is subject to license terms supplied in LICENSE.txt
 */

package ome.security.basic;

import static ome.model.internal.Permissions.Right.READ;
import static ome.model.internal.Permissions.Role.GROUP;
import static ome.model.internal.Permissions.Role.USER;
import static ome.model.internal.Permissions.Role.WORLD;

import ome.model.internal.Permissions;
import ome.model.internal.Permissions.Right;
import ome.model.internal.Permissions.Role;
import ome.system.Roles;
import ome.util.SqlAction;

/**
 * Simple subclass of AllGroupsSecurityFilter to modify the permissions granted check.
 * This subclass needs to be used in place of the regular AllGroupsSecurityFilter when
 * running against Oracle. Which one of the two will be used is determined by the
 * `omero.security.all_groups_filter_class` configuration properyt.
 */
public class AllGroupsOracleSecurityFilter extends AllGroupsSecurityFilter {

    public AllGroupsOracleSecurityFilter(SqlAction sql) {
        this(sql, new Roles());
    }

    public AllGroupsOracleSecurityFilter(SqlAction sql, Roles roles) {
        super(sql, roles);
    }

    protected String myFilterCondition() {
        return String.format(
                  "\n( "
                + "\n  1 = :is_share OR "
                + "\n  1 = :is_admin OR "
                + "\n  (group_id in (:leader_of_groups)) OR "
                + "\n  (owner_id = :current_user AND %s) OR " // 1st arg U
                + "\n  (group_id in (:member_of_groups) AND %s) OR " // 2nd arg G
                + "\n  (%s) " // 3rd arg W
                + "\n)"
                + "\n", isGranted(USER, READ), isGranted(GROUP, READ),
                isGranted(WORLD, READ));
    }

    @Override
    public String getName() {
        // Default implementation uses the class name, but we need to present as a
        // stand-in for the AllGroupsSecurityFilter
        return "AllGroupsSecurityFilter";
    }

    protected static String isGranted(Role role, Right right) {
        String bit = "" + Permissions.bit(role, right);
        String isGranted = String.format(
                "1 = (select case when bitand(g.permissions,%s) = %s " +
                "then 1 else 0 end from experimentergroup g where g.id = group_id)",
                bit, bit);
        return isGranted;
    }
}
