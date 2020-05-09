/*
 * Since: March, 2020
 * Author: gvenzl
 * Name: install.sql
 * Description: DDL setup script
 *
 * Copyright 2020 Gerald Venzl
 *
 * This work is licensed under the
 * Creative Commons Attribution 4.0 International Public License, CC BY 4.0
 *
 * Data Sources:
 * - GeoNames (https://www.geonames.org/)
 * - National Geographic Atlas of the World, Eleventh Edition, October 2019
 *
 * Provided with the generous help of my gorgeous wife Federica Venzl.
 *
 * The Data is provided "as is" without warranty or any representation of
 * accuracy, timeliness or completeness.
 *
 *    https://creativecommons.org/licenses/by/4.0/
 */ 

/*********************************************/
/***************** REGIONS *******************/
/*********************************************/

CREATE TABLE regions
(
  region_id     VARCHAR(2)   NOT NULL,
  name          VARCHAR(13)  NOT NULL
);

CREATE UNIQUE INDEX regions_pk ON regions (region_id);

ALTER TABLE regions ADD
(
  CONSTRAINT regions_pk PRIMARY KEY (region_id)
);

/*********************************************/
/**************** COUNTRIES ******************/
/*********************************************/

CREATE TABLE countries
(
  country_id    VARCHAR(3)    NOT NULL,
  country_code  VARCHAR(2)    NOT NULL,
  name          VARCHAR(100)  NOT NULL,
  official_name VARCHAR(200),
  latitude      NUMBER(8,5),
  longitude     NUMBER(8,5),
  population    INTEGER,
  area_sq_km    INTEGER,
  timezone      VARCHAR(40),
  region_id     VARCHAR(2)    NOT NULL
);

CREATE UNIQUE INDEX countries_pk ON countries (country_id);
CREATE INDEX countries_fk_idx001 ON countries (region_id);

ALTER TABLE countries ADD
(
  CONSTRAINT countries_pk PRIMARY KEY (country_id),
  CONSTRAINT countries_regions_fk001 FOREIGN KEY (region_id) REFERENCES regions (region_id)
);

/*********************************************/
/***************** CITIES ********************/
/*********************************************/

CREATE TABLE cities
(
  city_id       INTEGER       NOT NULL,
  name          VARCHAR(100)  NOT NULL,
  official_name VARCHAR(200),
  latitude      NUMBER(8,5),
  longitude     NUMBER(8,5),
  population    INTEGER,
  is_capital    CHAR(1)       NOT NULL,
  timezone      VARCHAR(40),
  country_id    VARCHAR(3)    NOT NULL
);

CREATE UNIQUE INDEX cities_pk ON cities (city_id);
CREATE INDEX cities_fk_idx001 ON cities (country_id);

ALTER TABLE cities ADD
(
  CONSTRAINT cities_pk PRIMARY KEY (city_id),
  CONSTRAINT cities_countries_fk001 FOREIGN KEY (country_id) REFERENCES countries (country_id),
  CONSTRAINT cities_is_capital_Y_N_check001 CHECK (is_capital IN ('Y','N'))
);

/*********************************************/
/***************** CURRENCIES ****************/
/*********************************************/

CREATE TABLE currencies
(
  currency_id       VARCHAR(3)    NOT NULL,
  name              VARCHAR(50)   NOT NULL,
  official_name     VARCHAR(200),
  currency_symbol   VARCHAR2(1)
);

CREATE UNIQUE INDEX currencies_pk ON currencies (currency_id);

ALTER TABLE	currencies ADD
(
  CONSTRAINT currencies_pk PRIMARY KEY (currency_id)
);

/*********************************************/
/*********** CURRENCIES_COUNTRIES ************/
/*********************************************/

CREATE TABLE currencies_countries
(
  currency_id    VARCHAR(3)   NOT NULL,
  country_id     VARCHAR(3)   NOT NULL
);

CREATE UNIQUE INDEX currencies_countries_pk ON currencies_countries (currency_id, country_id);

ALTER TABLE	currencies_countries ADD
(
  CONSTRAINT currencies_countries_pk PRIMARY KEY (currency_id, country_id),
  CONSTRAINT currencies_countries_currencies_fk001 FOREIGN KEY (currency_id) REFERENCES currencies (currency_id),
  CONSTRAINT currencies_countries_countries_fk002  FOREIGN KEY (country_id)  REFERENCES countries(country_id)
);
