# national-parks
This data set contains a list of United States national parks:

* 472 United States national parks and monuments
* 40 activities
* 4 contact types
* 1,142 contacts
* 4,029 park-activity mappings
* 172,506 images

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
| name        | varchar(21) | NO   |     |         |       |
+-------------+-------------+------+-----+---------+-------+
```

#### Field descriptions

| Field       | Description | Length | Mandatory |
| ----------- | ----------- | ------ | --------- |
| activity_id | The primary key for an activity using a UUID. | 36 characters | Yes |
| name        | The name of an activity. | 21 characters | Yes |

### Table `contact_types`

Contains types of contact with a park.

```sql
Table: contact_types
+-----------------+-------------+------+-----+---------+-------+
| Field           | Type        | Null | Key | Default | Extra |
+-----------------+-------------+------+-----+---------+-------+
| contact_type_id | numeric     | NO   | PRI |         |       |
| name            | varchar(16) | NO   |     |         |       |
+-----------------+-------------+------+-----+---------+-------+
```

#### Field descriptions

| Field             | Description | Length | Mandatory |
| ----------------- | ----------- | ------ | --------- |
| contact\_type\_id | The primary key for contact type. | A number with an undefined precision and scale | Yes |
| name              | The name of a contact type. | 16 characters | Yes |

### Table `contacts`

Contains park contact information.

```sql
Table: contacts
+-----------------+--------------+------+-----+---------+------------------------------+
| Field           | Type         | Null | Key | Default | Extra                        |
+-----------------+--------------+------+-----+---------+------------------------------+
| contact_id      | numeric      | NO   | PRI |         |                              |
| contact         | varchar(44)  | NO   |     |         |                              |
| contact_type_id | numeric      | NO   |     |         |                              |
| park_id         | varchar(36)  | NO   | FK  |         | Foreign key to parks.park_id |
+-----------------+--------------+------+-----+---------+------------------------------+
```
#### Field descriptions

| Field             | Description | Length | Mandatory |
| ----------------- | ----------- | ------ | --------- |
| contact_id        | The primary key for a contact. | A number with an undefined precision | Yes |
| contact           | The contact information (could be a phone number, email address, etc.) | 44 characters | Yes |
| contact\_type\_id | The contact\_type\_id of a contact type and foreign key entry to the `contact_types` table. | A number with an undefined precision | Yes |
| park_id           | The park_id of a contact type and foreign key entry to the `parks` table.| 36 characters | Yes |

### Table `parks`

Contains the national parks and some additional data points such as the park URL, description, longitude and latitude.

```sql
Table: parks
+-----------------+----------------+------+-----+---------+-------+
| Field           | Type           | Null | Key | Default | Extra |
+-----------------+----------------+------+-----+---------+-------+
| park_id         | varchar(36)    | NO   | PRI |         |       |
| park_code       | varchar(4)     | NO   |     |         |       |
| name            | varchar(51)    | NO   |     |         |       |
| full_name       | varchar(74)    | YES  |     |         |       |
| url             | varchar(34)    | YES  |     |         |       |
| description     | varchar(408)   | YES  |     |         |       |
| designation     | varchar(48)    | YES  |     |         |       |
| latitude        | numeric(13,10) | YES  |     |         |       |
| longitude       | numeric(13,10) | YES  |     |         |       |
| states          | varchar(47)    | YES  |     |         |       |
| directions_info | varchar(512)   | YES  |     |         |       |
| directions_url  | varchar(162)   | YES  |     |         |       |
| weather_info    | varchar(520)   | YES  |     |         |       |
| country_id      | varchar(3)     | NO   |     |         |       |
+-----------------+----------------+------+-----+---------+-------+
```

#### Field descriptions

| Field           | Description | Length | Mandatory |
| --------------- | ----------- | ------ | --------- |
| park_id         | The primary key for a park using a UUID. | 36 characters | Yes |
| park_code       | The park code assigned by the park agency. | 4 characters | Yes |
| name            | The official name of a park. | 51 characters | Yes |
| full_name       | The full official name of a park. | 74 characters | No
| url             | The web url (website) of a park. | 34 characters | No |
| description     | The description of the park. | 408 characters | No |
| designation     | The designation of the park given by the park agency. | 48 characters | No |
| latitude        | The latitude of a park expressed in [decimal degrees](https://en.wikipedia.org/wiki/Decimal_degrees), pointing to the average middle of the park. | A number with a precision of 13 and scale of 10 digits: NNN.MMMMMMMMMM | No |
| longitude       | The longitude of a park expressed in [decimal degrees](https://en.wikipedia.org/wiki/Decimal_degrees), pointing to the average middle of park city. | A number with a precision of 13 and scale of 10 digits: NNN.MMMMMMMMMM | No |
| states| For countries that have states or provinces, this column contains a comma separated list of states, provinces, etc. where the park is located in. | 47 characters | No |
| directions_info | Directions to get to the park. | 512 characters | No |
| directions_url  | The web url (websites) to get directions to the park. | 162 characters | No |
| weather_info    | Information about the average weather at the park. | 520 characters | No |
| country_id      | The country_id of a park and foreign key entry to the `countries` table, if present (not default). | 3 characters | Yes |

### Table `parks_activities`

Contains mappings between parks and activities.

```sql
Table: parks_activities
+-------------+-------------+------+---------+---------+---------------------------------------+
| Field       | Type        | Null | Key     | Default | Extra                                 |
+-------------+-------------+------+---------+---------+---------------------------------------+
| park_id     | varchar(36) | NO   | PRI, FK |         | Foreign key to parks.park_id          |
| activity_id | varchar(36) | NO   | PRI, FK |         | Foreign key to activities.activity_id |
+-------------+-------------+------+---------+---------+---------------------------------------+
```

#### Field descriptions

| Field       | Description | Length | Mandatory |
| ----------- | ----------- | ------ | --------- |
| park_id     | The park_id of a park and foreign key entry to the `parks` table. | 36 characters | Yes |
| activity_id | The activity_id of an activity and foreign key entry to the `activities` table. | 36 characters | Yes |

### Table `images`

Contains information about images taken in the parks.

```sql
Table: images
+--------------------------+---------------+------+-----+---------+------------------------------+
| Field                    | Type          | Null | Key | Default | Extra                        |
+--------------------------+---------------+------+-----+---------+------------------------------+
| image_id                 | varchar(36)   | NO   | PRI |         |                              |
| gallery_id               | varchar(36)   | NO   | PRI |         |                              |
| title                    | varchar(257)  | YES  |     |         |                              |
| description              | varchar(8498) | YES  |     |         |                              |
| alt_text                 | varchar(1338) | YES  |     |         |                              |
| url                      | varchar(86)   | YES  |     |         |                              |
| permalink_url            | varchar(134)  | YES  |     |         |                              |
| tags                     | varchar(759)  | YES  |     |         |                              |
| file_type                | varchar(10)   | YES  |     |         |                              |
| width_pixels             | numeric(5,0)  | YES  |     |         |                              |
| height_pixels            | numeric(5,0)  | YES  |     |         |                              |
| file_size_bytes          | numeric(9,0)  | YES  |     |         |                              |
| credit                   | varchar(50)   | YES  |     |         |                              |
| copyright                | varchar(546)  | YES  |     |         |                              |
| copyright_constraint     | varchar(68)   | YES  |     |         |                              |
| copyright_granted_rights | varchar(7)    | YES  |     |         |                              |
| park_code                | varchar(4)    | YES  |     |         |                              |
| park_id                  | varchar(36)   | NO   | FK  |         | Foreign key to parks.park_id |
+-------------+-------------+------+---------+----------+----------------------------------------+
```

#### Field descriptions

| Field                      | Description | Length | Mandatory |
| -------------------------- | ----------- | ------ | --------- |
| image_id                   | The image id and partial primary key for a park image using a UUID. | 36 characters | Yes |
| gallery_id                 | The image gallery id and partial primary key for an image using a UUID. | 36 characters | Yes |
| title                      | The image title. | 257 characters | No |
| description                | The image description. | 8498 characters | No |
| alt_text                   | The alternative text of the image. | 1338 characters | No | 
| url                        | The URL of the image file. | 86 characters | No |
| permalink_url              | The permalink URL of the image file. | 134 characters | No |
| tags                       | Tags associated with the content of the image. | 759 characters | No |
| file_type                  | The image file type. | 10 characters | No |
| width_pixels               | The width of the image in pixels. | A number with a precision of 5 digits and a scale of 0 | No |
| height_pixels              | The height of the image in pixels. | A number with a precision of 5 digits and a scale of 0 | No |
| file\_size\_bytes          | The image file size in bytes. | A number with a precision of 9 digits and a scale of 0 | No |
| credit                     | The image author credits. | 50 characters | No |
| copyright                  | The image copyright. | 546 characters | No |
| copyright_constraint       | The image copyright constraint for usage of the image. | 68 characters | No |
| copyright\_granted\_rights | The image copyright grants given. | 7 characters | No |
| park_code                  | The park code assigned by the park agency. | 4 characters | No |
| park_id                    | The primary key for a park using a UUID. | 36 characters | Yes |

## Files

| File name                                    | Description |
| -------------------------------------------- | ------------|
| [activities.csv](activities.csv)             | Comma separated file with activities data. |
| [contact_types.csv](contact_types.csv)       | Comma separated file with contact types data. |
| [contacts.csv](contacts.csv)                 | Comma separated file with contacts data. |
| [images.csv.gz](images.csv.gz)               | GZip compressed comma separated file with images data. |
| [install.oracle.sql](install.oracle.sql)     | SQL file to install this data set in an Oracle Database. |
| [install.sql.gz](install.sql.gz)             | GZip compressed SQL file to install this data set in a database. |
| [parks.csv](parks.csv)                       | Comma separated file with parks data. |
| [parks_activities.csv](parks_activities.csv) | Comma separated file with park activities data. |
| [uninstall.sql](uninstall.sql)               | SQL file to uninstall this data set from a database. |
| [utils](utils)                               | A directory with utilities to generate this data set. |

## Database install instructions

### Uncompress the install.sql.gz file

Uncompress the install.sql.gz file.

```bash
gunzip install.sql.gz
```

Then, connect to your database of choice via the command prompt and execute the `install.sql` file.

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
