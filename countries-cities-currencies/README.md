# countries-cities-currencies
This data set contains a list of all the countries in the world, their capital cities and official currencies used. It includes data for:

* 7 global regions
* 196 countries
* 204 capital cities
* 146 currencies
* 203 currency to country mappings

The data model is designed to allow users to add additional data on their own, if desired.

**Note that all files are UTF-8 encoded!**

## Data model

### Table `regions`

Contains 7 geographical regions.

```sql
Table: regions
+-----------+-------------+------+-----+---------+-------+
| Field     | Type        | Null | Key | Default | Extra |
+-----------+-------------+------+-----+---------+-------+
| region_id | varchar(2)  | NO   | PRI |         |       |
| name      | varchar(13) | NO   |     |         |       |
+-----------+-------------+------+-----+---------+-------+
```

#### Field descriptions

| Field     | Description | Length | Mandatory |
| --------- | ----------- | ------ | --------- |
| region_id | The primary key for a region. | 2 characters | Yes |
| name      | The name of the region. | 13 characters | Yes |

### Table `countries`

Contains the world's countries and some additional data points such as population and the area in square kilometers.

```sql
Table: countries
+---------------+---------------+------+-----+---------+----------------------------------+
| Field         | Type          | Null | Key | Default | Extra                            |
+---------------+---------------+------+-----+---------+----------------------------------+
| country_id    | varchar(3)    | NO   | PRI |         |                                  |
| country_code  | varchar(2)    | NO   |     |         |                                  |
| name          | varchar(100)  | NO   |     |         |                                  |
| official_name | varchar(200)  | YES  |     |         |                                  |
| population    | numeric(10)   | YES  |     |         |                                  |
| area_sq_km    | numeric(10,2) | YES  |     |         |                                  |
| latitude      | numeric(8,5)  | YES  |     |         |                                  |
| longitude     | numeric(8,5)  | YES  |     |         |                                  |
| timezone      | varchar(40)   | YES  |     |         |                                  |
| region_id     | varchar(2)    | NO   | MUL |         | Foreign key to regions.region_id |
+---------------+---------------+------+-----+---------+----------------------------------+
```
#### Field descriptions

| Field | Description | Length | Mandatory |
| ----- | ----------- | ------ | --------- |
| country_id | The primary key for a country using the three-letter country code as specified in the [ISO 3166-1 alpha -3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) standard. | 3 characters | Yes |
| country_code | The two-letter country code for a country as specified in the [ISO 3166-1 alpha -2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) standard. | 2 characters | Yes |
| name | The common name of a country, excluding any non-ascii character such as region specific accents and apostrophes. | 100 characters | Yes |
| official_name | The official name of a country. If the country's common and official name are the same, this field may be empty. This field also *includes* region specific accents and apostrophes in the name.| 200 characters | No |
| population | The population of a country. | Integer with up to 10 digits | No |
| area\_sq\_km | The area of a country measured in square kilometers (km2). | A number with a precision of 10 and scale of 2 digits, i.e. up to 10 digits in total where 2 of them are to the right of the decimal point: NNNNNNNN.MM  | No |
| latitude | The latitude of a country expressed in [decimal degrees](https://en.wikipedia.org/wiki/Decimal_degrees), pointing to the average middle of the country. | A number with a precision of 8 and scale of 5 digits: NN.MMMMM | No |
| longitude | The longitude of a country expressed in [decimal degrees](https://en.wikipedia.org/wiki/Decimal_degrees), pointing to the average middle of the country. | A number with a precision of 8 and scale of 5 digits: NN.MMMMM | No |
| timezone | The time zone name of a given country. If a country spans multiple time zones, this field will be empty. | 40 characters | No |
| region_id | The region_id of a country and foreign key entry to the `regions` table. | 2 characters | Yes |

### Table `cities`

Contains the capital cities of a country and some additional data points such as population and longitude and latitude.

```sql
Table: cities
+---------------+--------------+------+-----+---------+-------------------------------------+
| Field         | Type         | Null | Key | Default | Extra                               |
+---------------+--------------+------+-----+---------+-------------------------------------+
| city_id       | varchar(7)   | NO   | PRI |         |                                     |
| name          | varchar(100) | NO   |     |         |                                     |
| official_name | varchar(200) | YES  |     |         |                                     |
| population    | numeric(8)   | YES  |     |         |                                     |
| is_capital    | char(1)      | NO   |     | 'N'     | Allowed values ('Y','N')            |
| latitude      | numeric(8,5) | YES  |     |         |                                     |
| longitude     | numeric(8,5) | YES  |     |         |                                     |
| timezone      | varchar(40)  | YES  |     |         |                                     |
| country_id    | varchar(3)   | NO   | MUL |         | Foreign key to countries.country_id |
+---------------+--------------+------+-----+---------+-------------------------------------+
```

#### Field descriptions

| Field | Description | Length | Mandatory |
| ----- | ----------- | ------ | --------- |
| city_id | The primary key for a city using a combination of the three-letter country_id and an ascending four digit number, e.g `AUT0001` = `AUT` + `0001` for Vienna. | 7 characters | Yes |
| name | The common name of a city, excluding any non-ascii character such as region specific accents and apostrophes. | 100 characters | Yes |
| official_name | The official name of a city. If the city's common and official name are the same, this field may be empty. This field also *includes* region specific accents and apostrophes in the name. | 200 characters | No |
| population | The population of a city. | Integer with up to 8 digits | No
| is_capital | A flag to indicate whether a city is a capital city or not, allowing only the values `Y` and `N` with the default value of `N`. All capital cities in this data set have this flag set to `Y`. However, you may want to add additional cities to the data set. | 1 character | Yes |
| latitude | The latitude of a city expressed in [decimal degrees](https://en.wikipedia.org/wiki/Decimal_degrees), pointing to the average middle of the city. | A number with a precision of 8 and scale of 5 digits: NN.MMMMM | No |
| longitude | The longitude of a city expressed in [decimal degrees](https://en.wikipedia.org/wiki/Decimal_degrees), pointing to the average middle of the city. | A number with a precision of 8 and scale of 5 digits: NN.MMMMM | No |
| timezone | The time zone name of a given city. If a city spans multiple time zones, this field may be empty. | 40 characters | No |
| country_id | The country_id of a city and foreign key entry to the `countries` table. | 3 characters | Yes |

### Table `currencies`

Contains the world's currencies, official names and symbols.

```sql
Table: currencies
+---------------+--------------+------+-----+---------+-------+
| Field         | Type         | Null | Key | Default | Extra |
+---------------+--------------+------+-----+---------+-------+
| currency_id   | varchar(3)   | NO   | PRI |         |       |
| name          | varchar(50)  | NO   |     |         |       |
| official_name | varchar(200) | YES  |     |         |       |
| symbol        | varchar(18)  | NO   |     |         |       |
+---------------+--------------+------+-----+---------+-------+
```

#### Field descriptions

| Field | Description | Length | Mandatory |
| ----- | ----------- | ------ | --------- |
| currency_id | The primary key for a currency using the three-letter alpha code as specified by the [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) standard. | 3 characters | Yes |
| name | The name of a currency, excluding any non-ascii character such as region specific accents and apostrophes. | 50 characters | Yes |
| official_name | The official name of a currency, *including* region specific accents and apostrophes in the name. | 200 characters | No |
| symbol | The currency symbol encoded in UTF-8. | 18 characters long | Yes |

### Table `currencies_countries`

Because some countries have more than one official currency, the data model uses an M:N mapping between countries and currencies.

```sql
Table: currencies_countries
+-------------+------------+------+-----+---------+---------------------------------------+
| Field       | Type       | Null | Key | Default | Extra                                 |
+-------------+------------+------+-----+---------+---------------------------------------+
| currency_id | varchar(3) | NO   | PRI |         | Foreign key to currencies.currency_id |
| country_id  | varchar(3) | NO   | PRI |         | Foreign key to countries.country_id   |
+-------------+------------+------+-----+---------+---------------------------------------+
```

#### Field descriptions

| Field       | Description | Length | Mandatory |
| ----------- | ----------- | ------ | --------- |
| currency_id | The composite primary key and foreign key to the `currencies` table. | 3 characters | Yes |
| country_id  | The composite primary key and foreign key to the `countries` table. | 3 characters | Yes |

## Files
| File name | Description |
| --------- | ------------|
| [cities.csv](cities.csv) | Comma separated file with cities data. |
| [countries.csv](countries.csv) | Comma separated file with countries	 data. |
| [currencies.csv](currencies.csv) | Comma separated file with currencies data. |
| [currencies_countries.csv](currencies_countries.csv) | Comma separated file with currencies per country data. |
| [install.sql](install.sql) | SQL file to install this data set in a database. |
| [regions.csv](regions.csv) | Comma separated file with regions data. |
| [uninstall.sql](uninstall.sql) | SQL file to uninstall this data set from a database. |


## Database install instructions

Connect to your database of choice via the command prompt and execute the `install.sql` file.  

### MySQL
Please make sure that your connections is using the `utf8mb4` character set.  
You can do so by passing on the `--default-character-set=utf8mb4` option to the command line, e.g.: `mysql --default-character-set=utf8mb4 -u <your user> -p<your password> -D <your database>`

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

Connect to your database of choice via the command prompt and execute the `uninstall.sql` file.  

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
