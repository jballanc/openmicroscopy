
--
-- GENERATED %(TIME)s from %(DIR)s
--
-- This file was created by the bin/omero db script command
-- and contains an MD5 version of your OMERO root users's password.
-- You should think about deleting it as soon as possible.
--
-- To create your database:
--
--     sqlplus omero@dbname/password @SCRIPT_NAME
--
--

SPOOL create.log;
SET ECHO ON;
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK;

CREATE GLOBAL TEMPORARY TABLE temp_ids (key varchar2(33), id number(20))
/
CREATE INDEX temp_ids_idx on temp_ids(key)
/
CREATE TYPE tempids_objecttype AS OBJECT (ID NUMBER(20))
/
CREATE TYPE tempids_tabletype AS TABLE OF tempids_objecttype
/
CREATE OR REPLACE FUNCTION temp_ids_cursor(key varchar2)
         RETURN tempids_tabletype PIPELINED IS

 TYPE         ref0 IS REF CURSOR;
 cur0         ref0;
 out_rec      tempids_objecttype := tempids_objecttype(null);
 v_key        varchar2(33);

BEGIN

 v_key := key;

 OPEN cur0 FOR 'SELECT id FROM temp_ids WHERE key = :1' USING v_key;

 LOOP
    FETCH cur0 INTO out_rec.id;
    EXIT WHEN cur0%%NOTFOUND;
    PIPE ROW(out_rec);
 END LOOP;
 CLOSE cur0;

RETURN;
END temp_ids_cursor;
/

--
--
CREATE OR REPLACE FUNCTION ome_to_char(txt clob)
         RETURN varchar2 IS

BEGIN

    RETURN to_char(txt);

EXCEPTION
    WHEN OTHERS THEN
        RETURN DBMS_LOB.SUBSTR(txt, 1000, 1) || '>>> STRING STRIPPED : a6b3afcc-432c-11e0-947e-5bd4e156fd42';

END ome_to_char;
/

-- Array Types used throughout. These must be kept in
-- sync with the OracleSqlArray type in Java.

CREATE OR REPLACE TYPE STRING_ARRAY  as VARRAY(255) OF VARCHAR(255);
/
CREATE OR REPLACE TYPE STRING_ARRAY_ARRAY AS VARRAY(255) OF STRING_ARRAY;
/
CREATE OR REPLACE TYPE STRING_PAIR  as VARRAY(2) OF VARCHAR(255);
/
CREATE OR REPLACE TYPE PARAMS_MAP AS VARRAY(255) OF STRING_PAIR;
/


CREATE OR REPLACE PACKAGE conversion_api AS

FUNCTION to_base(p_dec   IN  NUMBER,
                 p_base  IN  NUMBER) RETURN VARCHAR2;

FUNCTION to_dec (p_str        IN  VARCHAR2,
                 p_from_base  IN  NUMBER DEFAULT 16) RETURN NUMBER;

FUNCTION to_hex(p_dec  IN  NUMBER) RETURN VARCHAR2;

FUNCTION to_bin(p_dec  IN  NUMBER) RETURN VARCHAR2;

FUNCTION to_oct(p_dec  IN  NUMBER) RETURN VARCHAR2;

END conversion_api;
/


CREATE OR REPLACE PACKAGE BODY conversion_api AS

FUNCTION to_base(p_dec   IN  NUMBER,
                 p_base  IN  NUMBER) RETURN VARCHAR2 IS
	l_str	VARCHAR2(255) DEFAULT NULL;
	l_num	NUMBER	      DEFAULT p_dec;
	l_hex	VARCHAR2(16)  DEFAULT '0123456789ABCDEF';
BEGIN
	IF (TRUNC(p_dec) <> p_dec OR p_dec < 0) THEN
		RAISE PROGRAM_ERROR;
	END IF;
	LOOP
		l_str := SUBSTR(l_hex, MOD(l_num,p_base)+1, 1) || l_str;
		l_num := TRUNC(l_num/p_base);
		EXIT WHEN (l_num = 0);
	END LOOP;
	RETURN l_str;
END to_base;

FUNCTION to_dec (p_str        IN  VARCHAR2,
                 p_from_base  IN  NUMBER DEFAULT 16) RETURN NUMBER IS
	l_num   NUMBER       DEFAULT 0;
	l_hex   VARCHAR2(16) DEFAULT '0123456789ABCDEF';
BEGIN
	FOR i IN 1 .. LENGTH(p_str) LOOP
		l_num := l_num * p_from_base + INSTR(l_hex,UPPER(SUBSTR(p_str,i,1)))-1;
	END LOOP;
	RETURN l_num;
END to_dec;

FUNCTION to_hex(p_dec  IN  NUMBER) RETURN VARCHAR2 IS
BEGIN
	RETURN to_base(p_dec, 16);
END to_hex;

FUNCTION to_bin(p_dec  IN  NUMBER) RETURN VARCHAR2 IS
BEGIN
	RETURN to_base(p_dec, 2);
END to_bin;

FUNCTION to_oct(p_dec  IN  NUMBER) RETURN VARCHAR2 IS
BEGIN
	RETURN to_base(p_dec, 8);
END to_oct;

END conversion_api;
/

--
-- Checks if all the bits in check_ are set in number. If so, return 1; otherwise 0
--
CREATE OR REPLACE FUNCTION all_bits_set(value in number, check_ in number) RETURN NUMBER IS
BEGIN
   IF BITAND(value, check_) = check_ THEN
         RETURN 1;
    ELSe
        RETURN 0;
    END IF;
END;
/

