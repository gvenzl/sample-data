/*
 * Encoding: UTF-8
 * Since: May, 2020
 * Author: gvenzl
 * Name: install.oracle.sql
 * Description: Setup script for departments and employees for Oracle DB
 *
 * Copyright 2020 Gerald Venzl
 *
 * This work is licensed under the
 * Creative Commons Attribution 4.0 International Public License, CC BY 4.0
 *
 *    https://creativecommons.org/licenses/by/4.0/
 */ 

-- Set DATE format
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

-- Call install script
@install.sql
