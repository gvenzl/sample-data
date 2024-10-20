# national-parks
This data set contains a list of national parks:

* 472 United States national parks
* 40 activities
* 4 contact types
* 1142 contacts
* 4029 park-activity mappings

The data model is designed to allow users to add additional data on their own, if desired.

**Note that all files are UTF-8 encoded!**

## Data model

### Table `activities`

Contains activities that can be performed in a park.

```sql
Table: activities
+-------------+-------------+------+-----+---------+-------+
| Field       | Type        | Null | Key | Default | Extra |
+-------------+-------------+------+-----+---------+-------+
| activity_id | varchar(36) | NO   | PRI |         |       |
| name        | varchar(25) | NO   |     |         |       |
+-------------+-------------+------+-----+---------+-------+
```

#### Field descriptions

| Field       | Description | Length | Mandatory |
| ----------- | ----------- | ------ | --------- |
| activity_id | The primary key for an activity using a UUID. | 36 characters | Yes |
| name        | The name of an activity. | 255 characters | Yes |

### Table `contact_types`

Contains contact types.

```sql
Table: contact_types
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| contact_type_id | numeric     | NO   | PRI |         |       |
| name            | varchar(25) | NO   |     |         |       |
+-----------------+-------------+------+-----+---------+-------+
```

#### Field descriptions

| Field     | Description | Length | Mandatory |
| --------- | ----------- | ------ | --------- |
| contact\_type\_id | The primary key for contact type. | A number with an undefined precision | Yes |
| name      | The name of a contact type. | 25 characters | Yes |

### Table `contacts`

Contains park contact information.

```sql
Table: contacts
+-----------------+---------------+------+-----+---------+------------------------------+
| Field           | Type          | Null | Key | Default | Extra                        |
+-----------------+---------------+------+-----+---------+------------------------------+
| contact_id      | numeric       | NO   | PRI |         |                              |
| contact         | varchar(100)  | NO   |     |         |                              |
| contact_type_id | numeric       | NO   |     |         |                              |
| park_id         | varchar(36)   | NO   | MUL |         | Foreign key to parks.park_id |
+-----------------+---------------+------+-----+---------+------------------------------+
```
#### Field descriptions

| Field | Description | Length | Mandatory |
| ----- | ----------- | ------ | --------- |
| contact_id | The primary key for a contact. | A number with an undefined precision | Yes |
| contact    | The contact information (could be a phone number, email address, etc.) | 100 characters | Yes |
| contact\_type\_id | The contact\_type\_id of a contact type and foreign key entry to the `contact_types` table. | A number with an undefined precision | Yes |
| park_id | The park_id of a contact type and foreign key entry to the `parks` table.| 36 characters | Yes |

### Table `parks`

Contains the national parks and some additional data points such as the park URL, description, longitude and latitude.

```sql
Table: parks
+-----------------+----------------+------+-----+---------+-------------------------------------+
| Field           | Type           | Null | Key | Default | Extra                               |
+-----------------+----------------+------+-----+---------+-------------------------------------+
| park_id         | varchar(36)    | NO   | PRI |         |                                     |
| park_code       | varchar(4)     | YES  |     |         |                                     |
| name            | varchar(255)   | NO   |     |         |                                     |
| full_name       | varchar(1000)  | YES  |     |         |                                     |
| url             | varchar(255)   | YES  |     |         |                                     |
| description     | varchar(1000)  | YES  |     |         |                                     |
| designation     | varchar(1000)  | YES  |     |         |                                     |
| latitude        | numeric(13,10) | YES  |     |         |                                     |
| longitude       | numeric(13,10) | YES  |     |         |                                     |
| states          | varchar(100)   | YES  |     |         |                                     |
| directions_info | varchar(1000)  | YES  |     |         |                                     |
| directions_url  | varchar(255)   | YES  |     |         |                                     |
| weather_info    | varchar(1000)  | YES  |     |         |                                     |
| country_id      | varchar(3)     | NO   | MUL |         | Foreign key to countries.country_id |
+-----------------+----------------+------+-----+---------+-------------------------------------+
```

#### Field descriptions

| Field | Description | Length | Mandatory |
| ----- | ----------- | ------ | --------- |
| park_id | The primary key for a park using a UUID. | 36 characters | Yes |
| park_code | The park code assigned by the park agency. | 4 characters | No |
| name | The official name of a park. | 255 characters | Yes |
| full_name | The full official name of a park. | 1000 characters | No
| url | The web url (website) of a park. | 255 characters | No |
| description | The description of the park. | 1000 characters | No |
| designation | The designation of the park given by the park agency. | 1000 characters | No |
| latitude | The latitude of a park expressed in [decimal degrees](https://en.wikipedia.org/wiki/Decimal_degrees), pointing to the average middle of the park. | A number with a precision of 13 and scale of 10 digits: NNN.MMMMMMMMMM | No |
| longitude | The longitude of a park expressed in [decimal degrees](https://en.wikipedia.org/wiki/Decimal_degrees), pointing to the average middle of park city. | A number with a precision of 13 and scale of 10 digits: NNN.MMMMMMMMMM | No |
| states| For countries that have states or provinces, this column contains a comma separated list of states, provinces, etc. where the park is located in. | 100 characters | No |
| directions_info | Directions to get to the park. | 1000 characters | No |
| directions_url | The web url (websites) to get directions to the park. | 255 characters | No |
| weather_info | Information about the average weather at the park. | 1000 characters | No |
| country_id | The country_id of a park and foreign key entry to the `countries` table, if present. | 3 characters | Yes |

### Table `parks_activities`

Contains mappings between parks and activities.

```sql
Table: activities
+-------------+-------------+------+-----+---------+---------------------------------------+
| Field       | Type        | Null | Key | Default | Extra                                 |
+-------------+-------------+------+-----+---------+---------------------------------------+
| park_id     | varchar(36) | NO   | PRI |         | Foreign key to parks.park_id          |
| activity_id | varchar(36) | NO   | PRI |         | Foreign key to activities.activity_id |
+-------------+-------------+------+-----+---------+---------------------------------------+
```

#### Field descriptions

| Field       | Description | Length | Mandatory |
| ----------- | ----------- | ------ | --------- |
| park_id     | The primary key for a park using a UUID. | 36 characters | Yes |
| activity_id | The primary key for an activity using a UUID. | 36 characters | Yes |

## Files

| File name | Description |
| --------- | ------------|
| [install.sql](install.sql) | SQL file to install this data set in a database. |
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

## Data sources
The data sources for this data set are:

* [US National Park Services](https://www.nps.gov/aboutus/disclaimer.htm)
