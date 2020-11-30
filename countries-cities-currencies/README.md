# countries-cities-currencies
This data set contains a list of all the world's countries, capital cities and currencies. It contains:

* 7 regions
* 196 countries
* 201 capital cities
* 146 currencies

The data model is created in a way that lets you add additional data. For example, the table `cities` is designed in a way so that you can add additional cities to the provided capitals.

**All files are UTF-8 encoded.**

## Data model

```sql
Table: regions
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| region_id | varchar(2)  | NO   | PRI | NULL    |       |
| name      | varchar(13) | NO   |     | NULL    |       |
+-----------+-------------+------+-----+---------+-------+
```

```sql
Table: countries
+---------------+---------------+------+-----+---------+----------------------------------+
| Field         | Type          | Null | Key | Default | Extra                            |
+---------------+---------------+------+-----+---------+----------------------------------+
| country_id    | varchar(3)    | NO   | PRI | NULL    |                                  |
| country_code  | varchar(2)    | NO   |     | NULL    |                                  |
| name          | varchar(100)  | NO   |     | NULL    |                                  |
| official_name | varchar(200)  | YES  |     | NULL    |                                  |
| population    | numeric(10,0) | YES  |     | NULL    |                                  |
| area_sq_km    | numeric(10,2) | YES  |     | NULL    |                                  |
| latitude      | numeric(8,5)  | YES  |     | NULL    |                                  |
| longitude     | numeric(8,5)  | YES  |     | NULL    |                                  |
| timezone      | varchar(40)   | YES  |     | NULL    |                                  |
| region_id     | varchar(2)    | NO   | MUL | NULL    | Foreign key to regions.region_id |
+---------------+---------------+------+-----+---------+----------------------------------+
```

```sql
Table: cities
+---------------+--------------+------+-----+---------+-------------------------------------+
| Field         | Type         | Null | Key | Default | Extra                               |
+---------------+--------------+------+-----+---------+-------------------------------------+
| city_id       | varchar(7)   | NO   | PRI | NULL    |                                     |
| name          | varchar(100) | NO   |     | NULL    |                                     |
| official_name | varchar(200) | YES  |     | NULL    |                                     |
| population    | numeric(8,0) | YES  |     | NULL    |                                     |
| is_capital    | char(1)      | NO   |     | 'N'     | Allowed values ('Y','N')            |
| latitude      | numeric(8,5) | YES  |     | NULL    |                                     |
| longitude     | numeric(8,5) | YES  |     | NULL    |                                     |
| timezone      | varchar(40)  | YES  |     | NULL    |                                     |
| country_id    | varchar(3)   | NO   | MUL | NULL    | Foreign key to countries.country_id |
+---------------+--------------+------+-----+---------+-------------------------------------+
```

```sql
Table: currencies
+---------------+--------------+------+-----+---------+-------+
| Field         | Type         | Null | Key | Default | Extra |
+---------------+--------------+------+-----+---------+-------+
| currency_id   | varchar(3)   | NO   | PRI | NULL    |       |
| name          | varchar(50)  | NO   |     | NULL    |       |
| official_name | varchar(200) | YES  |     | NULL    |       |
| symbol        | varchar(6)   | NO   |     | NULL    |       |
+---------------+--------------+------+-----+---------+-------+
```

```sql
Table: currencies_countries
+-------------+------------+------+-----+---------+-------+
| Field       | Type       | Null | Key | Default | Extra |
+-------------+------------+------+-----+---------+-------+
| currency_id | varchar(3) | NO   | PRI | NULL    |       |
| country_id  | varchar(3) | NO   | PRI | NULL    |       |
+-------------+------------+------+-----+---------+-------+
```

## Files
| File name | Description |
| --------- | ------------|
| [cities.csv](cities.csv) | Comma separated file with cities data |
| [countries.csv](countries.csv) | Comma separated file with countries	 data |
| [currencies.csv](currencies.csv) | Comma separated file with currencies data |
| [regions.csv](regions.csv) | Comma separated file with regions data |


## Database install instructions

Connect to your database of choice and execute the `install.sql` file.  

### MySQL
Please make sure that your connections is using the `utf8mb4` characterset.  
You can do so by passing on the `--default-character-set=utf8mb4` option to the command line, e.g.: `mysql -u <your user> -p<your password> -D <your database> --default-character-set=utf8mb4`

```bash
mysql> source install.sql
```

### Postgres
```bash
db=> \i install.sql
```

### Oracle Database
```bash
SQL> @install.sql
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

# Acknowledgments
***The data here is provided with the generous help of my gorgeous wife Federica Venzl.***

## Data sources
The data sources for this data set are:

* National Geographic Atlas of the World, 11th Edition, October 2019 (ISBN-13: 978-1426220586)
* [GeoNames.org](https://www.geonames.org/)
