/*
 * Encoding: UTF-8
 * Since: November, 2022
 * Author: gvenzl
 * Name: install.sql
 * Description: DDL setup and data load script for Solar System data.
 *
 * Copyright 2022 Gerald Venzl
 *
 * Data Sources:
 * - NSSDCA/NASA Planetary Fact Sheets (https://nssdc.gsfc.nasa.gov/planetary/planetfact.html)
 *
 * This work is licensed under the
 * Creative Commons Attribution 4.0 International Public License, CC BY 4.0
 *
 * The Data is provided "as is" without warranty or any representation of
 * accuracy, timeliness or completeness.
 *
 *    https://creativecommons.org/licenses/by/4.0/
 */

/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/******************************* D  a  t  a  m  o  d  e  l    s  e  t  u  p *************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/


/****************************************************************************************************************************/
/************************************************ M E T A D A T A ***********************************************************/
/****************************************************************************************************************************/

CREATE TABLE metadata
(
  metadata_id        NUMERIC         NOT NULL,
  table_name         VARCHAR(13)     NOT NULL,
  column_name        VARCHAR(52)     NOT NULL,
  meaning            VARCHAR(4000)   NOT NULL,
  CONSTRAINT metadata_pk
    PRIMARY KEY (metadata_id)
);

/****************************************************************************************************************************/
/************************************************ S T A R S *****************************************************************/
/****************************************************************************************************************************/
CREATE TABLE stars
(
  star_id                                                NUMERIC       NOT NULL, -- Internally generated ID, not meaningful
  name                                                   VARCHAR(50)   NOT NULL, -- Name of the star
  discoverer                                             VARCHAR(100),           -- Name of the discoverer
  dicovery_date                                          DATE,                   -- Date of discovery
  mass_kg_10_exp_24                                      REAL,                   -- Mass of the body in 10^24 kilograms
  gm_10_exp_6_km_exp_3_per_s_exp_2                       REAL,                   -- Gravitational constant times the mass of the body in 10^6 kilometers^3/seconds^2
  volume_10_exp_12_km_exp_3                              REAL,                   -- Volume of the body in 10^12 km^3
  mean_volumetric_radius_km                              REAL,                   -- Radius of a sphere with the same volume as the body
  mean_density_kg_per_m_exp_3                            REAL,                   -- Average density of the body (mass/volume) in kilograms/(meter^3)
  gravity_m_per_s_exp_2                                  REAL,                   -- Equatorial gravitational acceleration at the surface of the body or the 1 bar level, not including the effects of rotation, in meters/(second^2)
  escape_velocity_km_per_s                               REAL,                   -- Initial velocity required to escape the body's gravitational pull in kilometers/second (at equator)
  ellipticity                                            REAL,                   -- Flattening - The ratio (equatorial - polar radius)/(equatorial radius), dimensionless
  moment_of_inertia_I_per_MR_exp_2                       REAL,                   -- The moment of inertia of the body expressed as the rotational inertia divided by the body's mass x radius^2, where radius^2 = {2(Requator^2) + Rpolar^2}/3. A hollow spherical shell has a moment of inertia of 2/3, a homogeneous sphere 0.4, dimensionless
  vband_magnitude                                        REAL,                   -- V-band magnitude V(1,0) - The magnitude of the body in the V-band (0.549 micrometers) if it were one AU (1.496 x 10^8  kilometers) from the Earth at a phase angle of zero, dimensionless.
  absolute_magnitude                                     REAL,                   -- ?
  luminosity_10_exp_24_J_per_s                           REAL,                   -- Body's luminosity in 10^24 Joule per second
  mass_conversion_rate_10_exp_6_kg_per_s                 REAL,                   -- ?
  mean_energy_production_10_exp_minus_3_J_per_kg_s       REAL,                   -- ?
  surface_emission_10_exp_6_J_per_m_exp_2_s              REAL,                   -- ?
  spectral_type                                          VARCHAR(10),            -- ?
  central_pressure_10_exp_11_bar                         REAL,                   -- Pressue at the center of the body in 10^11 bar
  central_temperature_10_exp_7_K                         REAL,                   -- Temperature at the center of the body in 10^7 Kelvin
  central_density_10_exp_5_kg_per_m_exp_3                REAL,                   -- Density at the center fo the body in 10^5 kilograms per meters^3
  sidereal_rotation_period_hrs                           REAL,                   -- Time for one rotation of the body on its axis relative to the fixed stars, in earth hours. A minus sign indicates retrograde (backwards relative to the Earth) rotation.
  obliquity_to_ecliptic_degrees                          REAL,                   -- ?
  speed_relative_to_nearby_stars_km_per_s                REAL,                   -- Body's speed relative to nearby stars in km/s
  north_pole_of_rotation_right_ascension                 REAL,                   -- ?
  north_pole_of_rotation_declination                     REAL,                   -- ?
  north_pole_of_rotation_reference_date                  VARCHAR(35),            -- Reference date of rotation measured in UTC. This string contains the ISO 8601 date format followed by the Julian Day number in parenthesis.
  apparent_diameter_from_earth_at_1_AU_s_of_arc          REAL,                   -- ?
  max_apparent_diameter_from_earth_s_of_arc              REAL,                   -- ?
  min_apparent_diameter_from_earth_s_of_arc              REAL,                   -- ? question pedning
  mean_distance_from_earth_10_exp_6_km                   REAL,                   -- Mean distance from earth in 10^6 kilometers
  min_distance_from_earth_10_exp_6_km                    REAL,                   -- Minimum distance from earth in 10^6 kilometers
  max_distance_from_earth_10_exp_6_km                    REAL,                   -- Maximum distance from earth in 10^6 kilometers
  min_magentic_field_strength_polar_field_gauss          REAL,                   -- Minimum magnetic field strength at the polar field in Gauss
  max_magentic_field_strength_polar_field_gauss          REAL,                   -- Maximum magnetic field strength at the polar field in Gauss
  magentic_strength_sunspots_gauss                       REAL,                   -- Magnetic field strength of sunspots in Gauss
  min_magentic_strength_prominences_gauss                REAL,                   -- Minimum magnetic field strength of prominences in Gauss
  max_magentic_strength_prominences_gauss                REAL,                   -- Maximum magnetic field strength of prominences in Gauss
  magentic_strength_chromospheric_plages_gauss           REAL,                   -- Magnetic field strength of chromospheric plages in Gauss
  magentic_strength_bright_chromospheric_network_gauss   REAL,                   -- Magnetic field strength of bright chromospheric network in Gauss
  magentic_strength_ephemeral_active_regions_gauss       REAL,                   -- Magnetic field strength of ephemeral (unipolar) active regions in Gauss
  surface_gas_pressure_top_of_photosphere_mb             REAL,                   -- Atmospheric pressure at the top of the photosphere surface in millibars
  surface_gas_pressure_bottom_of_photosphere_mb          REAL,                   -- Atmospheric pressure at the bottom of photosphere surface in millibars
  effective_temperature_K                                REAL,                   -- ?
  temperature_at_top_of_photosphere_K                    REAL,                   -- Temperature at the top of the photosphere in Kelvin
  temperature_at_bottom_of_photosphere_K                 REAL,                   -- Temperature at the bottom of the photosphere in Kelvin
  temperature_at_top_of_chromosphere_K                   REAL,                   -- Temperature at the top of the chromosphere in Kelvin
  photosphere_thickness_km                               REAL,                   -- Photosphere thickness in kilometers
  chromosphere_thickness_km                              REAL,                   -- Chromosphere thickness in kilometers
  sun_spot_cycle_yrs                                     REAL,                   -- Cycle of sun spots in earth years.
  photosphere_composition                                VARCHAR(1000),          -- Composition of photosphere elements
  CONSTRAINT stars_pk
    PRIMARY KEY (star_id)
);

/****************************************************************************************************************************/
/************************************************ P L A N E T S *************************************************************/
/****************************************************************************************************************************/

CREATE TABLE planets
(
  planet_id                                              NUMERIC       NOT NULL, -- Internally generated ID, not meaningful
  name                                                   VARCHAR(50)   NOT NULL, -- Name of the planet
  star_id                                                NUMERIC,                -- ID of the star the planet is orbiting
  discoverer                                             VARCHAR(100),           -- Name of the discoverer
  discovery_date                                         DATE,                   -- Date of discovery
  mass_kg_10_exp_24                                      REAL,                   -- Mass of the body in 10^24 kilograms
  volume_10_exp_10_km_exp_3                              REAL,                   -- Volume of the body in 10^12 km^3
  equatorial_radius_km                                   REAL,                   -- Radius of the body at the equator in kilometers
  core_radius_km                                         REAL,                   -- Radius of the planet core in kilometers
  polar_radius_km                                        REAL,                   -- Radius of the body at the poles in kilometers
  mean_volumetric_radius_km                              REAL,                   -- Radius of a sphere with the same volume as the body
  diameter_km                                            REAL,                   -- The planetary diameter used is two times the volumetric mean radius. For Venus, Jupiter, Saturn, Uranus, and Neptune, diameter is approximately to the visible cloud tops.
  number_of_moons                                        NUMERIC(3),             -- The number of moons orbiting the planet, as certified by the IAU
  has_ring_system                                        CHAR(1),                -- This tells whether a planet has a set of rings around it, Saturn being the most obvious example.
  has_global_magnetic_field                              CHAR(1),                -- This tells whether the planet has a measurable large-scale magnetic field. Mars and the Moon have localized regional magnetic fields but no global field.
  rotation_period_hrs                                    REAL,                   -- This is the time it takes for the planet to complete one rotation relative to the fixed background stars (not relative to the Sun) in hours. Negative numbers indicate retrograde (backwards relative to the Earth) rotation.
  length_of_day_hrs                                      REAL,                   -- The average time in hours for the Sun to move from the noon position in the sky at a point on the equator back to the same position.
  ellipticity                                            REAL,                   -- Flattening - The ratio (equatorial - polar radius)/(equatorial radius), dimensionless
  distance_from_sun_10_exp_6_km                          REAL,                   -- This is the average distance from the planet to the Sun in millions of kilometers or millions of miles, also known as the semi-major axis. All planets have orbits which are elliptical, not perfectly circular, so there is a point in the orbit at which the planet is closest to the Sun, the perihelion, and a point furthest from the Sun, the aphelion. The average distance from the Sun is midway between these two values. The average distance from the Earth to the Sun is defined as 1 Astronomical Unit (AU), so the ratio table gives this distance in AU.
  mean_distance_from_earth_10_exp_6_km                   REAL,                   -- Approximate values for the minimum and maximum distances of the planets from Earth. Orbits fluctuate over time, these values are calculated from the mean orbital elements for J2000 250 year fits and the current orbits referenced to Julian Date 2459000.5 (11 June 2020).
  min_distance_from_earth_10_exp_6_km                    REAL,                   -- Approximate values for the minimum and maximum distances of the planets from Earth. Orbits fluctuate over time, these values are calculated from the mean orbital elements for J2000 250 year fits and the current orbits referenced to Julian Date 2459000.5 (11 June 2020).
  max_distance_from_earth_10_exp_6_km                    REAL,                   -- Approximate values for the minimum and maximum distances of the planets from Earth. Orbits fluctuate over time, these values are calculated from the mean orbital elements for J2000 250 year fits and the current orbits referenced to Julian Date 2459000.5 (11 June 2020).
  mean_density_kg_per_m_exp_3                            REAL,                   -- Average density of the body (mass/volume) in kilograms/(meter^3)
  gravity_m_per_s_exp_2                                  REAL,                   -- Equatorial gravitational acceleration at the surface of the body or the 1 bar level, not including the effects of rotation, in meters/(second^2)
  acceleration_m_per_s_exp_2                             REAL,                   -- Effective equatorial gravitational acceleration at the surface of the body or the 1 bar level, including the effects of rotation, in meters/(second^2)
  escape_velocity_km_per_s                               REAL,                   -- Initial velocity required to escape the body's gravitational pull in kilometers/second (at equator)
  mean_temperature_K                                     REAL,                   -- Mean temperature of the body over the entire surface in Kelvin.
  mean_temperature_C                                     REAL,                   -- Mean temperature of the body over the entire surface in Celsius.
  surface_pressure_bars                                  REAL,                   -- Atmospheric pressure at the surface, in bars.
  gm_10_exp_6_km_exp_3_per_s_exp_2                       REAL,                   -- Gravitational constant times the mass of the body in 10^6 kilometers^3/seconds^2
  bond_albedo                                            REAL,                   -- The fraction of incident solar radiation reflected back into space without absorption, dimensionless. Also called planetary albedo.
  geometric_albedo                                       REAL,                   -- The ratio of the body's brightness at a phase angle of zero to the brightness of a perfectly diffusing disk with the same position and apparent size, dimensionless. V-band (0.549 micrometers). Earth is highly variable.
  vband_magnitude                                        REAL,                   -- The magnitude of the body in the V-band (0.549 micrometers) if it were one AU (1.496 x 10^8  kilometers) from the Earth at a phase angle of zero, dimensionless.
  solar_irradiance_W_per_m_exp_2                         REAL,                   -- Solar energy on the body in Watts/(meter^2)
  black_body_temperature_K                               REAL,                   -- Equivalent black body temperature is the surface temperature the body would have if it were in radiative equilibrium and had no atmosphere, but the same albedo, in Kelvin.
  topographic_range_km                                   REAL,                   -- Difference in elevation between the highest and lowest points on the planet's surface, in kilometers.
  moment_of_inertia_I_per_MR_exp_2                       REAL,                   -- The moment of inertia of the body expressed as the rotational inertia divided by the body's mass x radius^2, where radius^2 = {2(Requator^2) + Rpolar^2}/3. A hollow spherical shell has a moment of inertia of 2/3, a homogeneous sphere 0.4, dimensionless.
  J_2_10_exp_minus_6                                     REAL,                   -- The ratio of the difference in the moments of inertia (rotational vs polar) to the mass of the body times the radius^2,(C-A)/(M R^2), x 10^-6, dimensionless.
  semimajor_axis_au                                      REAL,                   -- ?
  semimajor_axis_10_exp_6_km                             REAL,                   -- Approximate mean distance from the Sun (or other central body in the case of satellites) from center to center in 10^6 kilometers.
  sidereal_orbit_period_days                             REAL,                   -- The time it takes the body to make one revolution about the Sun relative to the fixed stars in days. For Pluto, it is the time from the last zero longitude crossing to the next (24 July 1820 - 2 July 2068).
  tropical_orbit_period_days                             REAL,                   -- The average time for the body to make one revolution about the Sun from one point in its seasonal orbit to the equivalent point (e.g. equinox to equinox) in days. For Earth, this equals exactly 1 year. Not known for Pluto.
  perihelion_10_exp_6_km                                 REAL,                   -- The point in a body's orbit closest to the Sun, in 10^6 kilometers.
  aphelion_10_exp_6_km                                   REAL,                   -- The point in a body's orbit furthest from the Sun, in 10^6 kilometers.
  synodic_period_days                                    REAL,                   -- The time interval between similar configurations in the orbit (e.g. opposition) of the body and Earth, in days.
  orbital_period_days                                    REAL,                   -- This is the time in Earth days for a planet to orbit the Sun from one vernal equinox to the next. Also known as the tropical orbit period, this is equal to a year on Earth. For the Moon, the sidereal orbit period, the time to orbit once relative to the fixed background stars, is given. The time from full Moon to full Moon, or synodic period, is 29.53 days. For Pluto, the tropical orbit period is not well known, the sidereal orbit period is used.
  mean_orbital_velocity_km_per_s                         REAL,                   -- The average speed of the body in elliptical orbit, in kilometers/second.
  max_orbital_velocity_km_per_s                          REAL,                   -- Maximum orbital velocity, at perihelion, in kilometers/second.
  min_orbital_velocity_km_per_s                          REAL,                   -- Minimum orbital velocity, at aphelion, in kilometers/second.
  orbital_inclination_degrees                            REAL,                   -- The inclination of the orbit to the ecliptic, in degrees.
  orbital_eccentricity                                   REAL,                   -- A measure of the circularity of the orbit, equal to (aphelion - perihelion distance)/(2 x semi-major axis). For the Galilean satellites, the forced eccentricity is given. For a circular orbit eccentricity = 0. Dimensionless.
  sidereal_rotation_period_hrs                           REAL,                   -- The time for one rotation of the body on its axis relative to the fixed stars, in hours. A minus sign indicates retrograde (backwards relative to the Earth) rotation.
  obliquity_to_orbit_degrees                             REAL,                   -- The angle between the body's equator and the body's orbital plane, with north defined by the right-hand rule. (J2000)
  inclination_of_equator_degrees                         REAL,                   -- The angle between the equator and orbital plane with north defined as pole axis above (north of) the plane of the solar system, also denoted as axial tilt. (J2000)
  apparent_diameter_from_earth_at_1_AU_s_of_arc          REAL,                   -- ?
  max_apparent_diameter_from_earth_s_of_arc              REAL,                   -- ?
  min_apparent_diameter_from_earth_s_of_arc              REAL,                   -- ?
  mean_apparent_diameter_from_earth_s_of_arc             REAL,                   -- ?
  mean_apparent_visual_magnitude_from_earth              REAL,                   -- ?
  max_visual_magnitude                                   REAL,                   -- ?
  longitude_of_ascending_node_degrees                    REAL,                   -- The longitude in a body's orbit at which it crosses the ecliptic plane with increasing latitude (i.e. crosses the ecliptic from south to north).
  longitude_of_perihelion_degrees                        REAL,                   -- The longitude in a body's orbit at which it reaches the point closest to the Sun.
  mean_longitude_degrees                                 REAL,                   -- The longitude a body was at in its orbit at 12:00 Universal (Greenwich) Time on January 1, 2000, also known as J2000 or Julian Day 2451545.0
  north_pole_of_rotation_right_ascension                 VARCHAR(25),            -- ?
  north_pole_of_rotation_declination                     VARCHAR(25),            -- ?
  north_pole_of_rotation_reference_date                  VARCHAR(35),            -- Reference date of rotation measured in UTC. This string contains the ISO 8601 date format followed by the Julian Day number in parenthesis.
  magnetosphere_model                                    VARCHAR(50),            -- The model used for charting the magnetosphere
  dipole_field_strength_gauss_R_exp_3                    REAL,                   -- The strength of the dipole portion of the planetary magnetic field outside the planet in Gauss-R^3, where R is in units of planet radius. (Dividing by the distance R^3 gives the field in Gauss)
  dipole_tilt_to_rotational_axis_degrees                 REAL,                   -- Tilt of the dipole axis to the axis of rotation in degrees.
  longitude_of_tilt_degrees                              REAL,                   -- ?
  dipole_offset_R                                        REAL,                   -- The offset distance of the dipole center to the planet center in units of planet radius.
  surface_field_strength_1_R_gauss                       VARCHAR(25),            -- Range of total field strength at planet radius in Gauss.
  geomagnetic_poles_model                                VARCHAR(50),            -- The model used for charting the geomagnetic poles
  latitude_geocentric_dipole_degrees                     REAL,                   -- The latitude of the geocentric dipole
  longitude_geocentric_dipole_degrees                    REAL,                   -- The longitude of the geocentric dipole
  latitude_magnetic_north_pole_degrees                   REAL,                   -- The latitude of the magnetic north pole
  longitude_magnetic_north_pole_degrees                  REAL,                   -- The longitude of the magnetic north pole
  atmosphere_composition                                 VARCHAR(1000),          -- Atmosphere details
  CONSTRAINT planets_pk
    PRIMARY KEY (planet_id),
  CONSTRAINT planets_stars_fk001
    FOREIGN KEY (star_id) REFERENCES stars (star_id),
  CONSTRAINT planets_has_ring_system_Y_N_check001
    CHECK (has_ring_system IN ('Y','N')),
  CONSTRAINT planets_has_global_magnetic_field_Y_N_check002
    CHECK (has_global_magnetic_field IN ('Y','N'))
);


/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/************************************************ D  a  t  a     l  o  a  d *************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/
/****************************************************************************************************************************/



/****************************************************************************************************************************/
/************************************************ M E T A D A T A ***********************************************************/
/****************************************************************************************************************************/


/************************************************ M E T A D A T A ***********************************************************/

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (1,           'metadata', 'metadata_id',
    'Internally generated id for the primary key value.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (2,           'metadata', 'table_name',
    'The name of the table.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (3,           'metadata', 'column_name',
    'The name of the column.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (4,           'metadata', 'meaning',
    'The meaning of the data in that particular column in the table.'
 );

/************************************************ S T A R S *****************************************************************/

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (5,           'stars',    'star_id',
    'Internally generated id for the primary key value.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (6,           'stars',    'name',
    'The name of the star.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (7,           'stars',    'discoverer',
    'The person who discovered the star.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (8,           'stars',    'dicovery_date',
    'The date when the star has been discovered.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (9,           'stars',    'mass_kg_10_exp_24',
    'Mass of the body in 10^24 kilograms.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (10,          'stars',    'gm_10_exp_6_km_exp_3_per_s_exp_2',
    'Gravitational constant times the mass of the body in 10^6 kilometers^3 / seconds^2 (x 10^6 km^3/s^2).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (11,          'stars',    'volume_10_exp_12_km_exp_3',
    'Volume of the body in 10^12 km^3.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (12,          'stars',    'mean_volumetric_radius_km',
    'Radius of a sphere with the same volume as the body.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (13,          'stars',    'mean_density_kg_per_m_exp_3',
    'Average density of the body (mass/volume) in kilograms/(meter^3).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (14,          'stars',    'gravity_m_per_s_exp_2',
    'Equatorial gravitational acceleration at the surface of the body or the 1 bar level, not including the effects of rotation, in meters/(second^2).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (15,          'stars',    'escape_velocity_km_per_s',
    'Initial velocity required to escape the body''s gravitational pull in kilometers/second (at equator).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (16,          'stars',    'ellipticity',
    'Flattening - The ratio (equatorial - polar radius)/(equatorial radius), dimensionless.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (17,          'stars',    'moment_of_inertia_I_per_MR_exp_2',
    'The moment of inertia of the body expressed as the rotational inertia divided by the body''s mass x radius^2, where radius^2 = {2(Requator^2) + Rpolar^2}/3. A hollow spherical shell has a moment of inertia of 2/3, a homogeneous sphere 0.4, dimensionless.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (18,          'stars',    'vband_magnitude',
    'V-band magnitude V(1,0) - The magnitude of the body in the V-band (0.549 micrometers) if it were one AU (1.496 x 10^8  kilometers) from the Earth at a phase angle of zero, dimensionless.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (19,          'stars',    'absolute_magnitude',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (20,          'stars',    'luminosity_10_exp_24_j_per_s',
    'Body''s luminosity in 10^24 Joule per second.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (21,          'stars',    'mass_conversion_rate_10_exp_6_kg_per_s',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (22,          'stars',    'mean_energy_production_10_exp_minus_3_J_per_kg_s',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (23,          'stars',    'surface_emission_10_exp_6_J_per_m_exp_2_s',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (24,          'stars',    'spectral_type',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (25,          'stars',    'central_pressure_10_exp_11_bar',
    'Pressue at the center of the body in 10^11 bar.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (26,          'stars',    'central_temperature_10_exp_7_K',
    'Temperature at the center of the body in 10^7 Kelvin.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (27,          'stars',    'central_density_10_exp_5_kg_per_m_exp_3',
    'Density at the center fo the body in 10^5 kilograms per meters^3.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (28,          'stars',    'sidereal_rotation_period_hrs',
    'Time for one rotation of the body on its axis relative to the fixed stars, in earth hours. A minus sign indicates retrograde (backwards relative to the Earth) rotation.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (29,          'stars',    'obliquity_to_ecliptic_degrees',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (30,          'stars',    'speed_relative_to_nearby_stars_km_per_s',
    'Body''s speed relative to nearby stars in km/s.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (31,          'stars',    'north_pole_of_rotation_right_ascension',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (32,          'stars',    'north_pole_of_rotation_declination',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (33,          'stars',    'north_pole_of_rotation_reference_date',
    'Reference date of rotation measured in UTC. This string contains the ISO 8601 date format followed by the Julian Day number in parenthesis.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (34,          'stars',    'apparent_diameter_from_earth_at_1_AU_s_of_arc',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (35,          'stars',    'max_apparent_diameter_from_earth_s_of_arc',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (36,          'stars',    'min_apparent_diameter_from_earth_s_of_arc',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (37,          'stars',    'mean_distance_from_earth_10_exp_6_km',
    'Mean distance from earth in 10^6 kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (38,          'stars',    'min_distance_from_earth_10_exp_6_km',
    'Minimum distance from earth in 10^6 kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (39,          'stars',    'max_distance_from_earth_10_exp_6_km',
    'Maximum distance from earth in 10^6 kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (40,          'stars',    'min_magentic_field_strength_polar_field_gauss',
    'Minimum magnetic field strength at the polar field in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (41,          'stars',    'max_magentic_field_strength_polar_field_gauss',
    'Maximum magnetic field strength at the polar field in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (42,          'stars',    'magentic_strength_sunspots_gauss',
    'Magnetic field strength of sunspots in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (43,          'stars',    'min_magentic_strength_prominences_gauss',
    'Minimum magnetic field strength of prominences in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (44,          'stars',    'max_magentic_strength_prominences_gauss',
    'Maximum magnetic field strength of prominences in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (45,          'stars',    'magentic_strength_chromospheric_plages_gauss',
    'Magnetic field strength of chromospheric plages in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (46,          'stars',    'magentic_strength_bright_chromospheric_network_gauss',
    'Magnetic field strength of bright chromospheric network in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (47,          'stars',    'magentic_strength_ephemeral_active_regions_gauss',
    'Magnetic field strength of ephemeral (unipolar) active regions in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (48,          'stars',    'surface_gas_pressure_top_of_photosphere_mb',
    'Atmospheric pressure at the top of the photosphere surface in millibars.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (49,          'stars',    'surface_gas_pressure_bottom_of_photosphere_mb',
    'Atmospheric pressure at the bottom of photosphere surface in millibars.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (50,          'stars',    'effective_temperature_K',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (51,          'stars',    'temperature_at_top_of_photosphere_K',
    'Temperature at the top of the photosphere in Kelvin.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (52,          'stars',    'temperature_at_bottom_of_photosphere_K',
    'Temperature at the bottom of the photosphere in Kelvin.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (53,          'stars',    'temperature_at_top_of_chromosphere_K',
    'Temperature at the top of the chromosphere in Kelvin.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (54,          'stars',    'photosphere_thickness_km',
    'Photosphere thickness in kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (55,          'stars',    'chromosphere_thickness_km',
    'Chromosphere thickness in kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (56,          'stars',    'sun_spot_cycle_yrs',
    'Cycle of sun spots in Earth years.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (57,          'stars',    'photosphere_composition',
    'Composition of photosphere elements in JSON format.'
 );

/************************************************ P L A N E T S *************************************************************/

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (58,          'planets',  'planet_id',
    'Internally generated id for the primary key value.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (59,          'planets',  'name',
    'The name of the planet.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (60,          'planets',  'star_id',
    'The ID of the star to which the planet belongs.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (61,          'planets',  'discoverer',
    'The person who discovered the planet.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (62,          'planets',  'discovery_date',
    'The date when the planet has been discovered.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (63,          'planets',  'mass_kg_10_exp_24',
    'Mass of the body in 10^24 kilograms.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (64,          'planets',  'volume_10_exp_10_km_exp_3',
    'Volume of the body in 10^12 km^3.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (65,          'planets',  'equatorial_radius_km',
    'Radius of the body at the equator in kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (66,          'planets',  'core_radius_km',
    'Radius of the planet core in kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (67,          'planets',  'polar_radius_km',
    'Radius of the body at the poles in kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (68,          'planets',  'mean_volumetric_radius_km',
    'Radius of a sphere with the same volume as the body.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (69,          'planets',  'diameter_km',
    'The planetary diameter used is two times the volumetric mean radius. For Venus, Jupiter, Saturn, Uranus, and Neptune, diameter is approximately to the visible cloud tops.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (70,          'planets',  'number_of_moons',
    'The number of moons orbiting the planet, as certified by the IAU (International Astronomical Union).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (71,          'planets',  'has_ring_system',
    'This tells whether a planet has a set of rings around it, Saturn being the most obvious example.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (72,          'planets',  'has_global_magnetic_field',
    'Indicates whether the planet has a measurable large-scale magnetic field. Mars has localized regional magnetic fields but no global field.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (73,          'planets',  'rotation_period_hrs',
    'The time it takes for the planet to complete one rotation relative to the fixed background stars (not relative to the Sun) in hours. Negative numbers indicate retrograde (backwards relative to the Earth) rotation.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (74,          'planets',  'length_of_day_hrs',
    'The average time in hours for the Sun to move from the noon position in the sky at a point on the equator back to the same position.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (75,          'planets',  'ellipticity',
    'Flattening - The ratio (equatorial - polar radius)/(equatorial radius), dimensionless.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (76,          'planets',  'distance_from_sun_10_exp_6_km',
    'The average distance from the planet to the Sun in millions of kilometers, also known as the semi-major axis. All planets have orbits which are elliptical, not perfectly circular, so there is a point in the orbit at which the planet is closest to the Sun, the perihelion, and a point furthest from the Sun, the aphelion. The average distance from the Sun is midway between these two values. The average distance from the Earth to the Sun is defined as 1 Astronomical Unit (AU), so the ratio table gives this distance in AU.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (77,          'planets',  'mean_distance_from_earth_10_exp_6_km',
    'Approximate values for the minimum and maximum distances of the planets from Earth. Orbits fluctuate over time, these values are calculated from the mean orbital elements for J2000 250 year fits and the current orbits referenced to Julian Date 2459000.5 (11 June 2020).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (78,          'planets',  'min_distance_from_earth_10_exp_6_km',
    'Approximate value for the minimum distance of the planets from Earth. Orbits fluctuate over time, these values are calculated from the mean orbital elements for J2000 250 year fits and the current orbits referenced to Julian Date 2459000.5 (11 June 2020).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (79,          'planets',  'max_distance_from_earth_10_exp_6_km',
    'Approximate value for the maximum distances of the planets from Earth. Orbits fluctuate over time, these values are calculated from the mean orbital elements for J2000 250 year fits and the current orbits referenced to Julian Date 2459000.5 (11 June 2020).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (80,          'planets',  'mean_density_kg_per_m_exp_3',
    'Average density of the body (mass/volume) in kilograms/(meter^3).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (81,          'planets',  'gravity_m_per_s_exp_2',
    'Equatorial gravitational acceleration at the surface of the body or the 1 bar level, not including the effects of rotation, in meters/(second^2).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (82,          'planets',  'acceleration_m_per_s_exp_2',
    'Effective equatorial gravitational acceleration at the surface of the body or the 1 bar level, including the effects of rotation, in meters/(second^2).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (83,          'planets',  'escape_velocity_km_per_s',
    'Initial velocity required to escape the body''s gravitational pull in kilometers/second (at equator).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (84,          'planets',  'mean_temperature_K',
    'Mean temperature of the body over the entire surface in Kelvin.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (85,          'planets',  'mean_temperature_C',
    'Mean temperature of the body over the entire surface in Celsius.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (86,          'planets',  'surface_pressure_bars',
    'Atmospheric pressure at the surface, in bars.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (87,          'planets',  'gm_10_exp_6_km_exp_3_per_s_exp_2',
    'Gravitational constant times the mass of the body in 10^6 kilometers^3/seconds^2.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (88,          'planets',  'bond_albedo',
    'The fraction of incident solar radiation reflected back into space without absorption, dimensionless. Also called planetary albedo.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (89,          'planets',  'geometric_albedo',
    'The ratio of the body''s brightness at a phase angle of zero to the brightness of a perfectly diffusing disk with the same position and apparent size, dimensionless. V-band (0.549 micrometers). Earth is highly variable.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (90,          'planets',  'vband_magnitude',
    'The magnitude of the body in the V-band (0.549 micrometers) if it were one AU (1.496 x 10^8  kilometers) from the Earth at a phase angle of zero, dimensionless.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (91,          'planets',  'solar_irradiance_W_per_m_exp_2',
    'Solar energy on the body in Watts/(meter^2).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (92,          'planets',  'black_body_temperature_K',
    'Equivalent black body temperature is the surface temperature the body would have if it were in radiative equilibrium and had no atmosphere, but the same albedo, in Kelvin.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (93,          'planets',  'topographic_range_km',
    'Difference in elevation between the highest and lowest points on the planet''s surface, in kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (94,          'planets',  'moment_of_inertia_I_per_MR_exp_2',
    'The moment of inertia of the body expressed as the rotational inertia divided by the body''s mass x radius^2, where radius^2 = {2(Requator^2) + Rpolar^2}/3. A hollow spherical shell has a moment of inertia of 2/3, a homogeneous sphere 0.4, dimensionless.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (95,          'planets',  'J_2_10_exp_minus_6',
    'The ratio of the difference in the moments of inertia (rotational vs polar) to the mass of the body times the radius^2,(C-A)/(M R^2), x 10^-6, dimensionless.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (96,          'planets',  'semimajor_axis_au',
    '?'
 );


INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (97,          'planets',  'semimajor_axis_10_exp_6_km',
    'Approximate mean distance from the Sun from center to center in 10^6 kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (98,          'planets',  'sidereal_orbit_period_days',
    'The time it takes the body to make one revolution about the Sun relative to the fixed stars in days. For Pluto, it is the time from the last zero longitude crossing to the next (24 July 1820 - 2 July 2068).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (99,          'planets',  'tropical_orbit_period_days',
    'The average time for the body to make one revolution about the Sun from one point in its seasonal orbit to the equivalent point (e.g. equinox to equinox) in days. For Earth, this equals exactly 1 year. Not known for Pluto.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (100,         'planets',  'perihelion_10_exp_6_km',
    'The point in a body''s orbit closest to the Sun, in 10^6 kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (101,         'planets',  'aphelion_10_exp_6_km',
    'The point in a body''s orbit furthest from the Sun, in 10^6 kilometers.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (102,         'planets',  'synodic_period_days',
    'The time interval between similar configurations in the orbit (e.g. opposition) of the body and Earth, in days.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (103,         'planets',  'orbital_period_days',
    'The time in Earth days for a planet to orbit the Sun from one vernal equinox to the next. Also known as the tropical orbit period, this is equal to a year on Earth. For Pluto, the tropical orbit period is not well known, the sidereal orbit period is used.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (104,         'planets',  'mean_orbital_velocity_km_per_s',
    'The average speed of the body in elliptical orbit, in kilometers/second.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (105,         'planets',  'max_orbital_velocity_km_per_s',
    'Maximum orbital velocity, at perihelion, in kilometers/second.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (106,         'planets',  'min_orbital_velocity_km_per_s',
    'Minimum orbital velocity, at aphelion, in kilometers/second.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (107,         'planets',  'orbital_inclination_degrees',
    'The inclination of the orbit to the ecliptic, in degrees.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (108,         'planets',  'orbital_eccentricity',
    'A measure of the circularity of the orbit, equal to (aphelion - perihelion distance)/(2 x semi-major axis). For a circular orbit eccentricity = 0. Dimensionless.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (109,         'planets',  'sidereal_rotation_period_hrs',
    'The time for one rotation of the body on its axis relative to the fixed stars, in hours. A minus sign indicates retrograde (backwards relative to the Earth) rotation.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (110,         'planets',  'obliquity_to_orbit_degrees',
    'The angle between the body''s equator and the body''s orbital plane, with north defined by the right-hand rule. (J2000)'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (111,         'planets',  'inclination_of_equator_degrees',
    'The angle between the equator and orbital plane with north defined as pole axis above (north of) the plane of the solar system, also denoted as axial tilt. (J2000)'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (112,         'planets',  'apparent_diameter_from_earth_at_1_AU_s_of_arc',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (113,         'planets',  'max_apparent_diameter_from_earth_s_of_arc',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (114,         'planets',  'min_apparent_diameter_from_earth_s_of_arc',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (115,         'planets',  'mean_apparent_diameter_from_earth_s_of_arc',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (116,         'planets',  'mean_apparent_visual_magnitude_from_earth',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (117,         'planets',  'max_visual_magnitude',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (118,         'planets',  'longitude_of_ascending_node_degrees',
    'The longitude in a body''s orbit at which it crosses the ecliptic plane with increasing latitude (i.e. crosses the ecliptic from south to north).'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (119,         'planets',  'longitude_of_perihelion_degrees',
    'The longitude in a body''s orbit at which it reaches the point closest to the Sun.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (120,         'planets',  'mean_longitude_degrees',
    'The longitude a body was at in its orbit at 12:00 Universal (Greenwich) Time on January 1, 2000, also known as J2000 or Julian Day 2451545.0'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (121,         'planets',  'north_pole_of_rotation_right_ascension',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (122,         'planets',  'north_pole_of_rotation_declination',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (123,         'planets',  'north_pole_of_rotation_reference_date',
    'Reference date of rotation measured in UTC. This string contains the ISO 8601 date format followed by the Julian Day number in parenthesis.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (124,         'planets',  'magnetosphere_model',
    'The model used for charting the magnetosphere.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (125,         'planets',  'dipole_field_strength_gauss_R_exp_3',
    'The strength of the dipole portion of the planetary magnetic field outside the planet in Gauss-R^3, where R is in units of planet radius. (Dividing by the distance R^3 gives the field in Gauss)'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (126,         'planets',  'dipole_tilt_to_rotational_axis_degrees',
    'Tilt of the dipole axis to the axis of rotation in degrees.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (127,         'planets',  'longitude_of_tilt_degrees',
    '?'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (128,         'planets',  'dipole_offset_R',
    'The offset distance of the dipole center to the planet center in units of planet radius.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (129,         'planets',  'surface_field_strength_1_R_gauss',
    'Range of total field strength at planet radius in Gauss.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (130,         'planets',  'geomagnetic_poles_model',
    'The model used for charting the geomagnetic poles.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (131,         'planets',  'latitude_geocentric_dipole_degrees',
    'The latitude of the geocentric dipole.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (132,         'planets',  'longitude_geocentric_dipole_degrees',
    'The longitude of the geocentric dipole.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (133,         'planets',  'latitude_magnetic_north_pole_degrees',
    'The latitude of the magnetic north pole.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (134,         'planets',  'longitude_magnetic_north_pole_degrees',
    'The longitude of the magnetic north pole.'
 );

INSERT INTO metadata
 (metadata_id, table_name, column_name,
   meaning
 )
   VALUES
 (135,         'planets',  'atmosphere_composition',
    'Composition of atmosphere elements in JSON format.'
 );

/****************************************************************************************************************************/
/************************************************ S T A R S *****************************************************************/
/****************************************************************************************************************************/

INSERT INTO stars
 (star_id, name,  discoverer, dicovery_date, mass_kg_10_exp_24, gm_10_exp_6_km_exp_3_per_s_exp_2,
   volume_10_exp_12_km_exp_3, mean_volumetric_radius_km, mean_density_kg_per_m_exp_3,
    gravity_m_per_s_exp_2, escape_velocity_km_per_s, ellipticity, moment_of_inertia_I_per_MR_exp_2,
     vband_magnitude, absolute_magnitude, luminosity_10_exp_24_J_per_s, mass_conversion_rate_10_exp_6_kg_per_s,
      mean_energy_production_10_exp_minus_3_J_per_kg_s, surface_emission_10_exp_6_J_per_m_exp_2_s, spectral_type,
       central_pressure_10_exp_11_bar, central_temperature_10_exp_7_K, central_density_10_exp_5_kg_per_m_exp_3,
        sidereal_rotation_period_hrs, obliquity_to_ecliptic_degrees, speed_relative_to_nearby_stars_km_per_s,
         north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
          apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
           mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km, max_distance_from_earth_10_exp_6_km,
            min_magentic_field_strength_polar_field_gauss, max_magentic_field_strength_polar_field_gauss, magentic_strength_sunspots_gauss,
             min_magentic_strength_prominences_gauss, max_magentic_strength_prominences_gauss, magentic_strength_chromospheric_plages_gauss,
              magentic_strength_bright_chromospheric_network_gauss, magentic_strength_ephemeral_active_regions_gauss,
               surface_gas_pressure_top_of_photosphere_mb, surface_gas_pressure_bottom_of_photosphere_mb, effective_temperature_K,
                temperature_at_top_of_photosphere_K, temperature_at_bottom_of_photosphere_K, temperature_at_top_of_chromosphere_K,
                 photosphere_thickness_km, chromosphere_thickness_km, sun_spot_cycle_yrs,
                  photosphere_composition
 )
   VALUES
 (1,       'Sun', 'Unknown',  NULL,          1988500,           132712,
   1412000,                   695700,                    1408,
    274,                   617.6,                    0.00005,     0.070,
     -26.74,          4.83,               382.8,                        4260,
      0.1925,                                      62.94,                                     'G2 V',
       2.477,                          1.571,                          1.622,
        609.12,                       7.25,                          19.4,
         286.13,                                 63.87,                              '2000-01-01T12:00:00Z (JD 2451545.0)',
          1919,                                          1952,                                          1887,
           149.6,                                147.1,                                   152.1,
            1,                                             2,                                             3000,
             10,                                      100,                                     200,
              25,                                                   20,
               0.868,                                      125,                                           5772,
                4400,                                6600,                                   30000,
                 500,                      2500,                      11.4,
                  '{"major_elements":{"measurement":"percent","elements":{"H":90.965,"He":8.889}},"minor_elements":{"measurement":"parts per million (ppm)","elements":{"O":774,"C":330,"Ne":112,"N":102,"Fe":43,"Mg":35,"Si":32,"S":15}}}'
 );


/****************************************************************************************************************************/
/***************** PLANETS *******************/
/****************************************************************************************************************************/

INSERT INTO planets
 (planet_id, name, star_id, discoverer, discovery_date, mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
   polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
    length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
     max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
      escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
       bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
        moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
         perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
          max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
           sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees,
            apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
             mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
              north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
               magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                dipole_offset_R, surface_field_strength_1_R_gauss,
                 geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                  latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                   atmosphere_composition
 )
   VALUES
 (1,         'Mercury',  1, 'Unknown',  NULL,           0.33010,                      6.083,             2440.5,            NULL,
   2438.3,          2439.7,                    4879,        0,               'N',             'Y',                       1407.6,
    4222.6,            0.0009,      57.9,                          91.69,                                77.3,
     221.9,                               5429,                        3.70,                  3.70,
      4.3,                      440,                167,                0,                     0.022032,
       0.068,       0.142,            -0.613,          9082.7,                         439.6,                    7,
        0.35,                             50.3,               0.38709893,        57.909,                     87.969,                     87.968,
         46.000,                 69.818,               115.88,              88.0,                47.36,
          58.98,                         38.86,                         7.00487,                     0.20563069,
           1407.6,                       0.034,                      0.034,
            11.0,                                          13.0,                                      4.5,
             NULL,                                      -2.43,                48.33167,                            77.45645,                        252.25084,
              '281.010 - 0.033T',                    '61.414 - 0.005T',                  '2000-01-01T12:00:00Z (JD 2451545.0)',
               'MESSENGER Model 2010',                            0.002, 0.0,                                    NULL,
                0.17,            '0.0025 - 0.007',
                 NULL,                    NULL,                               NULL,
                  NULL,                                 NULL,
                   '{"surface_pressure":{"pressure":"<~5","scale":"10^-15","unit":"bar"},"average_temperature":{"sunward_side":{"temperature":"590-725","unit":"K"},"average":[{"temperature":440,"unit":"K"},{"temperature":167,"unit":"C"}]},"total_mass_of_atmosphere":{"mass":"<~10000","unit":"kg"},"composition":{"abundances":{"scale":"10^6","unit":"/cm^2","element":{"Na":"12000-200000","Mg":"100000","O":"<40000","H":"5000","K":"800-1300","Ca":"300-1000","Fe":"<300","Al":"15"}},"possible_traces":["Ar","CO2","H2O","N2","Xe","Kr","Ne","He"]},"comments":"The atmosphere of Mercury is a surface-bounded exosphere, essentially a vacuum. Values for some species can vary with local time or location, these are given as ranges."}'
 );

INSERT INTO planets
 (planet_id, name, star_id, discoverer, discovery_date, mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
   polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
    length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
     max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
      escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
       bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
        moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
         perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
          max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
           sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees,
            apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
             mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
              north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
               magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                dipole_offset_R, surface_field_strength_1_R_gauss,
                 geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                  latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                   atmosphere_composition
 )
   VALUES
 (2,         'Venus',    1, 'Unknown',  NULL,           4.8673,            92.843,                    6051.8,               NULL,
   6051.8,          6051.8,                    12104,        0,              'N',             'N',                       -5832.5,
    2802.0,            0.000,       108.2,                         41.39,                                38.2,
     261.0,                              5243,                         8.87,                  8.87,
      10.36,                    737,                464,                92,                    0.32486,
       0.77,        0.689,            -4.38,           2601.3,                         226.6,                    13,
        0.337,                             4.458,             0.72333199,        108.210,                    224.701,                    224.695,
         107.480,                108.941,              583.92,              224.7,               35.02,
          35.26,                         34.79,                         3.39471,                     0.00677323,
           -5832.6,                      177.36,                     2.64,
            60.0,                                          66.1,                                      9.7,
             NULL,                                      -4.8,                 76.68069,                            131.53298,                       181.97973,
              '272.76',                               '67.16',                            '2000-01-01T12:00:00Z (JD 2451545.0)',
               NULL,                NULL,                                NULL,                                   NULL,
                NULL,            NULL,
                 NULL,                    NULL,                               NULL,
                  NULL,                                 NULL,
                   '{"surface_pressure":{"pressure:":92,"unit":"bar"},"surface_density":{"density":"~65","unit":"kg/m^3"},"scale_height":{"height":15.9,"unit":"km"},"average_temperature":[{"temperature":737,"unit":"K"},{"temperature":464,"unit":"C"}],"diurnal_temperature_range":"~0","total_mass_of_atmosphere":{"mass":"~4.8","scale":"10^20","unit":"kg"},"wind_speed_surface":{"speed":"0.3 - 1.0","unit":"m/s"},"mean_molecular_weight":43.45,"composition":{"major_elements":{"unit":"percent","elements":{"CO2":96.5,"N2":3.5}},"minor_elements":{"unit":"parts per million (ppm)","element":{"SO2":150,"Ar":70,"H2O":20,"CO":17,"He":12,"Ne":7}}}}'
  );

INSERT INTO planets
 (planet_id, name, star_id, discoverer, discovery_date, mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
   polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
    length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
     max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
      escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
       bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
        moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
         perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
          max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
           sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees,
            apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
             mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
              north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
               magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                dipole_offset_R, surface_field_strength_1_R_gauss,
                 geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                  latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                   atmosphere_composition
 )
   VALUES
 (3,         'Earth',    1, NULL,       NULL,           5.9722,            108.321,                   6378.137,             3485,
   6356.752,        6371.000,                  12756,       1,               'N',             'Y',                       23.9,
    24.0000,           0.003353,    149.6,                         NULL,                                 NULL,
     NULL,                                5514,                        9.798,                 9.780,
      11.186,                   288,                15,                 1.014,                 0.39860,
       0.306,       0.434,            -3.99,           1361.0,                         254.0,                    20.4,
        0.3308,                           1082.63,            1.00000011,        149.598,                    365.256,                    365.242,
         147.095,                152.100,              NULL,                365.2,               29.78,
          30.29,                         29.29,                         0.00005,                     0.01671022,
           23.9345,                      23.44,                      23.44,
            NULL,                                          NULL,                                      NULL,
             NULL,                                      NULL,                 -11.26064,                            102.94719,                      100.46435,
              '0.00 - 0.641T',                        '90.00 - 0.557T',                   '2000-01-01T12:00:00Z (JD 2451545.0)',
               'GSFC-1283',         0.306,                               NULL,                                   NULL,
                0.076,           '0.24 - 0.66',
                 'WMM2020',               80.65,                              -72.68,
                  86.50,                                164.04,
                   '{"surface_pressure":{"pressure:":1.014,"unit":"bar"},"surface_density":{"density":1.217,"unit":"kg/m^3"},"scale_height":{"height":8.5,"unit":"km"},"average_temperature":[{"temperature":288,"unit":"K"},{"temperature":15,"unit":"C"}],"diurnal_temperature_range":[{"temperature":"283 - 293","unit":"K"},{"temperature":"10 - 20","unit":"C"}],"total_mass_of_atmosphere":{"mass":5.1,"scale":"10^18","unit":"kg"},"total_mass_of_hydrosphere":{"mass":1.4,"scale":"10^21","unit":"kg"},"wind_speed":{"speed":"0 - 100","unit":"m/s"},"mean_molecular_weight":28.97,"composition":{"major_elements":{"unit":"percent","elements":{"N2":78.08,"O2":20.95}},"minor_elements":{"unit":"parts per million (ppm)","element":{"Ar":9340,"CO2":415,"Ne":18.18,"He":5.24,"CH4":1.7,"Kr":1.14,"H2":0.55}},"comments":"Numbers do not add up to exactly 100% due to roundoff and uncertainty. Water is highly variable, typically makes up about 1%."}}'
  );

INSERT INTO planets
 (planet_id, name, star_id, discoverer, discovery_date, mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
   polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
    length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
     max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
      escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
       bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
        moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
         perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
          max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
           sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees, mean_apparent_diameter_from_earth_s_of_arc,
            apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
             mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
              north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
               magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                dipole_offset_R, surface_field_strength_1_R_gauss,
                 geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                  latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                   atmosphere_composition
 )
   VALUES
 (4,         'Mars',     1, 'Unknown',  NULL,           0.64169,           16.312,                    3396.2,               1700,
   3376.2,          3389.5,                    6792,        2,               'N',             'N',                       24.6,
    24.6597,           0.00589,     228.0,                         78.34,                                54.6,
     401.4,                               3934,                        3.71,                  3.69,
      5.03,                     210,                -63,                0.01,                  0.042828,
       0.250,       0.170,            -1.60,           586.2,                          209.8,                    30,
        0.366,                            1960.45,            1.52366231,        227.956,                    686.980,                    686.973,
         206.650,                249.261,              779.94,              687.0,               24.07,
          26.50,                         21.97,                         1.85061,                     0.09341233,
           24.6229,                      25.19,                      25.19,                          17.8,
            NULL,                                          25.6,                                      3.5,
              -2.0,                                     -2.94,                49.57854,                            336.04084,                       355.45332,
              '317.681 - 0.106T',                     '52.887 - 0.061T',                  '2000-01-01T12:00:00Z (JD 2451545.0)',
               NULL,                NULL,                                NULL,                                   NULL,
                NULL,            NULL,
                 NULL,                    NULL,                               NULL,
                  NULL,                                 NULL,
                   '{"surface_pressure":{"pressure:":0.00636,"unit":"bar"},"surface_density":{"density":0.02,"unit":"kg/m^3"},"scale_height":{"height":11.1,"unit":"km"},"average_temperature":[{"temperature":210,"unit":"K"},{"temperature":-63,"unit":"C"}],"diurnal_temperature_range":[{"temperature":"184 - 242","unit":"K"},{"temperature":"-89 - -31","unit":"C"}],"total_mass_of_atmosphere":{"mass":2.5,"scale":"10^16","unit":"kg"},"wind_speed":{"speed":"2 - 30","unit":"m/s"},"mean_molecular_weight":43.34,"composition":{"major_elements":{"unit":"percent","elements":{"CO2":95.1,"N2":2.59,"Ar":1.94,"O2":0.16,"CO":0.06}},"minor_elements":{"unit":"parts per million (ppm)","element":{"H2O":210,"NO":100,"Ne":2.5,"HDO":0.85,"Kr":0.3,"Xe":0.08}}}}'
   );

INSERT INTO planets
 (planet_id, name, star_id, discoverer, discovery_date, mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
   polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
    length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
     max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
      escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
       bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
        moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
         perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
          max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
           sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees, mean_apparent_diameter_from_earth_s_of_arc,
            apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
             mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
              north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
               magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                dipole_offset_R, surface_field_strength_1_R_gauss,
                 geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                  latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                   atmosphere_composition
 )
   VALUES
 (5,         'Jupiter',  1, 'Unknown',  NULL,           1898.13,           143128,                    71492,                NULL,
   66854,           69911,                     142984,      79,              'Y',             'Y',                       9.9,
    9.9259,            0.06487,     778.5,                         628.81,                               588.5,
     968.5,                               1326,                        24.79,                 23.12,
      59.5,                     163.15,             -110,               NULL,                  126.687,
       0.343,       0.538,            -9.40,           50.26,                          109.9,                    NULL,
        0.254,                            14736,              5.20336301,        778.479,                    4332.589,                   4330.595,
         740.595,                816.363,              398.88,              4331,                13.06,
          13.72,                         12.44,                         1.3053,                      0.04839266,
           9.9250,                       3.13,                       3.13,                           46.9,
            NULL,                                          50.1,                                      30.5,
             -2.7,                                      -2.94,                100.55615,                           14.75385,                        34.40438,
              '268.057 - 0.006T',                     '64.495 + 0.002T',                  '2000-01-01T12:00:00Z (JD 2451545.0)',
               'GSFC-O6',           4.30,                                9.4,                                    200.1,
                0.119,           '4.0 - 13.0',
                 NULL,                    NULL,                               NULL,
                  NULL,                                 NULL,
                   '{"surface_pressure":{"pressure:":">>1000","unit":"bar"},"surface_density":{"density_at_1_bar":0.16,"unit":"kg/m^3"},"scale_height":{"height":27,"unit":"km"},"average_temperature":[{"temperature_at_1_bar":165,"unit":"K"},{"temperature_at_1_bar":-108,"unit":"C"},{"temperature_at_0.1_bar":112,"unit":"K"},{"temperature_at_0.1_bar":-161,"unit":"C"}],"wind_speed":[{"speed":"150","unit":"m/s","degrees_latitude":"<30"},{"speed":"40","unit":"m/s","degrees_latitude":">30"}],"mean_molecular_weight":2.22,"composition":{"major_elements":{"unit":"percent","elements":[{"H2":89.8,"uncertainty":2},{"He":10.2,"uncertainty":2}]},"minor_elements":{"unit":"parts per million (ppm)","element":[{"CH4":3000,"uncertainty":1000},{"NH3":260,"uncertainty":40},{"HD":28,"uncertainty":10},{"C2H6":5.8,"uncertainty":1.5},{"H2O":4}]},"aerosols":["ammonia ice","water ice","ammonia hydrosulfide"]}}'

 );

INSERT INTO planets
 (planet_id, name, star_id, discoverer, discovery_date, mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
   polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
    length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
     max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
      escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
       bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
        moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
         perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
          max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
           sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees, mean_apparent_diameter_from_earth_s_of_arc,
            apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
             mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
              north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
               magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                dipole_offset_R, surface_field_strength_1_R_gauss,
                 geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                  latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                   atmosphere_composition
 )
   VALUES
 (6,         'Saturn',   1, 'Unknown',  NULL,           568.32,            82713,                     60268,                NULL,
   54364,           58232,                     120536,      82,              'Y',             'Y',                       10.7,
    10.656,            0.09796,     1432.0,                        1277.13,                              1205.5,
     1658.6,                              687,                         10.44,                 8.96,
      35.5,                     413.15,             -140,               NULL,                  37.931,
       0.342,       0.499,            -8.91,           14.82,                          81.0,                     NULL,
        0.210,                            16298,              9.53707032,        1432.041,                   10759.22,                   10746.94,
         1357.554,               1506.527,             378.09,              10747,               9.68,
          10.18,                         9.09,                          2.48446,                     0.05415060,
           10.656,                       26.73,                      NULL,                           18.8,
            NULL,                                          19.9,                                      14.5,
             0.7,                                       0.43,                 113.71504,                           92.43194,                        49.94432,
              '40.589 - 0.036T',                      '83.537 - 0.004T',                  '2000-01-01T12:00:00Z (JD 2451545.0)',
               'GSFC-Z3',           0.215,                               0.0,                                    NULL,
                0.038,           '0.18 - 0.84',
                 NULL,                    NULL,                               NULL,
                  NULL,                                 NULL,
                   '{"surface_pressure":{"pressure:":">>1000","unit":"bar"},"surface_density":{"density_at_1_bar":0.19,"unit":"kg/m^3"},"scale_height":{"height":59.5,"unit":"km"},"average_temperature":[{"temperature_at_1_bar":134,"unit":"K"},{"temperature_at_1_bar":-139,"unit":"C"},{"temperature_at_0.1_bar":84,"unit":"K"},{"temperature_at_0.1_bar":-189,"unit":"C"}],"wind_speed":[{"speed":"400","unit":"m/s","degrees_latitude":"<30"},{"speed":"150","unit":"m/s","degrees_latitude":">30"}],"mean_molecular_weight":2.07,"composition":{"major_elements":{"unit":"percent","elements":[{"H2":96.3,"uncertainty":2.4},{"He":3.25,"uncertainty":2.4}]},"minor_elements":{"unit":"parts per million (ppm)","element":[{"CH4":4500,"uncertainty":2000},{"NH3":125,"uncertainty":75},{"HD":110,"uncertainty":58},{"C2H6":7,"uncertainty":1.5}]},"aerosols":["ammonia ice","water ice","ammonia hydrosulfide"]}}'
 );

INSERT INTO planets
 (planet_id, name, star_id, discoverer,          discovery_date,         mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
   polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
    length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
     max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
      escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
       bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
        moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
         perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
          max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
           sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees, mean_apparent_diameter_from_earth_s_of_arc,
            apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
             mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
              north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
               magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                dipole_offset_R, surface_field_strength_1_R_gauss,
                 geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                  latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                   atmosphere_composition
 )
   VALUES
 (7,         'Uranus',   1, 'William Herschel',  '1781-03-13',           86.811,            6833,                      25559,                NULL,
   24973,           25362,                     51118,       27,              'Y',             'Y',                       -17.2,
    17.24,             0.02293,     2867.0,                        2721.37,                              2580.6,
     3153.5,                              1270,                        8.87,                  8.69,
      21.3,                     78.15,              -195,              NULL,                   5.7940,
       0.300,       0.488,            -7.11,           3.69,                           58.1,                     NULL,
        0.225,                            3343.43,            19.19126393,       2867.043,                   30685.4,                    30588.740,
         2732.696,               3001.390,             369.66,              30589,               6.80,
          7.11,                          6.49,                          0.76986,                     0.04716771,
           -17.24,                       97.77,                      82.23,                          3.8,
            NULL,                                          4.1,                                       3.3,
             5.57,                                      5.38,                 74.22988,                            170.96424,                       313.23218,
              '257.311',                              '-15.175',                          '2000-01-01T12:00:00Z (JD 2451545.0)',
               'GSFC-O3',           0.228,                               58.6,                                   53.6,
                0.352,           '~0.1 - 1.0',
                 NULL,                    NULL,                               NULL,
                  NULL,                                 NULL,
                   '{"surface_pressure":{"pressure:":">>1000","unit":"bar"},"surface_density":{"density_at_1_bar":0.42,"unit":"kg/m^3"},"scale_height":{"height":27.7,"unit":"km"},"average_temperature":[{"temperature_at_1_bar":76,"unit":"K"},{"temperature_at_1_bar":-197,"unit":"C"},{"temperature_at_0.1_bar":53,"unit":"K"},{"temperature_at_0.1_bar":-220,"unit":"C"}],"wind_speed":[{"speed":"250","unit":"m/s"}],"mean_molecular_weight":2.64,"composition":{"major_elements":{"unit":"percent","elements":[{"H2":82.5,"uncertainty":3.3},{"He":15.2,"uncertainty":3.3},{"CH4":2.3}]},"minor_elements":{"unit":"parts per million (ppm)","element":[{"HD":148}]},"aerosols":["ammonia ice","water ice","ammonia hydrosulfide","methane ice(?)"]}}'
 );

INSERT INTO planets
 (planet_id, name, star_id, discoverer,                                                                               discovery_date,
   mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
    polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
     length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
      max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
       escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
        bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
         moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
          perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
           max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
            sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees, mean_apparent_diameter_from_earth_s_of_arc,
             apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
              mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
               north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
                magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                 dipole_offset_R, surface_field_strength_1_R_gauss,
                  geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                   latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                    atmosphere_composition
 )
   VALUES
 (8,         'Neptune',  1, 'Johann Gottfried Galle (based on predictions by John Couch Adams and Urbain Leverrier)', '1846-09-23',
   102.409,           6254,                      24764,                NULL,
    24341,           24622,                     49528,       14,              'Y',             'Y',                       16.1,
     16.11,             0.01708,     4515.0,                        4348.66,                              4319.0,
      4711.0,                              1638,                        11.15,                 11.00,
       23.5,                     73.15,              -200,               NULL,                  6.8351,
        0.290,       0.442,            -6.94,           1.508,                          46.6,                     NULL,
         NULL,                             3411,               30.06896348,       4514.953,                   60189,                      59799.9,
          4471.050,               4558.857,             367.49,              59800,               5.43,
           5.50,                          5.37,                          1.76917,                     0.00858587,
            16.11,                        28.32,                      28.32,                          2.3,
             NULL,                                          2.4,                                       2.2,
              7.7,                                       7.67,                 131.72169,                           44.97135,                        304.88003,
               '299.36 + 0.70 sin N',                  '43.46 - 0.51 cos N',               '2000-01-01T12:00:00Z (JD 2451545.0)',
                'GSFC-O8',           0.142,                               46.9,                                   288,
                 0.485,           '~0.1 - 0.9',
                  NULL,                    NULL,                               NULL,
                   NULL,                                 NULL,
                    '{"surface_pressure":{"pressure:":">>1000","unit":"bar"},"surface_density":{"density_at_1_bar":0.45,"unit":"kg/m^3"},"scale_height":{"height":"19.1 - 20.3","unit":"km"},"average_temperature":[{"temperature_at_1_bar":72,"unit":"K"},{"temperature_at_1_bar":-201,"unit":"C"},{"temperature_at_0.1_bar":55,"unit":"K"},{"temperature_at_0.1_bar":-218,"unit":"C"}],"wind_speed":[{"speed":580,"unit":"m/s"}],"mean_molecular_weight":"2.53 - 2.69","composition":{"major_elements":{"unit":"percent","elements":[{"H2":80,"uncertainty":3.2},{"He":19,"uncertainty":3.2},{"CH4":1.5,"uncertainty":0.5}]},"minor_elements":{"unit":"parts per million (ppm)","element":[{"HD":192},{"C2H6":1.5}]},"aerosols":["ammonia ice","water ice","ammonia hydrosulfide","methane ice(?)"]}}'
 );

INSERT INTO planets
 (planet_id, name, star_id, discoverer,     discovery_date,
   mass_kg_10_exp_24, volume_10_exp_10_km_exp_3, equatorial_radius_km, core_radius_km,
    polar_radius_km, mean_volumetric_radius_km, diameter_km, number_of_moons, has_ring_system, has_global_magnetic_field, rotation_period_hrs,
     length_of_day_hrs, ellipticity, distance_from_sun_10_exp_6_km, mean_distance_from_earth_10_exp_6_km, min_distance_from_earth_10_exp_6_km,
      max_distance_from_earth_10_exp_6_km, mean_density_kg_per_m_exp_3, gravity_m_per_s_exp_2, acceleration_m_per_s_exp_2,
       escape_velocity_km_per_s, mean_temperature_K, mean_temperature_C, surface_pressure_bars, gm_10_exp_6_km_exp_3_per_s_exp_2,
        bond_albedo, geometric_albedo, vband_magnitude, solar_irradiance_W_per_m_exp_2, black_body_temperature_K, topographic_range_km,
         moment_of_inertia_I_per_MR_exp_2, J_2_10_exp_minus_6, semimajor_axis_au, semimajor_axis_10_exp_6_km, sidereal_orbit_period_days, tropical_orbit_period_days,
          perihelion_10_exp_6_km, aphelion_10_exp_6_km, synodic_period_days, orbital_period_days, mean_orbital_velocity_km_per_s,
           max_orbital_velocity_km_per_s, min_orbital_velocity_km_per_s, orbital_inclination_degrees, orbital_eccentricity,
            sidereal_rotation_period_hrs, obliquity_to_orbit_degrees, inclination_of_equator_degrees, mean_apparent_diameter_from_earth_s_of_arc,
             apparent_diameter_from_earth_at_1_AU_s_of_arc, max_apparent_diameter_from_earth_s_of_arc, min_apparent_diameter_from_earth_s_of_arc,
              mean_apparent_visual_magnitude_from_earth, max_visual_magnitude, longitude_of_ascending_node_degrees, longitude_of_perihelion_degrees, mean_longitude_degrees,
               north_pole_of_rotation_right_ascension, north_pole_of_rotation_declination, north_pole_of_rotation_reference_date,
                magnetosphere_model, dipole_field_strength_gauss_R_exp_3, dipole_tilt_to_rotational_axis_degrees, longitude_of_tilt_degrees,
                 dipole_offset_R, surface_field_strength_1_R_gauss,
                  geomagnetic_poles_model, latitude_geocentric_dipole_degrees, longitude_geocentric_dipole_degrees,
                   latitude_magnetic_north_pole_degrees, longitude_magnetic_north_pole_degrees,
                    atmosphere_composition
 )
   VALUES
 (9,         'Pluto',  1, 'Clyde Tombaugh', '1930-02-18',
   0.01303,           0.702,                     1188,                 NULL,
    1188,            1188,                      2376,        5,               'N',             NULL,                      -153.3,
     153.2820,          0.0000,      5906.4,                        5756.78,                              4284.7,
      7528.0,                              1854,                        0.62,                  0.62,
       1.21,                     48.15,              -225,               0.000013,              0.000870,
        0.72,        0.52,             -1.0,            0.873,                          37.5,                     NULL,
         NULL,                             NULL,               39.48168677,       5869.656,                   90560,                      NULL,
          4434.987,               7304.326,             366.73,              90560,               4.67,
           6.10,                          3.71,                          17.14175,                    0.24880766,
            -153.2928,                    122.53,                     57.47,                          0.08,
             NULL,                                          0.11,                                      0.06,
              15.1,                                      13.65,                110.30347,                           224.06676,                       238.92881,
               '132.99',                               '-6.16',                            '2000-01-01T12:00:00Z (JD 2451545.0)',
                NULL,                NULL,                                NULL,                                   NULL,
                 NULL,            NULL,
                  NULL,                    NULL,                               NULL,
                    NULL,                                NULL,
                     '{"surface_pressure":{"pressure:":"~13","unit":"microbar"},"scale_height":{"height":"~50","unit":"km"},"average_temperature":[{"temperature":"24 - 38","unit":"K"},{"temperature":"-247 - -233","unit":"C"}],"mean_molecular_weight":"~28","composition":{"major_elements":{"unit":"percent","elements":[{"N2":99},{"CH4":0.5},{"CO":0.05}]},"traces":["HCN","C2HX"]}}'
 );

COMMIT;
