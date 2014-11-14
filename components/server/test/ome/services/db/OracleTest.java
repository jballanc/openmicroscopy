/*
 *   Copyright 2011 Glencoe Software, Inc. All rights reserved.
 *   Use is subject to license terms supplied in LICENSE.txt
 */

package ome.services.db;

import junit.framework.AssertionFailedError;
import ome.model.containers.Dataset;
import ome.server.itests.AbstractManagedContextTest;
import ome.util.SqlAction;

import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

/**
 * Tests Oracle specific features & bugs
 */
@Test(groups = {"integration", "oracle"})
public class OracleTest extends AbstractManagedContextTest {

    public final String MARKER = ">>> STRING STRIPPED : a6b3afcc-432c-11e0-947e-5bd4e156fd42";


    SqlAction sql;

    @BeforeMethod
    public void setup() {
        sql = (SqlAction) applicationContext.getBean("simpleSqlAction");
    }

    /**
     * Currently we are storing Hibernate "text" types as BLOBS in
     * Oracle. Various issues have arisen due to "select distinct",
     * etc. and so now we are wrapping these columns with a call to
     * to_char. This may limit out at 4000 characters, in which case
     * we could have just use a VARCHAR2 column.
     */
    @Test
    public void testLargeBlobs() {
        assertDescription(0);
        assertDescription(1);
        assertDescription(1000);
        assertDescription(1333);
        assertDescription(1334);
        assertDescription(2000);
        assertDescription(2001);
        assertDescription(3999);
        assertDescription(4000);
        assertDescription(4001);
        assertDescription(10000);
        assertDescription(32000);
        assertDescription(64000);
    }

    private void assertDescription(int count) {
        // Non-unicode
        StringBuilder sb = new StringBuilder();
        fill(sb, count);
        assertDescription(sb);
        // Unicode
        sb = new StringBuilder();
        fillUnicode(sb, count);
        assertDescription(sb);

    }

    private void assertDescription(StringBuilder sb) {
        Dataset d = new Dataset();
        d.setName("testLargeBlobs");
        d.setDescription(sb.toString());
        d = iUpdate.saveAndReturnObject(d);
        equalButHandle0(sb, d.getDescription());
        d = iQuery.get(Dataset.class, d.getId());
        equalButHandle0(sb, d.getDescription());
    }

    private void equalButHandle0(StringBuilder sb, String d) {
        if (sb.length() == 0) {
            try {
                assertEquals("", d);
            } catch (AssertionFailedError afe) {
                assertEquals(null, d);
            }
        } else if (d.endsWith(MARKER)) {
            int matchableLength = d.length() - MARKER.length();
            assertEquals(
                    sb.substring(0, matchableLength),
                    d.substring(0, matchableLength));
        } else {
            assertEquals(sb.toString(), d);
        }
    }

    private void fill(StringBuilder sb, int count) {
        for (int i = 0; i < count; i++) {
            sb.append(i%10);
        }
    }

    static char[] chars = new char[] {'Ÿ', '§', '¿', 'Œ', 'Ž', '¢', '¹','™', '–', 'Å'};
    private void fillUnicode(StringBuilder sb, int count) {
        for (int i = 0; i < count; i++) {
            sb.append(chars[i%chars.length]);
        }
    }

}
