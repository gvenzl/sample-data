/*
 * Encoding: UTF-8
 * Since: November, 2022
 * Author: gvenzl
 * Name: install.oracle.sql
 * Description: Setup script for Solar System data for Oracle DB.
 *
 * Copyright 2022 Gerald Venzl
 *
 * This work is licensed under the
 * Creative Commons Attribution 4.0 International Public License, CC BY 4.0
 *
 *    https://creativecommons.org/licenses/by/4.0/
 */

-- Set DATE and TIMESTAMP format
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT='YYYY-MM-DD HH24:MI:SS';

-- Call install script
@install.sql

