/*
 * Since: March, 2020
 * Author: gvenzl
 * Name: install.sql
 * Description: DDL setup script
 *
 * Copyright 2020 Gerald Venzl
 *
 * Provided with the generous help of my gorgeous wife Federica Venzl during the
 * Coronavirus (COVID-19) pandemic.
 *
 * This work is licensed under the
 * Creative Commons Attribution 4.0 International Public License, CC BY 4.0
 *
 *    https://creativecommons.org/licenses/by/4.0/
 */ 

/*********************************************/
/***************** REGIONS *******************/
/*********************************************/

CREATE TABLE regions
(
  region_id     VARCHAR(2)   NOT NULL PRIMARY KEY,
  name          VARCHAR(13)  NOT NULL
);

/*********************************************/
/**************** COUNTRIES ******************/
/*********************************************/

CREATE TABLE countries
(
  country_id    VARCHAR(3)    NOT NULL PRIMARY KEY,
  country_code  VARCHAR(2)    NOT NULL,
  name          VARCHAR(100)  NOT NULL,
  official_name VARCHAR(200),
  latitude      NUMERIC(8,5),
  longitude     NUMERIC(8,5),
  population    NUMERIC(10),
  area_sq_km    INTEGER,
  timezone      VARCHAR(40),
  region_id     VARCHAR(2)    NOT NULL,
  
  CONSTRAINT countries_regions_fk001 FOREIGN KEY (region_id) REFERENCES regions (region_id)
);

CREATE INDEX countries_fk_idx001 ON countries (region_id);

/*********************************************/
/***************** CITIES ********************/
/*********************************************/

CREATE TABLE cities
(
  city_id       VARCHAR(7)    NOT NULL PRIMARY KEY,
  name          VARCHAR(100)  NOT NULL,
  official_name VARCHAR(200),
  latitude      NUMERIC(8,5),
  longitude     NUMERIC(8,5),
  population    NUMERIC(8),
  is_capital    CHAR(1)       NOT NULL,
  timezone      VARCHAR(40),
  country_id    VARCHAR(3)    NOT NULL,
  
  CONSTRAINT cities_countries_fk001 FOREIGN KEY (country_id) REFERENCES countries (country_id),
  CONSTRAINT cities_is_capital_Y_N_check001 CHECK (is_capital IN ('Y','N'))
);

CREATE INDEX cities_fk_idx001 ON cities (country_id);

/*********************************************/
/***************** CURRENCIES ****************/
/*********************************************/

CREATE TABLE currencies
(
  currency_id       VARCHAR(3)    NOT NULL PRIMARY KEY,
  name              VARCHAR(50)   NOT NULL,
  official_name     VARCHAR(200),
  symbol            VARCHAR(6)    NOT NULL
);

/*********************************************/
/*********** CURRENCIES_COUNTRIES ************/
/*********************************************/

CREATE TABLE currencies_countries
(
  currency_id    VARCHAR(3)   NOT NULL,
  country_id     VARCHAR(3)   NOT NULL,
  PRIMARY KEY (currency_id, country_id),
  
  CONSTRAINT currencies_countries_currencies_fk001 FOREIGN KEY (currency_id) REFERENCES currencies (currency_id),
  CONSTRAINT currencies_countries_countries_fk002  FOREIGN KEY (country_id)  REFERENCES countries(country_id)
);
