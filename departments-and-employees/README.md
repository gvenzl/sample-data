# departments-and-employees

This data set contains ***fictional*** departments and employees data. It can be used for educational purposes and to demonstrate basic concepts of relational databases, such as basic `SELECT` statements, joins, `1:N` relationships, hierarchical data structures, etc.

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
```sql
Table: employees
+---------------+--------------+------+-----+---------+-------+
| Field         | Type         | Null | Key | Default | Extra |
+---------------+--------------+------+-----+---------+-------+
| employee_id   | smallint     | NO   | PRI | NULL    |       |
| first_name    | varchar(8)   | YES  |     | NULL    |       |
| last_name     | varchar(9)   | NO   |     | NULL    |       |
| job_title     | varchar(9)   | YES  |     | NULL    |       |
| manager_id    | smallint     | YES  | MUL | NULL    |       |
| hire_date     | date         | NO   |     | NULL    |       |
| salary        | numeric(7,2) | NO   |     | NULL    |       |
| commission    | numeric(7,2) | YES  |     | NULL    |       |
| department_id | smallint     | NO   | MUL | NULL    |       |
+---------------+--------------+------+-----+---------+-------+
```

## Files
| File name | Description |
| --------- | ------------|
| [departments.csv](departments.csv) | Comma separated file with departments data |
| [employees.csv](employees.csv) | Comma separated file with employees data |
| [install.mysql.sql](install.mysql.sql) | Setup file for MySQL |
| [install.oracle.sql](install.oracle.sql) | Setup file for Oracle database |
| [install.sql](install.sql) | Setup file for PostgreSQL, SQL Server, Db2 |
| [uninstall.sql](uninstall.sql) | Uninstall file for all databases |

## Database install instructions

Connect to your database of choice and execute the `install.sql` file.  

**Note**: there is a separate file for **MySQL** `install.mysql.sql` and for **Oracle** `install.oracle.sql`

### MySQL
```bash
mysql> source install.mysql.sql
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

Connect to your database of choice and execute the `uninstall.sql` file. Follow the same approach as described in the **Database install instructions**.