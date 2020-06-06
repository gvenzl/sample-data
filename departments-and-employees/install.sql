/*
 * Encoding: UTF-8
 * Since: May, 2020
 * Author: gvenzl
 * Name: install.sql
 * Description: Setup script for departments and employees
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
  department_id   SMALLINT      NOT NULL,
  name            VARCHAR(10)   NOT NULL,
  location        VARCHAR(8)    NOT NULL,
  CONSTRAINT departments_pk PRIMARY KEY (department_id)
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
  employee_id     SMALLINT      NOT NULL,
  first_name      VARCHAR(8),
  last_name       VARCHAR(9)    NOT NULL,
  job_title       VARCHAR(9),
  manager_id      SMALLINT,
  hire_date       DATE          NOT NULL,
  salary          NUMERIC(7,2)  NOT NULL,
  commission      NUMERIC(7,2),
  department_id   SMALLINT      NOT NULL,
  CONSTRAINT employees_pk
    PRIMARY KEY (employee_id),
  CONSTRAINT employees_employees_fk001
    FOREIGN KEY (manager_id) REFERENCES employees (employee_id),
  CONSTRAINT employees_departments_fk001
    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1238, 'John', 'King', 'President', null, '2015-05-14', 10000, null, 1);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1346, 'Greg', 'Edelstein', 'Manager', 1238, '2016-06-17', 8000, null, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1387, 'Erin', 'Smith', 'Manager', 1238, '2017-02-04', 6000, null, 3);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1362, 'Andrew', 'Counters', 'Analyst', 1238, '2016-11-03', 3000, null, 4);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1565, 'Sarah', 'Bean', 'Analyst', 1238, '2019-10-22', 2000, null, 4);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1456, 'James', 'Greed', 'Manager', 1346, '2018-03-12', 5000, null, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1541, 'Judy', 'Mason', 'Manager', 1346, '2019-05-23', 4450, null, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1257, 'Joseph', 'Maka', 'Sales Rep', 1456, '2015-05-20', 6000, 1000, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1317, 'Graham', 'Cash', 'Sales Rep', 1456, '2015-12-08', 3000, 1500, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1423, 'Amanda', 'Tunsa', 'Sales Rep', 1456, '2018-02-12', 3000, 1000, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1512, 'Alastair', 'Walker', 'Sales Rep', 1541, '2018-07-24', 3000, 750, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1603, 'Gerald', 'Venzl', 'Sales Rep', 1541, '2020-04-02', 2000, 500, 2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1394, 'Monica', 'Point', 'Associate', 1387, '2017-05-13', 1200, null, 3);
INSERT INTO employees (employee_id, first_name, last_name, job_title, manager_id, hire_date, salary, commission, department_id)
  VALUES (1404, 'Mark', 'Powers', 'Associate', 1387, '2018-01-14', 1000, null, 3);

COMMIT;
