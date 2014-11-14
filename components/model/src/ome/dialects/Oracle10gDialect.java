package ome.dialects;

import org.hibernate.Hibernate;
import org.hibernate.dialect.function.SQLFunctionTemplate;

/**
 * select i from Image i where i.id in (:ids)
 * becomes
 * select i from Image i where i.id in (select id from temp_ids());
 */
public class Oracle10gDialect extends org.hibernate.dialect.Oracle10gDialect {

    public Oracle10gDialect() {
        super();
        registerFunction("temp_ids_cursor",
                new SQLFunctionTemplate(Hibernate.LONG, "select id from table(temp_ids_cursor(?1))"));
            
    }
    
}
