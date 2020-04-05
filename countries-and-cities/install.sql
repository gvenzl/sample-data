/*
 * Since: March, 2020
 * Author: gvenzl
 * Name: install.sql
 * Description: DDL and data script
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
/*********************************************/
/*********************************************/
/******************* DDL *********************/
/*********************************************/
/*********************************************/
/*********************************************/

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
  latitude      NUMBER,
  longitude     NUMBER,
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
  city_id       VARCHAR(3)    NOT NULL,
  name          VARCHAR(100)  NOT NULL,
  official_name VARCHAR(200),
  latitude      NUMBER,
  longitude     NUMBER,
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
  CONSTRAINT cities_is_captial_Y_N_check001 CHECK (is_captial IN ('Y','N'))
);

/*********************************************/
/***************** CURRENCIES ****************/
/*********************************************/

CREATE TABLE currencies
(
  currency_id    VARCHAR(3)    NOT NULL,
  name           VARCHAR(50)   NOT NULL,
  country_id     VARCHAR(3)
);

CREATE UNIQUE INDEX currencies_pk ON currencies (currency_id);
CREATE INDEX currencies_fk_idx001 ON currencies (country_id);

ALTER TABLE	currencies ADD
(
  CONSTRAINT currencies_pk PRIMARY KEY (currency_id),
  CONSTRAINT currencies_countries_fk001 FOREIGN KEY (country_id) REFERENCES countries (country_id)
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

/*********************************************/
/*********************************************/
/****************** END **********************/
/*********************************************/
/****************** DDL **********************/
/*********************************************/
/*********************************************/



/*********************************************/
/*********************************************/
/*********************************************/
/****************** DATA *********************/
/*********************************************/
/*********************************************/
/*********************************************/



INSERT INTO regions (region_id, name) VALUES ('AF', 'Africa');
INSERT INTO regions (region_id, name) VALUES ('AS', 'Asia');
INSERT INTO regions (region_id, name) VALUES ('EU', 'Europe');
INSERT INTO regions (region_id, name) VALUES ('NA', 'North America');
INSERT INTO regions (region_id, name) VALUES ('OC', 'Oceania');
INSERT INTO regions (region_id, name) VALUES ('SA', 'South America');
INSERT INTO regions (region_id, name) VALUES ('AN', 'Antarctica');
COMMIT;



INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Kabul', 4012000, 'Y', 'AFG');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Tirana', 476000, 'Y', 'ALB');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Algiers', 2694000, 'Y', 'DZA');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Pago Pago', 49000, 'Y', 'WSM');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Andorra la Vella', 23000, 'Y', 'AND');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Luanda', 7774000, 'Y', 'AGO');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Saint John’s', 21000, 'Y', 'ATG');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Buenos Aires', 14967000, 'Y', 'ARG');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Yerevan', 1080000, 'Y', 'ARM');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Canberra', 423000, 'Y', 'AUS');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Vienna', 1901000, 'Y', 'AUT');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Baku', 2286000, 'Y', 'AZE');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Nassau', 280000, 'Y', 'BHS');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Manama', 565000, 'Y', 'BHR');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Dhaka', 19578000, 'Y', 'BGD');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Bridgetown', 89000, 'Y', 'BRB');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Minsk', 2005000, 'Y', 'BLR');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Brussels', 2050000, 'Y', 'BEL');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Belmopan', 23000, 'Y', 'BLZ');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Porto-Novo', 285000, 'Y', 'BEN');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Thimphu', 203000, 'Y', 'BTN');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Sucre', 278000, 'Y', 'BOL');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Sarajevo', 343000, 'Y', 'BIH');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Gaborone', 269000, 'Y', 'BWA');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Brasilia', 4470000, 'Y', 'BRA');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Bandar Seri Begawan', 241000, 'Y', 'BRN');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Sofia', 1272000, 'Y', 'BGR');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Ouagadougou', 2531000, ''Y', BFA');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Bujumbura', 899000, 'Y', 'BDI');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Praia', 168000, 'Y', 'CPV');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Phnom Penh', 1952000, 'Y', 'KHM');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Yaoundé', 1952000, 'Y', 'CMR');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Ottawa', 1363000, 'Y', 'CAN');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Bangui', 851000, 'Y', 'CAF');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('N’Djamena', 1323000, 'Y', 'TCD');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Santiago', 6680000, 'Y', 'CHL');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Beijing', 19618000, 'Y', 'CHN');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Taipei', 2706000, 'Y', 'TWN');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Bogota', 10574000, 'Y', 'COL');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Moroni', 62000, 'Y', 'COM');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Brazzaville', 2230000, 'Y', 'COG');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Kinshasa', 13171000, 'Y', 'COD');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('San José', 1358000, 'Y', 'CRI');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Yamoussoukro', 231000, 'Y', 'CIV');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Zagreb', 686000, 'Y', 'HRV');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Havana', 2136000, 'Y', 'CUB');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Nicosia', 269000, 'Y', 'CYP');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Prague', 1292000, 'Y', 'CZE');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Copenhagen', 1321000, 'Y', 'DNK');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Djibouti', 562000, 'Y', 'DJI');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Roseau', 15000, 'Y', 'DMA');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Santo Domingo', 3172000, 'Y', 'DOM');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Quito', 1822000, 'Y', 'ECU');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Cario', 20076000, 'Y', 'EGY');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('San Salvador', 1107000, 'Y', 'SLV');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Malabo', 297000, 'Y', 'GNQ');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Asmara', 896000, 'Y', 'ERI');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Tallinn', 437000, 'Y', 'EST');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Mbabane', 68000, 'Y', 'SWZ');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Lobamba', 5800, 'Y', 'SWZ');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Addis Ababa', 4400000, 'Y', 'ETH');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Suva', 178000, 'Y', 'FJI');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Helsinki', 1279000, 'Y', 'FIN');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Paris', 10901000, 'Y', 'FRA');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Libreville', 813000, 'Y', 'GAB');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Banjul', 437000, 'Y', 'GMB');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Tbilisi', 1077000, 'Y', 'GEO');
INSERT INTO cities (name, population, is_captial, country_id) VALUES ('Berlin', 3563000, 'Y', 'DEU');









COMMIT;
/*********************************************/
/***************** CURRENCIES ****************/
/*********************************************/

INSERT INTO currencies (currency_id, name, country_id) VALUES ('AFN', 'Afghani', 'AFG');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('ALL', 'Iek', 'ALB');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('DZD', 'Algerian Dinar', 'DZA');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('WST', 'Samoan Tala', 'WSM');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('EUR', 'Euro', null);
INSERT INTO currencies (currency_id, name, country_id) VALUES ('AOA', 'Kwanza', 'AGO');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('XCD', 'East Caribbean Dollar', 'ATG');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('ARS', 'Argentine Peso', 'ARG');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('AMD', 'Armenian Dram', 'ARM');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('AUD', 'Australian Dollar', 'AUS');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('AZN', 'Azerbaijani Manat', 'AZE');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BSD', 'Bahamian Dollar', 'BHS');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BHD', 'Bahraini Dinar', 'BHR');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BDT', 'Taka', 'BGD');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BBD', 'Barbados Dollar', 'BRB');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BYN', 'Belarusian Ruble', 'BLR');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BZD', 'Belize Dollar', 'BLZ');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('XOF', 'West African CFA franc', null);
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BTN', 'Ngultrum', 'BTN');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BOB', 'Boliviano', 'BOL');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BAM', 'Convertible Mark', 'BIH');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BWP', 'Pula', 'BWA');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BRL', 'Brazilian Real', 'BRA');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BND', 'Brunei Dollar', 'BRN');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BGN', 'Bulgarian Iev', 'BGR');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('BIF', 'Burundi Franc', 'BDI');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CVE', 'Cabo Verde Escudo', 'CPV');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('KHR', 'Riel', 'KHM');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('XAF', 'Central African CFA Franc', null);
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CAD', 'Canadian Dollar', 'CAN');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CLP', 'Chilean Peso', 'CHL');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CNY', 'Yuan Renminbi', 'CHN');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('TWD', 'New Taiwan Dollar', 'TWN');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('COP', 'Colombian Peso', 'COL');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('KMF', 'Comoro Franc', 'COM');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CDF', 'Congolese Franc', 'COD');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CRC', 'Costa Rican Colón', 'CRI');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('HRK', 'Kuna', 'HRV');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CUP', 'Cuban Peso', 'CUB');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CUC', 'Peso Convertible', 'CUB');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('CZK', 'Czech Koruna', 'CZE');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('DKK', 'Danish Krone', 'DNK');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('DJF', 'Djibouti Franc', 'DJI');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('DJF', 'Djibouti Franc', 'DJI');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('XCD', 'Eastern Caribbean Dollar', null);
INSERT INTO currencies (currency_id, name, country_id) VALUES ('DOP', 'Dominican Peso', 'DOM');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('EGP', 'Egyptian Pound', 'EGY');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('SVC', 'El Salvador Colón', 'SLV');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('ERN', 'Nakfa', 'ERI');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('SZL', 'Lilangeni', 'SWZ');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('ETB', 'Ethiopian Birr', 'ETH');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('FJD', 'Fiji Dollar', 'FJI');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('GMD', 'Dalasi', 'GMB');
INSERT INTO currencies (currency_id, name, country_id) VALUES ('GEL', 'Lari', 'GEO');


INSERT INTO currencies (currency_id, name, country_id) VALUES ('USD', 'United States Dollar', null);






COMMIT;


INSERT INTO currencies_countries(currency_id, country_id) VALUES ('EUR', 'AND');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('EUR', 'AUT');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('EUR', 'BEL');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XOF', 'BEN');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XOF', 'BFA');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XAF', 'CMR');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XAF', 'CAF');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XAF', 'TCD');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XAF', 'COG');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XOF', 'CIV');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('EUR', 'CYP');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XCD', 'DMA');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('USD', 'ECU');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('USD', 'SLV');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XAF', 'GNQ');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('EUR', 'EST');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('EUR', 'FIN');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('EUR', 'FRA');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('XAF', 'GAB');
INSERT INTO currencies_countries(currency_id, country_id) VALUES ('EUR', 'DEU');





COMMIT;



/*********************************************/
/**************** COUNTRIES ******************/
/*********************************************/

INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('AND', 'AD', 'Andorra', 'Principality of Andorra', 42.55, 1.58333, 86000, 468, 'Europe/Andorra', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ARE','AE','United Arab Emirates','United Arab Emirates',23.75,54.5,4975593,'Asia/Dubai','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('AFG', 'AF', 'Afghanistan', 'Islamic Republic of Afghanistan', 33, 66, 34941000, 652230, 'Asia/Kabul', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ATG', 'AG', 'Antigua and Barbuda', 'Antigua and Barbuda', 17.05, -61.8, 96000, 443, 'America/Antigua', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ALB', 'AL', 'Albania', 'Republic of Albania', 41, 20, 3057000, 28748, 'Europe/Tirane', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ARM', 'AM', 'Armenia', 'Republic of Armenia', 40.25, 45, 3038000, 29743, 'Asia/Yerevan', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('AGO', 'AO', 'Angola', 'Republic of Angola', -12.5, 18.5, 30356000, 1246700, 'Africa/Luanda', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ARG', 'AR', 'Argentina', 'Argentine Republic', -34, -64, 44694000, 2780400, null, 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('AUT', 'AT', 'Austria', 'Republic of Austria', 47.33333, 13.33333, 8793000, 83871, 'Europe/Vienna', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('AUS', 'AU', 'Australia', 'Commonwealth of Australia', -25, 135, 23470000, 7741220, null, 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('AZE', 'AZ', 'Azerbaijan', 'Republic of Azerbaijan', 40.5, 47.5, 10047000, 86600, 'Asia/Baku', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BIH', 'BA', 'Bosnia and Herzegovina', 'Bosnia and Herzegovina', 44.25, 17.83333, 3850000, 51197, 'Europe/Sarajevo', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BRB', 'BB', 'Barbados', 'Barbados', 13.16453, -59.55165, 293000, 430, 'America/Barbados', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BGD', 'BD', 'Bangladesh', 'Bangladesh', 24, 90, 159453000, 148460, 'Asia/Dhaka', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BEL', 'BE', 'Belgium', 'Kingdom of Belgium', 50.75, 4.5, 11571000, 30528, 'Europe/Brussels', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BFA', 'BF', 'Burkina Faso', 'Burkina Faso', 12.5, -1.66667, 19743000, 274200, 'Africa/Ouagadougou', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BGR', 'BG', 'Bulgaria', 'Republic of Bulgaria', 42.66667, 25.25, 7058000, 110879, 'Europe/Sofia', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BHR', 'BH', 'Bahrain', 'Kingdom of Bahrain', 26.03333, 50.55, 1443000, 760, 'Asia/Bahrain', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BDI', 'BI', 'Burundi', 'Republic of Burundi', -3.5, 30, 11845000, 27830, 'Africa/Bujumbura', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BEN', 'BJ', 'Benin', 'Republic of Benin', 9.5, 2.25, 11341000, 112622, 'Africa/Porto-Novo', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BRN', 'BN', 'Brunei Darussalam', 'Brunei Darussalam', 4.5, 114.66667, 451000, 5765, 'Asia/Brunei', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BOL', 'BO', 'Bolivia', 'Plurinational State of Bolivia', -17, -65, 11306000, 1098581, 'America/La_Paz', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BRA', 'BR', 'Brazil', 'Federative Republic of Brazil', -10, -55, 208847000, 8515770, null, 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BHS', 'BS', 'Bahamas', 'Commonwealth of The Bahamas', 25.04082, -77.37122, 333000, 13880, 'America/Nassau', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BTN', 'BT', 'Bhutan', 'Kingdom of Bhutan', 27.5, 90.5, 766000, 38394, 'Asia/Thimphu', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BWA', 'BW', 'Botswana', 'Republic of Botswana', -22, 24, 2249000, 581730, 'Africa/Gaborone', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BLR', 'BY', 'Belarus', 'Republic of Belarus', 53, 28, 9528000, 270600, 'Europe/Minsk', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('BLZ', 'BZ', 'Belize', 'Belize', 17.25, -88.75, 386000, 22966, 'America/Belize', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CAN', 'CA', 'Canada', 'Canada', 60.10867, -113.64258, 35882000, 9984670, null, 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('COD', 'CD', 'Democratic Republic of the Congo', 'Democratic Republic of the Congo', -2.5, 23.5, 85281000, 2344858, null, 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CAF', 'CF', 'Central African Republic', 'Central African Republic', 7, 21, 5745000, 622984, 'Africa/Bangui', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('COG' ,'CG', 'Congo', 'Republic of the Congo', -1, 15.5, 5062000, 342000, 'Africa/Brazzaville', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CHE','CH','Switzerland','Switzerland',47.00016,8.01427,8484100,'Europe/Zurich','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CIV', 'CI', 'Cote d’Ivoire', 'Republic of Côte d’Ivoire', 8, -5.5, 26261000, 322463, 'Africa/Abidjan', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CHL', 'CL', 'Chile', 'Republic of Chile', -30, -71, 17925000, 756102, null, 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CMR', 'CM', 'Cameroon', 'Republic of Cameroon', 6, 12.5, 25641000, 475440, 'Africa/Douala', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CHN', 'CN', 'China', 'People’s Republic of China', 35, 105, 1384689000, 9596960, null, 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('COL', 'CO', 'Colombia', 'Republic of Colombia', 4, -73.25, 48169000, 1138910, 'America/Bogota', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CRI', 'CR', 'Costa Rica', 'Republic of Costa Rica', 10, -84, 4987000, 51100, 'America/Costa_Rica', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CUB', 'CU', 'Cuba','Republic of Cuba', 22, -79.5, 11116000, 110860, 'America/Havana', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CPV', 'CV', 'Cape Verde', 'Republic of Cabo Verde', 16, -24, 568000, 4033, 'Atlantic/Cape_Verde', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CYP', 'CY', 'Cyprus', 'Republic of Cyprus', 35, 33, 1237000, 9251, null, 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('CZE', 'CZ', 'Czech Republic', 'Czechia', 49.75, 15, 10686000, 78867, 'Europe/Prague', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('DEU', 'DE', 'Germany', 'Federal Republic of Germany', 51.5, 10.5, 80458000, 357022, null, 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('DJI', 'DJ', 'Djibouti', 'Republic of Djibouti', 11.83333, 42.5, 884000, 23200, 'Africa/Djibouti', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('DNK', 'DK', 'Denmark', 'Kingdom of Denmark', 56, 10, 5810000, 43094, 'Europe/Copenhagen', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('DMA', 'DM', 'Dominica', 'Dominica', 15.5, -61.33333, 74000, 751, 'America/Dominica', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('DOM', 'DO', 'Dominican Republic', 'Dominican Republic', 19, -70.66667, 10299000, 48670, 'America/Santo_Domingo', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('DZA', 'DZ', 'Algeria', 'People’s Democratic Republic of Algeria', 28, 3, 41657000, 2381741, 'Africa/Algiers', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ECU', 'EC', 'Ecuador', 'Republic of Ecuador', -1.25, -78.25, 16291000, 283561, null, 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('EST', 'EE', 'Estonia', 'Republic of Estonia', 59, 26, 1244000, 45228, 'Europe/Tallinn', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('EGY', 'EG', 'Egypt', 'Arab Republic of Egypt', 27, 30, 99413000, 1001450, 'Africa/Cairo', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ERI', 'ER', 'Eritrea', 'State of Eritrea', 15, 39, 5971000, 117600, 'Africa/Asmara', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ESP','ES','Spain','Kingdom of Spain',40,-4,46505963,null,'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ETH', 'ET', 'Ethiopia', 'Federal Democratic Republic of Ethiopia', 9, 39.5, 108386000, 1104300, 'Africa/Addis_Ababa', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('FIN', 'FI', 'Finland', 'Republic of Finland', 64, 26, 5537000, 338145, 'Europe/Helsinki', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('FJI', 'FJ', 'Fiji', 'Republic of Fiji', -18, 178, 926000, 18274, 'Pacific/Fiji', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('FRA', 'FR', 'France', 'Republic of France', 46, 2, 67364000, 643801, 'Europe/Paris', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GAB', 'GA', 'Gabon', 'Gabonese Republic', -1, 11.75, 2119000, 267667, 'Africa/Libreville', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GBR','GB','United Kingdom','United Kingdom of Great Britain and Northern Ireland',54.75844,-2.69531,62348447,'Europe/London','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GRD','GD','Grenada','Grenada',12.11667,-61.66667,107818,'America/Grenada','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GEO', 'GE', 'Georgia', 'Georgia', 41.99998, 43.4999, 4926000, 69700, 'Asia/Tbilisi', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GHA','GH','Ghana','Republic of Ghana',8.1,-1.2,24339838,'Africa/Accra','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GMB', 'GM', 'Gambia', 'Republic of The Gambia', 13.5, -15.5, 2093000, 11300, 'Africa/Banjul', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GIN','GN','Guinea','Republic of Guinea',10.83333,-10.66667,10324025,'Africa/Conakry','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GNQ', 'GQ', 'Equatorial Guinea', 'Republic of Equatorial Guinea', 1.7, 10.5, 797000, 28051, 'Africa/Malabo', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GRC','GR','Greece','Hellenic Republic',39,22,11000000,'Europe/Athens','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GTM','GT','Guatemala','Republic of Guatemala',15.5,-90.25,13550440,'America/Guatemala','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GNB','GW','Guinea-Bissau','Republic of Guinea-Bissau',12,-15,1565126,'Africa/Bissau','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('GUY','GY','Guyana','Co-operative Republic of Guyana',5,-59,748486,'America/Guyana','SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('HND','HN','Honduras','Republic of Honduras',15,-86.5,7989415,'America/Tegucigalpa','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('HRV', 'HR', 'Croatia', 'Republic of Croatia', 45.16667, 15.5, 4270000, 56594, 'Europe/Zagreb', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('HTI','HT','Haiti','Republic of Haiti',19.07582,-72.29616,9648924,'America/Port-au-Prince','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('HUN','HU','Hungary','Hungary',47,20,9982000,'Europe/Budapest','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('IDN','ID','Indonesia','Republic of Indonesia',-5,120,242968342,null,'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('IRL','IE','Ireland','Ireland',53,-8,4622917,'Europe/Dublin','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ISR','IL','Israel','State of Israel',31.5,34.75,7353985,'Asia/Jerusalem','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('IND','IN','India','Republic of India',22,79,1173108018,'Asia/Kolkata','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('IRQ','IQ','Iraq','Republic of Iraq',33,44,29671605,'Asia/Baghdad','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('IRN','IR','Iran, Islamic Republic of','Islamic Republic of Iran',32,53,76923300,'Asia/Tehran','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ISL','IS','Iceland','Republic of Iceland',65,-18,308910,'Atlantic/Reykjavik','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ITA','IT','Italy','Italian Republic',42.83333,12.83333,60340328,'Europe/Rome','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('JAM','JM','Jamaica','Jamaica',18.16667,-77.25,2847232,'America/Jamaica','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('JOR','JO','Jordan','Hashemite Kingdom of Jordan',31,36,6407085,'Asia/Amman','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('JPN','JP','Japan','Japan',35.68536,139.75309,127288000,'Asia/Tokyo','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('KEN','KE','Kenya','Republic of Kenya',1,38,40046566,'Africa/Nairobi','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('KGZ','KG','Kyrgyzstan','Kyrgyz Republic',41.5,75,5776500,'Asia/Bishkek','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('KHM', 'KH', 'Cambodia', 'Kingdom of Cambodia', 13, 105, 16450000, 181035, 'Asia/Phnom_Penh', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('KIR','KI','Kiribati','Republic of Kiribati',1.421,172.984,92533,null,'OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('COM', 'KM', 'Comoros', 'Union of the Comoros', -12.23333, 44.44553, 821000, 2235, 'Indian/Comoro', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('KNA','KN','Saint Kitts and Nevis','Federation of Saint Kitts and Nevis',17.33333,-62.75,51134,'America/St_Kitts','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('PRK','KP','North Korea','Democratic People’s Republic of Korea',40,127,22912177,'Asia/Pyongyang','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('KOR','KR','South Korea','Republic of Korea',36.5,127.75,48422644,'Asia/Seoul','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('KWT','KW','Kuwait','State of Kuwait',29.5,47.75,2789132,'Asia/Kuwait','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('KAZ','KZ','Kazakhstan','Republic of Kazakhstan',48,68,15340000,null,'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LAO','LA','Lao People''s Democratic Republic','Lao People’s Democratic Republic',18,105,6368162,'Asia/Vientiane','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LBN','LB','Lebanon','Lebanon',33.83333,35.83333,4125247,'Asia/Beirut','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LCA','LC','Saint Lucia','Saint Lucia',13.88333,-60.96667,160922,'America/St_Lucia','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LIE','LI','Liechtenstein','Principality of Liechtenstein',47.16667,9.53333,35000,'Europe/Vaduz','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LKA','LK','Sri Lanka','Democratic Socialist Republic of Sri Lanka',7.75,80.75,21513990,'Asia/Colombo','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LBR','LR','Liberia','Republic of Liberia',6.5,-9.5,3685076,'Africa/Monrovia','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LSO','LS','Lesotho','Kingdom of Lesotho',-29.5,28.25,1919552,'Africa/Maseru','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LTU','LT','Lithuania','Republic of Lithuania',55.41667,24,2944459,'Europe/Vilnius','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LUX','LU','Luxembourg','Grand Duchy of Luxembourg',49.75,6.16667,497538,'Europe/Luxembourg','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LVA','LV','Latvia','Republic of Latvia',57,25,2217969,'Europe/Riga','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('LBY','LY','Libya','Libya',28,17,6461454,'Africa/Tripoli','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MAR','MA','Morocco','Kingdom of Morocco',32,-6,33848242,'Africa/Casablanca','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MCO','MC','Monaco','Principality of Monaco',43.73141,7.41903,32965,'Europe/Monaco','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MDA','MD','Moldova, Republic of','Republic of Moldova',47.25,28.58333,4324000,'Europe/Chisinau','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MNE','ME','Montenegro','Montenegro',42.75,19.25,666730,'Europe/Podgorica','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MDG','MG','Madagascar','Republic of Madagascar',-20,47,21281844,'Indian/Antananarivo','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MKD','MK','Macedonia, the Former Yugoslav Republic of','North Macedonia',41.66667,21.75,2062294,'Europe/Skopje','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MLI','ML','Mali','Republic of Mali',18,-2,13796354,'Africa/Bamako','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MMR','MM','Myanmar','Union of Burma',21,96,53414374,'Asia/Yangon','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MNG','MN','Mongolia','Mongolia',46,105,3086918,null,'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MRT','MR','Mauritania','Islamic Republic of Mauritania',20.25,-10.5,3205060,'Africa/Nouakchott','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MLT','MT','Malta','Republic of Malta',35.91667,14.43333,403000,'Europe/Malta','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MUS','MU','Mauritius','Republic of Mauritius',-20.3,57.58333,1294104,'Indian/Mauritius','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MDV','MV','Maldives','Republic of Maldives',3.2,73,395650,'Indian/Maldives','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MWI','MW','Malawi','Republic of Malawi',-13.5,34,17563749,'Africa/Blantyre','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MEX','MX','Mexico','Mexico',23,-102,112468855,null,'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MYS','MY','Malaysia','Malaysia',2.5,112.5,28274729,null,'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('MOZ','MZ','Mozambique','Republic of Mozambique',-18.25,35,22061451,'Africa/Maputo','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NAM','NA','Namibia','Republic of Namibia',-22,17,2128471,'Africa/Windhoek','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NER','NE','Niger','Republic of Niger',18,9,15878271,'Africa/Niamey','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NGA','NG','Nigeria','Federal Republic of Nigeria',10,8,154000000,'Africa/Lagos','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NIC','NI','Nicaragua','Republic of Nicaragua',13,-85,5995928,'America/Managua','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NLD','NL','Netherlands','Kingdom of the Netherlands',52.25,5.75,16645000,'Europe/Amsterdam','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NOR','NO','Norway','Kingdom of Norway',62,10,5009150,'Europe/Oslo','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NPL','NP','Nepal','Federal Democratic Republic of Nepal',28,84,28951852,'Asia/Kathmandu','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NRU','NR','Nauru','Nauru',-0.517,166.933,10065,'Pacific/Nauru','OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('NZL','NZ','New Zealand','New Zealand',-42,174,4252277,null,'OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('OMN','OM','Oman','Sultanate of Oman',21,57,2967717,'Asia/Muscat','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('PAN','PA','Panama','Republic of Panama',9,-80,3410676,'America/Panama','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('PER','PE','Peru','Republic of Peru',-10,-75.25,29907003,'America/Lima','SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('PNG','PG','Papua New Guinea','Independent State of Papua New Guinea',-6,147,6064515,null,'OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('PHL','PH','Philippines','Republic of the Philippines',13,122,99900177,'Asia/Manila','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('PAK','PK','Pakistan','Islamic Republic of Pakistan',30,70,184404791,'Asia/Karachi','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('POL','PL','Poland','Republic of Poland',52,20,38500000,'Europe/Warsaw','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('PRT','PT','Portugal','Portuguese Republic',39.6945,-8.13057,10676000,null,'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('PRY','PY','Paraguay','Republic of Paraguay',-23.33333,-58,6375830,'America/Asuncion','SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('QAT','QA','Qatar','State of Qatar',25.5,51.25,840926,'Asia/Qatar','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ROU','RO','Romania','România',46,25,21959278,'Europe/Bucharest','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SRB','RS','Serbia','Serbia',44.81892,20.45998,7344847,'Europe/Belgrade','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('RUS','RU','Russian Federation','Russian Federation',60,100,140702000,null,'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('RWA','RW','Rwanda','Republic of Rwanda',-2,30,11055976,'Africa/Kigali','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SAU','SA','Saudi Arabia','Kingdom of Saudi Arabia',25,45,25731776,'Asia/Riyadh','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SLB','SB','Solomon Islands','Solomon Islands',-8,159,559198,'Pacific/Guadalcanal','OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SYC','SC','Seychelles','Republic of Seychelles',-4.58333,55.66667,88340,'Indian/Mahe','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SDN','SD','Sudan','Republic of the Sudan',16,30,35000000,'Africa/Khartoum','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SWE','SE','Sweden','Kingdom of Sweden',62,15,9828655,'Europe/Stockholm','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SGP','SG','Singapore','Republic of Singapore',1.36667,103.8,4701069,'Asia/Singapore','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SVN','SI','Slovenia','Republic of Slovenia',46.08333,15,2007000,'Europe/Ljubljana','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SVK','SK','Slovakia','Slovak Republic',48.66667,19.5,5455000,'Europe/Bratislava','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SLE','SL','Sierra Leone','Republic of Sierra Leone',8.5,-11.5,5245695,'Africa/Freetown','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SMR','SM','San Marino','Repubblica di San Marino',43.9367,12.4463,31477,'Europe/San_Marino','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SEN','SN','Senegal','Republic of Senegal',14.5,-14.25,12323252,'Africa/Dakar','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SOM','SO','Somalia','Somalia',6,48,10112453,'Africa/Mogadishu','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SUR','SR','Suriname','Republic of Suriname',4,-56,492829,'America/Paramaribo','SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SSD','SS','South Sudan','South Sudan',7.5,30,8260490,'Africa/Juba','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('STP','ST','Sao Tome and Principe','Sao Tome and Principe',1,7,197700,'Africa/Sao_Tome','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SLV', 'SV', 'El Salvador', 'Republic of El Salvador', 13.83333, -88.91667, 6187000, 21041, 'America/El_Salvador', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SYR','SY','Syrian Arab Republic','Syrian Arab Republic',35,38,22198110,'Asia/Damascus','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('SWZ', 'SZ', 'Swaziland', 'Eswatini', -26.5, 31.5, 1087000, 17364, 'Africa/Mbabane', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TCD', 'TD', 'Chad', 'Republic of Chad', 15, 19, 15833000, 1284000, 'Africa/Ndjamena', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TGO','TG','Togo','Togolese Republic',8.66667,1.08333,6587239,'Africa/Lome','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('THA','TH','Thailand','Kingdom of Thailand',15.5,101,67089500,'Asia/Bangkok','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TJK','TJ','Tajikistan','Republic of Tajikistan',39,71,7487489,'Asia/Dushanbe','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TLS','TL','Timor-Leste','Democratic Republic of Timor-Leste',-8.83333,125.75,1154625,'Asia/Dili','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TKM','TM','Turkmenistan','Turkmenistan',39.75,59.66667,4940916,'Asia/Ashgabat','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TUN','TN','Tunisia','Republic of Tunisia',34,9,10589025,'Africa/Tunis','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TON','TO','Tonga','Kingdom of Tonga',-20,-175,122580,'Pacific/Tongatapu','OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TUR','TR','Turkey','Republic of Turkey',39,35,77804122,'Europe/Istanbul','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TTO','TT','Trinidad and Tobago','Republic of Trinidad and Tobago',11,-61,1328019,'America/Port_of_Spain','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TUV','TV','Tuvalu','Tuvalu',-8.51719,179.14478,10472,'Pacific/Funafuti','OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TWN', 'TW', 'Taiwan', 'Taiwan', 24, 121, 23546000, 35980, 'Asia/Taipei', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('TZA','TZ','United Republic of Tanzania','United Republic of Tanzania',-6,35,41892895,'Africa/Dar_es_Salaam','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('UKR','UA','Ukraine','Ukraine',49,32,45415596,null,'EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('UGA','UG','Uganda','Republic of Uganda',1.25,32.5,33398682,'Africa/Kampala','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('USA','US','United States','United States',39.76,-98.5,310232863,null,'NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('URY','UY','Uruguay','Oriental Republic of Uruguay',-33,-56,3477000,'America/Montevideo','SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('UZB','UZ','Uzbekistan','Republic of Uzbekistan',41.66667,63.83333,27865738,null,'AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('VAT','VA','Holy See (Vatican City State)','State of the Vatican City',41.90225,12.4533,921,'Europe/Vatican','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('VCT','VC','Saint Vincent and the Grenadines','Saint Vincent and the Grenadines',13.08333,-61.2,104217,'America/St_Vincent','NA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('VEN','VE','Venezuela','Bolivarian Republic of Venezuela',8,-66,27223228,'America/Caracas','SA');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('VNM','VN','Viet Nam','Socialist Republic of Vietnam',16.16667,107.83333,89571130,'Asia/Ho_Chi_Minh','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('VUT','VU','Vanuatu','Republic of Vanuatu',-16,167,221552,'Pacific/Efate','OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('WSM', 'WS', 'Samoa', 'Independent State of Samoa', -13.8, -172.13333, 51000, 199, 'Pacific/Apia', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('XKX','XK','Kosovo','Republic of Kosovo',42.58333,20.91667,1800000,'Europe/Belgrade','EU');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('YEM','YE','Yemen','Republic of Yemen',15.5,47.5,23495361,'Asia/Aden','AS');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ZAF','ZA','South Africa','Republic of South Africa',-29,24,49000000,'Africa/Johannesburg','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ZMB','ZM','Zambia','Republic of Zambia',-14.33333,28.5,13460305,'Africa/Lusaka','AF');
INSERT INTO countries (country_id, country_code, name, official_name, latitude, longitude, population, area_sq_km, timezone, region_id) VALUES ('ZWE','ZW','Zimbabwe','Republic of Zimbabwe',-19,29.75,13061000,'Africa/Harare','AF');
COMMIT;

/*********************************************/
/*********************************************/
/****************** END **********************/
/*********************************************/
/****************** DATA *********************/
/*********************************************/
/*********************************************/
