/*
 * Encoding: UTF-8
 * Since: October, 2024
 * Author: gvenzl
 * Name: install.oracle.sql
 * Description: Setup script for national parks for Oracle DB.
 *              This requires a database with 32k VARCHAR setup!
 *
 * Copyright 2024 Gerald Venzl
 *
 * This work is licensed under the
 * Creative Commons Attribution 4.0 International Public License, CC BY 4.0
 *
 *    https://creativecommons.org/licenses/by/4.0/
 */

-- Exit on any SQL error
WHENEVER SQLERROR EXIT SQL.SQLCODE;

PROMPT
PROMPT This data set requires Oracle Database to support 32k VARCHAR2 columns
PROMPT and the database parameter setting MAX_STRING_SIZE=EXTENDED.
PROMPT

ACCEPT long_varchar_config PROMPT 'Is this database configured for 32k VARCHAR2 columns? [YES|no]: ' DEFAULT 'YES'

SET SERVEROUTPUT ON;
BEGIN
   IF UPPER('&long_varchar_config') != 'YES' THEN
      RAISE_APPLICATION_ERROR(-20999, 'Error: this data set required 32k VARCHAR2 columns. Please reconfigure the database or install this data set on one that has 32k VARCHAR2 columns configured.');
   END IF;
END;
/
SET SERVEROUTPUT OFF;

-- Set DEFINE off so that '&' are ignored
SET DEFINE OFF;

-- Call install script
@install.sql

