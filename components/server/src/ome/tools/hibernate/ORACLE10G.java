package ome.tools.hibernate;

import java.sql.Array;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import oracle.jdbc.OracleConnection;

/**
 * Hibernate type to store a java array using SQL ARRAY.
 *
 * @author Sylvain
 *
 *         References : http://forum.hibernate.org/viewtopic.php?t=946973
 *         http://archives.postgresql.org/pgsql-jdbc/2003-02/msg00141.php
 */
public class ORACLE10G<T> {

    public final static ListAsSQLArrayUserType.ArrayFactory ARRAY_FACTORY =
        new ListAsSQLArrayUserType.ArrayFactory() {

            public Array BOOLEAN(Connection conn, List<Boolean> value) {
                throw new UnsupportedOperationException();
            }

            public Array DATE(Connection conn, List<Date> value) {
                throw new UnsupportedOperationException();
            }

            public Array DOUBLE(Connection conn, List<Double> value) {
                throw new UnsupportedOperationException();
            }

            public Array FLOAT(Connection conn, List<Float> value) {
                throw new UnsupportedOperationException();
            }

            public Array INTEGER(Connection conn, List<Integer> value) {
                throw new UnsupportedOperationException();
            }

            public Array STRING(Connection conn, List<String> value) throws SQLException {
                OracleConnection orclConn = conn.unwrap(OracleConnection.class);
                return orclConn.createOracleArray("STRING_ARRAY", value.toArray());
            }

            public Array STRING2(Connection conn, List<String[]> value) throws SQLException {
                OracleConnection orclConn = conn.unwrap(OracleConnection.class);
                return orclConn.createOracleArray("STRING_ARRAY_ARRAY", value.toArray());
            }

        };
}
