# departments-and-employees

This data set contains ***fictional*** departments and employees data. It can be used for educational purposes and to demonstrate basic concepts of relational databases, such as basic `SELECT` statements, joins, `1:N` relationships, hierarchical data structures, etc.

**Note that all files are UTF-8 encoded!**

## Sample output

```sql
 employee_id | first_name | last_name | job_title | manager_id | hire_date  |  salary  | commission | department_id
-------------+------------+-----------+-----------+------------+------------+----------+------------+---------------
        1238 | John       | King      | President |            | 2015-05-14 | 10000.00 |            |             1
        1346 | Greg       | Edelstein | Manager   |       1238 | 2016-06-17 |  8000.00 |            |             2
        1257 | Joseph     | Maka      | Sales Rep |       1456 | 2015-05-20 |  6000.00 |    1000.00 |             2
        1387 | Erin       | Smith     | Manager   |       1238 | 2017-02-04 |  6000.00 |            |             3
        1456 | James      | Greed     | Manager   |       1346 | 2018-03-12 |  5000.00 |            |             2
        1541 | Judy       | Mason     | Manager   |       1346 | 2019-05-23 |  4450.00 |            |             2
        1512 | Alastair   | Walker    | Sales Rep |       1541 | 2018-07-24 |  3000.00 |     750.00 |             2
        1362 | Andrew     | Counters  | Analyst   |       1238 | 2016-11-03 |  3000.00 |            |             4
        1317 | Graham     | Cash      | Sales Rep |       1456 | 2015-12-08 |  3000.00 |    1500.00 |             2
        1423 | Amanda     | Tunsa     | Sales Rep |       1456 | 2018-02-12 |  3000.00 |    1000.00 |             2
        1565 | Sarah      | Bean      | Analyst   |       1238 | 2019-10-22 |  2000.00 |            |             4
        1603 | Gerald     | Venzl     | Sales Rep |       1541 | 2020-04-02 |  2000.00 |     500.00 |             2
        1394 | Monica     | Point     | Associate |       1387 | 2017-05-13 |  1200.00 |            |             3
        1404 | Mark       | Powers    | Associate |       1387 | 2018-01-14 |  1000.00 |            |             3
```

## Data model

### Table `departments`

```sql
Table: departments
+---------------+-------------+------+-----+---------+-------+
| Field         | Type        | Null | Key | Default | Extra |
+---------------+-------------+------+-----+---------+-------+
| department_id | smallint    | NO   | PRI | NULL    |       |
| name          | varchar(10) | NO   |     | NULL    |       |
| location      | varchar(8)  | NO   |     | NULL    |       |
+---------------+-------------+------+-----+---------+-------+
```

#### Field descriptions

| Field     | Description | Length | Mandatory |
| --------- | ----------- | ------ | --------- |
| department_id | The primary key for a department. | SMALLINT (usually a 2 byte integer with -32768 to +32767 range) | Yes |
| name      | The name of a department. | 10 characters | Yes |
| location | The location of a department. | 8 characters | Yes |

### Table `employees`

```sql
Table: employees
+---------------+--------------+------+-----+---------+-----------------------------------------+
| Field         | Type         | Null | Key | Default | Extra                                   |
+---------------+--------------+------+-----+---------+-----------------------------------------+
| employee_id   | smallint     | NO   | PRI | NULL    |                                         |
| first_name    | varchar(8)   | YES  |     | NULL    |                                         |
| last_name     | varchar(9)   | NO   |     | NULL    |                                         |
| job_title     | varchar(9)   | YES  |     | NULL    |                                         |
| manager_id    | smallint     | YES  | MUL | NULL    | Foreign key to employees.employee_id    |
| hire_date     | date         | NO   |     | NULL    |                                         |
| salary        | numeric(7,2) | NO   |     | NULL    |                                         |
| commission    | numeric(7,2) | YES  |     | NULL    |                                         |
| department_id | smallint     | NO   | MUL | NULL    | Foreign key to deparments.department_id |
+---------------+--------------+------+-----+---------+-----------------------------------------+
```

#### Field descriptions

| Field     | Description | Length | Mandatory |
| --------- | ----------- | ------ | --------- |
| employee_id | The primary key for an employee. | SMALLINT (usually a 2 byte integer with -32768 to +32767 range) | Yes |
| first\_name | The first name of an employee. | 8 characters | No |
| last\_name | The last name of an employee. | 9 characters | Yes |
| job\_title | The job title of an employee | 9 characters | No |
| manager\_id | The employee\_id of the employee's manager. | SMALLINT (usually a 2 byte integer with -32768 to +32767 range) | No |
| hire\_date | The hire date of an employee | DATE (YYYY-MM-DD) | Yes |
| salary | The annual base salary of an employee. | A number with a precision of 7 and scale of 2 digits: NNNNN.MM | Yes |
| commission | The annual commission of an employee. | A number with a precision of 7 and scale of 2 digits: NNNNN.MM | No |
| department\_id | The department\_id of an employee and foreign key to the `departments` table. | SMALLINT (usually a 2 byte integer with -32768 to +32767 range) | Yes| 

## Files

| File name | Description |
| --------- | ------------|
| [departments.csv](departments.csv) | Comma separated file with departments data. |
| [employees.csv](employees.csv) | Comma separated file with employees data. |
| [install.oracle.sql](install.oracle.sql) | Setup file for Oracle database. |
| [install.sql](install.sql) | Setup file for PostgreSQL, MySQL, SQL Server, Db2. |
| [uninstall.sql](uninstall.sql) | Uninstall file for all databases. |

## Database install instructions

Connect to your database of choice and execute the `install.sql` file.  

**Note**: there is a separate file for **Oracle** `install.oracle.sql`

### MySQL
```bash
mysql> source install.sql
```

### Postgres
```bash
db=> \i install.sql
```

### Oracle Database
```bash
SQL> @install.oracle.sql
```

### SQL Server
```bash
1> :r install.sql
2> go
```

### Db2
```bash
$ db2 -tvmf install.sql
```

## Database uninstall instructions

Connect to your database of choice and execute the `uninstall.sql` file.

### MySQL
```bash
mysql> source uninstall.sql
```

### Postgres
```bash
db=> \i uninstall.sql
```

### Oracle Database
```bash
SQL> @uninstall.sql
```

### SQL Server
```bash
1> :r uninstall.sql
2> go
```

### Db2
```bash
$ db2 -tvmf uninstall.sql
```

## Data sources
This data set is fictional and does not have any data sources.
