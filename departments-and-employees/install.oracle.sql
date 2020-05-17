/*
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
 * Data Sources:
 * - This data set is fictional and has no data sources.
 *
 * The Data is provided "as is" without warranty or any representation of
 * accuracy, timeliness or completeness.
 *
 *    https://creativecommons.org/licenses/by/4.0/
 */ 

/*********************************************/
/*************** DEPARTMENTS *****************/
/*********************************************/

CREATE TABLE departments
(
  department_id   SMALLINT      NOT NULL  CONSTRAINT departments_pk PRIMARY KEY,
  name            VARCHAR(10)   NOT NULL,
  location        VARCHAR(8)    NOT NULL
);

INSERT INTO departments (department_id, name, location) VALUES (1, 'Operations', 'Vienna');
INSERT INTO departments (department_id, name, location) VALUES (2, 'Sales', 'New York');
INSERT INTO departments (department_id, name, location) VALUES (3, 'Marketing', 'Paris');
INSERT INTO departments (department_id, name, location) VALUES (4, 'Accounting', 'London');

/*********************************************/
/**************** EMPLOYEES ******************/
/*********************************************/

CREATE TABLE employees
(
  employee_id     SMALLINT      NOT NULL  CONSTRAINT employees_pk PRIMARY KEY,
  first_name      VARCHAR(8),
  last_name       VARCHAR(9)    NOT NULL,
  job_title       VARCHAR(9),
  manager_id      SMALLINT                CONSTRAINT employees_employees_fk001
                                          REFERENCES employees (employee_id),
  hire_date       DATE          NOT NULL,
  salary          NUMERIC(7,2)  NOT NULL,
  commission      NUMERIC(7,2),
  department_id   SMALLINT      NOT NULL  CONSTRAINT employees_departments_fk001
                                          REFERENCES departments (department_id)
);

INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1238, 'John', 'King', 'President', null, TO_DATE('2015-05-14','YYYY-MM-DD'), 10000, null, 1);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1346, 'Greg', 'Edelstein', 'Manager', 1238, TO_DATE('2016-06-17','YYYY-MM-DD'), 8000, null, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1387, 'Erin', 'Smith', 'Manager', 1238, TO_DATE('2017-02-04','YYYY-MM-DD'), 6000, null, 3);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1362, 'Andrew', 'Counters', 'Analyst', 1238, TO_DATE('2016-11-03','YYYY-MM-DD'), 3000, null, 4);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1565, 'Sarah', 'Bean', 'Analyst', 1238, TO_DATE('2019-10-22','YYYY-MM-DD'), 2000, null, 4);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1456, 'James', 'Greed', 'Manager', 1346, TO_DATE('2018-03-12','YYYY-MM-DD'), 5000, null, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1541, 'Judy', 'Mason', 'Manager', 1346, TO_DATE('2019-05-23','YYYY-MM-DD'), 4450, null, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1257, 'Joseph', 'Maka', 'Sales Rep', 1456, TO_DATE('2015-05-20','YYYY-MM-DD'), 6000, 1000, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1317, 'Graham', 'Cash', 'Sales Rep', 1456, TO_DATE('2015-12-08','YYYY-MM-DD'), 3000, 1500, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1423, 'Amanda', 'Tunsa', 'Sales Rep', 1456, TO_DATE('2018-02-12','YYYY-MM-DD'), 3000, 1000, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1512, 'Alastair', 'Walker', 'Sales Rep', 1541, TO_DATE('2018-07-24','YYYY-MM-DD'), 3000, 750, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1603, 'Gerald', 'Venzl', 'Sales Rep', 1541, TO_DATE('2020-04-02','YYYY-MM-DD'), 2000, 500, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1394, 'Monica', 'Point', 'Associate', 1387, TO_DATE('2017-05-13','YYYY-MM-DD'), 1200, null, 3);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1404, 'Mark', 'Powers', 'Associate', 1387, TO_DATE('2018-01-14','YYYY-MM-DD'), 1000, null, 3);

COMMIT;
