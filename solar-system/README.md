# solar-system
This data set contains information about our great solar system:

* 1 star
* 9 planets

This data set does not concern itself with the definition of a planet vs. a dwarf planet.
Sufficient discussion and disagreement is still ongoing in the [International Astronomical Union (IAU)](https://www.iau.org/)
about its [2006 definition of planets](https://en.wikipedia.org/wiki/IAU_definition_of_planet)
and what it applies to and what not, that no purpose is served for this data set to try to
adhere to that definition.
Therefore, this data set just includes on table "planets" with the intention to be
generic enough for users to be able to store any kind of planet (dwarf, exo, rouge, etc.) in it.

**Note that all files are UTF-8 encoded!**

## Data model

### Table `metadata`

```sql
Table: metadata
+-------------+---------------+------+-----+---------+-------+
| Field       | Type          | Null | Key | Default | Extra |
+-------------+---------------+------+-----+---------+-------+
| metadata_id | numeric       | NO   | PRI | NULL    |       |
| table_name  | varchar(13)   | NO   |     | NULL    |       |
| column_name | varchar(52)   | NO   |     | NULL    |       |
| meaning     | varchar(4000) | YES  |     | NULL    |       |
+-------------+---------------+------+-----+---------+-------+
```

### Table `stars`

```sql
Table: stars
+------------------------------------------------------+---------------+------+-----+---------+-------+
| Field                                                | Type          | Null | Key | Default | Extra |
+------------------------------------------------------+---------------+------+-----+---------+-------+
| star_id                                              | numeric       | NO   | PRI | NULL    |       |
| name                                                 | varchar(50)   | NO   |     | NULL    |       |
| discoverer                                           | varchar(100)  | YES  |     | NULL    |       |
| dicovery_date                                        | date          | YES  |     | NULL    |       |
| mass_kg_10_exp_24                                    | real          | YES  |     | NULL    |       |
| gm_10_exp_6_km_exp_3_per_s_exp_2                     | real          | YES  |     | NULL    |       |
| volume_10_exp_12_km_exp_3                            | real          | YES  |     | NULL    |       |
| mean_volumetric_radius_km                            | real          | YES  |     | NULL    |       |
| mean_density_kg_per_m_exp_3                          | real          | YES  |     | NULL    |       |
| gravity_m_per_s_exp_2                                | real          | YES  |     | NULL    |       |
| escape_velocity_km_per_s                             | real          | YES  |     | NULL    |       |
| ellipticity                                          | real          | YES  |     | NULL    |       |
| moment_of_inertia_per_mass_radius_exp_2              | real          | YES  |     | NULL    |       |
| vband_magnitude                                      | real          | YES  |     | NULL    |       |
| absolute_magnitude                                   | real          | YES  |     | NULL    |       |
| luminosity_10_exp_24_J_per_s                         | real          | YES  |     | NULL    |       |
| mass_conversion_rate_10_exp_6_kg_per_s               | real          | YES  |     | NULL    |       |
| mean_energy_production_10_exp_minus_3_J_per_kg_s     | real          | YES  |     | NULL    |       |
| surface_emission_10_exp_6_J_per_m_exp_2_s            | real          | YES  |     | NULL    |       |
| spectral_type                                        | varchar(10)   | YES  |     | NULL    |       |
| central_pressure_10_exp_11_bar                       | real          | YES  |     | NULL    |       |
| central_temperature_10_exp_7_K                       | real          | YES  |     | NULL    |       |
| central_density_10_exp_5_kg_per_m_exp_3              | real          | YES  |     | NULL    |       |
| sidereal_rotation_period_hrs                         | real          | YES  |     | NULL    |       |
| obliquity_to_ecliptic_degrees                        | real          | YES  |     | NULL    |       |
| speed_relative_to_nearby_stars_km_per_s              | real          | YES  |     | NULL    |       |
| north_pole_of_rotation_right_ascension               | real          | YES  |     | NULL    |       |
| north_pole_of_rotation_declination                   | real          | YES  |     | NULL    |       |
| north_pole_of_rotation_reference_date                | varchar(35)   | YES  |     | NULL    |       |
| apparent_diameter_from_earth_at_1_AU_s_of_arc        | real          | YES  |     | NULL    |       |
| max_apparent_diameter_from_earth_s_of_arc            | real          | YES  |     | NULL    |       |
| min_apparent_diameter_from_earth_s_of_arc            | real          | YES  |     | NULL    |       |
| mean_distance_from_earth_10_exp_6_km                 | real          | YES  |     | NULL    |       |
| min_distance_from_earth_10_exp_6_km                  | real          | YES  |     | NULL    |       |
| max_distance_from_earth_10_exp_6_km                  | real          | YES  |     | NULL    |       |
| min_magentic_field_strength_polar_field_gauss        | real          | YES  |     | NULL    |       |
| max_magentic_field_strength_polar_field_gauss        | real          | YES  |     | NULL    |       |
| magentic_strength_sunspots_gauss                     | real          | YES  |     | NULL    |       |
| min_magentic_strength_prominences_gauss              | real          | YES  |     | NULL    |       |
| max_magentic_strength_prominences_gauss              | real          | YES  |     | NULL    |       |
| magentic_strength_chromospheric_plages_gauss         | real          | YES  |     | NULL    |       |
| magentic_strength_bright_chromospheric_network_gauss | real          | YES  |     | NULL    |       |
| magentic_strength_ephemeral_active_regions_gauss     | real          | YES  |     | NULL    |       |
| surface_gas_pressure_top_of_photosphere_mb           | real          | YES  |     | NULL    |       |
| surface_gas_pressure_bottom_of_photosphere_mb        | real          | YES  |     | NULL    |       |
| effective_temperature_K                              | real          | YES  |     | NULL    |       |
| temperature_at_top_of_photosphere_K                  | real          | YES  |     | NULL    |       |
| temperature_at_bottom_of_photosphere_K               | real          | YES  |     | NULL    |       |
| temperature_at_top_of_chromosphere_K                 | real          | YES  |     | NULL    |       |
| photosphere_thickness_km                             | real          | YES  |     | NULL    |       |
| chromosphere_thickness_km                            | real          | YES  |     | NULL    |       |
| sun_spot_cycle_yrs                                   | real          | YES  |     | NULL    |       |
| photosphere_composition                              | varchar(1000) | YES  |     | NULL    |       |
+------------------------------------------------------+---------------+------+-----+---------+-------+
```

#### Field descriptions

See `metadata` table contents.

### Table `planets`

```sql
Table: planets
+-----------------------------------------------+---------------+------+-----+---------+------------------------------+
| Field                                         | Type          | Null | Key | Default | Extra                        |
+-----------------------------------------------+---------------+------+-----+---------+------------------------------+
| planet_id                                     | numeric       | NO   | PRI | NULL    |                              |
| name                                          | varchar(50)   | NO   |     | NULL    |                              |
| star_id                                       | numeric       | YES  | MUL | NULL    | Foreign key to stars.star_id |
| discoverer                                    | varchar(100)  | YES  |     | NULL    |                              |
| discovery_date                                | date          | YES  |     | NULL    |                              |
| mass_kg_10_exp_24                             | real          | YES  |     | NULL    |                              |
| volume_10_exp_10_km_exp_3                     | real          | YES  |     | NULL    |                              |
| equatorial_radius_km                          | real          | YES  |     | NULL    |                              |
| core_radius_km                                | real          | YES  |     | NULL    |                              |
| polar_radius_km                               | real          | YES  |     | NULL    |                              |
| mean_volumetric_radius_km                     | real          | YES  |     | NULL    |                              |
| diameter_km                                   | real          | YES  |     | NULL    |                              |
| number_of_moons                               | numeric(3,0)  | YES  |     | NULL    |                              |
| has_ring_system                               | char(1)       | YES  |     | NULL    |  Allowed values ('Y','N')    |
| has_global_magnetic_field                     | char(1)       | YES  |     | NULL    |  Allowed values ('Y','N')    |
| rotation_period_hrs                           | real          | YES  |     | NULL    |                              |
| length_of_day_hrs                             | real          | YES  |     | NULL    |                              |
| ellipticity                                   | real          | YES  |     | NULL    |                              |
| distance_from_sun_10_exp_6_km                 | real          | YES  |     | NULL    |                              |
| mean_distance_from_earth_10_exp_6_km          | real          | YES  |     | NULL    |                              |
| min_distance_from_earth_10_exp_6_km           | real          | YES  |     | NULL    |                              |
| max_distance_from_earth_10_exp_6_km           | real          | YES  |     | NULL    |                              |
| mean_density_kg_per_m_exp_3                   | real          | YES  |     | NULL    |                              |
| gravity_m_per_s_exp_2                         | real          | YES  |     | NULL    |                              |
| acceleration_m_per_s_exp_2                    | real          | YES  |     | NULL    |                              |
| escape_velocity_km_per_s                      | real          | YES  |     | NULL    |                              |
| mean_temperature_K                            | real          | YES  |     | NULL    |                              |
| mean_temperature_C                            | real          | YES  |     | NULL    |                              |
| surface_pressure_bars                         | real          | YES  |     | NULL    |                              |
| gm_10_exp_6_km_exp_3_per_s_exp_2              | real          | YES  |     | NULL    |                              |
| bond_albedo                                   | real          | YES  |     | NULL    |                              |
| geometric_albedo                              | real          | YES  |     | NULL    |                              |
| vband_magnitude                               | real          | YES  |     | NULL    |                              |
| solar_irradiance_W_m_exp_2                    | real          | YES  |     | NULL    |                              |
| black_body_temperature_K                      | real          | YES  |     | NULL    |                              |
| topographic_range_km                          | real          | YES  |     | NULL    |                              |
| moment_of_inertia_I_per_MR_exp_2              | real          | YES  |     | NULL    |                              |
| J_2_10_exp_minus_6                            | real          | YES  |     | NULL    |                              |
| semimajor_axis_au                             | real          | YES  |     | NULL    |                              |
| semimajor_axis_10_exp_6_km                    | real          | YES  |     | NULL    |                              |
| sidereal_orbit_period_days                    | real          | YES  |     | NULL    |                              |
| tropical_orbit_period_days                    | real          | YES  |     | NULL    |                              |
| perihelion_10_exp_6_km                        | real          | YES  |     | NULL    |                              |
| aphelion_10_exp_6_km                          | real          | YES  |     | NULL    |                              |
| synodic_period_days                           | real          | YES  |     | NULL    |                              |
| orbital_period_days                           | real          | YES  |     | NULL    |                              |
| mean_orbital_velocity_km_per_s                | real          | YES  |     | NULL    |                              |
| max_orbital_velocity_km_per_s                 | real          | YES  |     | NULL    |                              |
| min_orbital_velocity_km_per_s                 | real          | YES  |     | NULL    |                              |
| orbital_inclination_degrees                   | real          | YES  |     | NULL    |                              |
| orbital_eccentricity                          | real          | YES  |     | NULL    |                              |
| sidereal_rotation_period_hrs                  | real          | YES  |     | NULL    |                              |
| obliquity_to_orbit_degrees                    | real          | YES  |     | NULL    |                              |
| inclination_of_equator_degrees                | real          | YES  |     | NULL    |                              |
| apparent_diameter_from_earth_at_1_AU_s_of_arc | real          | YES  |     | NULL    |                              |
| max_apparent_diameter_from_earth_s_of_arc     | real          | YES  |     | NULL    |                              |
| min_apparent_diameter_from_earth_s_of_arc     | real          | YES  |     | NULL    |                              |
| mean_apparent_diameter_from_earth_s_of_arc    | real          | YES  |     | NULL    |                              |
| mean_apparent_visual_magnitude_from_earth     | real          | YES  |     | NULL    |                              |
| max_visual_magnitude                          | real          | YES  |     | NULL    |                              |
| longitude_of_ascending_node_degrees           | real          | YES  |     | NULL    |                              |
| longitude_of_perihelion_degrees               | real          | YES  |     | NULL    |                              |
| mean_longitude_degrees                        | real          | YES  |     | NULL    |                              |
| north_pole_of_rotation_right_ascension        | varchar(25)   | YES  |     | NULL    |                              |
| north_pole_of_rotation_declination            | varchar(25)   | YES  |     | NULL    |                              |
| north_pole_of_rotation_reference_date         | varchar(35)   | YES  |     | NULL    |                              |
| magnetosphere_model                           | varchar(50)   | YES  |     | NULL    |                              |
| dipole_field_strength_gauss_R_exp_3           | real          | YES  |     | NULL    |                              |
| dipole_tilt_to_rotational_axis_degrees        | real          | YES  |     | NULL    |                              |
| longitude_of_tilt_degrees                     | real          | YES  |     | NULL    |                              |
| dipole_offset_R                               | real          | YES  |     | NULL    |                              |
| surface_field_strength_1_R_gauss              | varchar(25)   | YES  |     | NULL    |                              |
| geomagnetic_poles_model                       | varchar(50)   | YES  |     | NULL    |                              |
| latitude_geocentric_dipole_degrees            | real          | YES  |     | NULL    |                              |
| longitude_geocentric_dipole_degrees           | real          | YES  |     | NULL    |                              |
| latitude_magnetic_north_pole_degrees          | real          | YES  |     | NULL    |                              |
| longitude_magnetic_north_pole_degrees         | real          | YES  |     | NULL    |                              |
| atmospheric_details                           | varchar(1000) | YES  |     | NULL    |                              |
+-----------------------------------------------+---------------+------+-----+---------+------------------------------+
```

#### Field descriptions

See `metadata` table contents.

## Files

| File name | Description |
| --------- | ------------|
| [install.oracle.sql](install.oracle.sql) | SQL file to install this data set in an Oracle database. |
| [install.sql](install.sql) | SQL file to install this data set in a database. |
| [metadata.csv](metadata.csv) | Comma separated file with metadata. |
| [planets.csv](planets.csv) | Comma separated file with planet data. |
| [stars.csv](stars.csv) | Comma separated file with star data. |
| [uninstall.sql](uninstall.sql) | SQL file to uninstall this data set from a database. |

## Database install instructions

Connect to your database of choice via the command prompt and execute the `install.sql` file.

**Note**: there is a separate file for **Oracle** `install.oracle.sql`

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

## Disclaimer
Note that there is still uncertainty and minor disagreements on some of the measurements of our solar system.
You will find other numbers out there that are different from the ones provided in the NSSDCA/NASA Planetary Fact Sheets.


## Data sources
The data source for this data set is:

* [NSSDCA/NASA Planetary Fact Sheets](https://nssdc.gsfc.nasa.gov/planetary/planetfact.html)
