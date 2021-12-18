/*
 * Encoding: UTF-8
 * Since: March, 2020
 * Author: gvenzl
 * Name: install.sql
 * Description: DDL setup and data load script
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
/*********************************************/
/*********************************************/
/****** D a t a m o d e l   s e t u p ********/
/*********************************************/
/*********************************************/
/*********************************************/



/*********************************************/
/***************** REGIONS *******************/
/*********************************************/

CREATE TABLE regions
(
  region_id     VARCHAR(2)   NOT NULL,
  name          VARCHAR(13)  NOT NULL,
  CONSTRAINT regions_pk
    PRIMARY KEY (region_id)
);

/*********************************************/
/**************** COUNTRIES ******************/
/*********************************************/

CREATE TABLE countries
(
  country_id    VARCHAR(3)     NOT NULL,
  country_code  VARCHAR(2)     NOT NULL,
  name          VARCHAR(100)   NOT NULL,
  official_name VARCHAR(200),
  population    NUMERIC(10),
  area_sq_km    NUMERIC(10,2),
  latitude      NUMERIC(8,5),
  longitude     NUMERIC(8,5),
  timezone      VARCHAR(40),
  region_id     VARCHAR(2)     NOT NULL,
  CONSTRAINT countries_pk
    PRIMARY KEY (country_id),
  CONSTRAINT countries_regions_fk001
    FOREIGN KEY (region_id) REFERENCES regions (region_id)
);

CREATE INDEX countries_regions_fk001 ON countries (region_id);

/*********************************************/
/***************** CITIES ********************/
/*********************************************/

CREATE TABLE cities
(
  city_id       VARCHAR(7)    NOT NULL,
  name          VARCHAR(100)  NOT NULL,
  official_name VARCHAR(200),
  population    NUMERIC(8),
  is_capital    CHAR(1)       DEFAULT 'N' NOT NULL,
  latitude      NUMERIC(8,5),
  longitude     NUMERIC(8,5),
  timezone      VARCHAR(40),
  country_id    VARCHAR(3)    NOT NULL,
  CONSTRAINT cities_pk
    PRIMARY KEY (city_id),
  CONSTRAINT cities_countries_fk001
    FOREIGN KEY (country_id) REFERENCES countries (country_id),
  CONSTRAINT cities_is_capital_Y_N_check001
    CHECK (is_capital IN ('Y','N'))
);

CREATE INDEX cities_countries_fk001 ON cities (country_id);

/*********************************************/
/***************** CURRENCIES ****************/
/*********************************************/

CREATE TABLE currencies
(
  currency_id       VARCHAR(3)    NOT NULL,
  name              VARCHAR(50)   NOT NULL,
  official_name     VARCHAR(200),
  symbol            VARCHAR(18)   NOT NULL,
  CONSTRAINT currencies_pk
    PRIMARY KEY (currency_id)
);

/*********************************************/
/*********** CURRENCIES_COUNTRIES ************/
/*********************************************/

CREATE TABLE currencies_countries
(
  currency_id    VARCHAR(3)   NOT NULL,
  country_id     VARCHAR(3)   NOT NULL,
  CONSTRAINT currencies_countries_pk
    PRIMARY KEY (currency_id, country_id),
  CONSTRAINT currencies_countries_currencies_fk001
    FOREIGN KEY (currency_id) REFERENCES currencies (currency_id),
  CONSTRAINT currencies_countries_countries_fk002
    FOREIGN KEY (country_id)  REFERENCES countries(country_id)
);

/*********************************************/
/*********************************************/
/*********************************************/
/*********** D a t a    l o a d **************/
/*********************************************/
/*********************************************/
/*********************************************/


/*********************************************/
/***************** REGIONS *******************/
/*********************************************/

INSERT INTO regions (region_id, name) VALUES ('AF', 'Africa');
INSERT INTO regions (region_id, name) VALUES ('AN', 'Antarctica');
INSERT INTO regions (region_id, name) VALUES ('AS', 'Asia');
INSERT INTO regions (region_id, name) VALUES ('EU', 'Europe');
INSERT INTO regions (region_id, name) VALUES ('NA', 'North America');
INSERT INTO regions (region_id, name) VALUES ('OC', 'Oceania');
INSERT INTO regions (region_id, name) VALUES ('SA', 'South America');

/*********************************************/
/**************** COUNTRIES ******************/
/*********************************************/

INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('AND', 'AD', 'Andorra', 'Principality of Andorra', 86000, 468, 42.55, 1.58333, 'Europe/Andorra', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ARE', 'AE', 'United Arab Emirates', null, 9701000, 83600, 23.75, 54.5, 'Asia/Dubai', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('AFG', 'AF', 'Afghanistan', 'Islamic Republic of Afghanistan', 34941000, 652230, 33, 66, 'Asia/Kabul', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ATG', 'AG', 'Antigua and Barbuda', null, 96000, 443, 17.05, -61.8, 'America/Antigua', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ALB', 'AL', 'Albania', 'Republic of Albania', 3057000, 28748, 41, 20, 'Europe/Tirane', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ARM', 'AM', 'Armenia', 'Republic of Armenia', 3038000, 29743, 40.25, 45, 'Asia/Yerevan', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('AGO', 'AO', 'Angola', 'Republic of Angola', 30356000, 1246700, -12.5, 18.5, 'Africa/Luanda', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ARG', 'AR', 'Argentina', 'Argentine Republic', 44694000, 2780400, -34, -64, null, 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('AUT', 'AT', 'Austria', 'Republic of Austria', 8793000, 83871, 47.33333, 13.33333, 'Europe/Vienna', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('AUS', 'AU', 'Australia', 'Commonwealth of Australia', 23470000, 7741220, -25, 135, null, 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('AZE', 'AZ', 'Azerbaijan', 'Republic of Azerbaijan', 10047000, 86600, 40.5, 47.5, 'Asia/Baku', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BIH', 'BA', 'Bosnia and Herzegovina', null, 3850000, 51197, 44.25, 17.83333, 'Europe/Sarajevo', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BRB', 'BB', 'Barbados', null, 293000, 430, 13.16453, -59.55165, 'America/Barbados', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BGD', 'BD', 'Bangladesh', 'People’s Republic of Bangladesh', 159453000, 148460, 24, 90, 'Asia/Dhaka', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BEL', 'BE', 'Belgium', 'Kingdom of Belgium', 11571000, 30528, 50.75, 4.5, 'Europe/Brussels', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BFA', 'BF', 'Burkina Faso', null, 19743000, 274200, 12.5, -1.66667, 'Africa/Ouagadougou', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BGR', 'BG', 'Bulgaria', 'Republic of Bulgaria', 7058000, 110879, 42.66667, 25.25, 'Europe/Sofia', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BHR', 'BH', 'Bahrain', 'Kingdom of Bahrain', 1443000, 760, 26.03333, 50.55, 'Asia/Bahrain', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BDI', 'BI', 'Burundi', 'Republic of Burundi', 11845000, 27830, -3.5, 30, 'Africa/Bujumbura', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BEN', 'BJ', 'Benin', 'Republic of Benin', 11341000, 112622, 9.5, 2.25, 'Africa/Porto-Novo', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BRN', 'BN', 'Brunei Darussalam', null, 451000, 5765, 4.5, 114.66667, 'Asia/Brunei', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BOL', 'BO', 'Bolivia', 'Plurinational State of Bolivia', 11306000, 1098581, -17, -65, 'America/La_Paz', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BRA', 'BR', 'Brazil', 'Federative Republic of Brazil', 208847000, 8515770, -10, -55, null, 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BHS', 'BS', 'Bahamas', 'Commonwealth of The Bahamas', 333000, 13880, 25.04082, -77.37122, 'America/Nassau', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BTN', 'BT', 'Bhutan', 'Kingdom of Bhutan', 766000, 38394, 27.5, 90.5, 'Asia/Thimphu', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BWA', 'BW', 'Botswana', 'Republic of Botswana', 2249000, 581730, -22, 24, 'Africa/Gaborone', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BLR', 'BY', 'Belarus', 'Republic of Belarus', 9528000, 207600, 53, 28, 'Europe/Minsk', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('BLZ', 'BZ', 'Belize', null, 386000, 22966, 17.25, -88.75, 'America/Belize', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CAN', 'CA', 'Canada', null, 35882000, 9984670, 60.10867, -113.64258, null, 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('COD', 'CD', 'Democratic Republic of the Congo', null, 85281000, 2344858, -2.5, 23.5, null, 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CAF', 'CF', 'Central African Republic', null, 5745000, 622984, 7, 21, 'Africa/Bangui', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('COG', 'CG', 'Congo', 'Republic of the Congo', 5062000, 342000, -1, 15.5, 'Africa/Brazzaville', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CHE', 'CH', 'Switzerland', 'Swiss Confederation', 8293000, 41277, 47.00016, 8.01427, 'Europe/Zurich', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CIV', 'CI', 'Cote d''Ivoire', 'Republic of Côte d’Ivoire', 26261000, 322463, 8, -5.5, 'Africa/Abidjan', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CHL', 'CL', 'Chile', 'Republic of Chile', 17925000, 756102, -30, -71, null, 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CMR', 'CM', 'Cameroon', 'Republic of Cameroon', 25641000, 475440, 6, 12.5, 'Africa/Douala', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CHN', 'CN', 'China', 'People''s Republic of China', 1384689000, 9596960, 35, 105, null, 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('COL', 'CO', 'Colombia', 'Republic of Colombia', 48169000, 1138910, 4, -73.25, 'America/Bogota', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CRI', 'CR', 'Costa Rica', 'Republic of Costa Rica', 4987000, 51100, 10, -84, 'America/Costa_Rica', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CUB', 'CU', 'Cuba', 'Republic of Cuba', 11116000, 110860, 22, -79.5, 'America/Havana', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CPV', 'CV', 'Cabo Verde', 'Republic of Cabo Verde', 568000, 4033, 16, -24, 'Atlantic/Cape_Verde', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CYP', 'CY', 'Cyprus', 'Republic of Cyprus', 1237000, 9251, 35, 33, null, 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('CZE', 'CZ', 'Czechia', 'Czech Republic', 10686000, 78867, 49.75, 15, 'Europe/Prague', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('DEU', 'DE', 'Germany', 'Federal Republic of Germany', 80458000, 357022, 51.5, 10.5, null, 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('DJI', 'DJ', 'Djibouti', 'Republic of Djibouti', 884000, 23200, 11.83333, 42.5, 'Africa/Djibouti', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('DNK', 'DK', 'Denmark', 'Kingdom of Denmark', 5810000, 43094, 56, 10, 'Europe/Copenhagen', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('DMA', 'DM', 'Dominica', 'Commonwealth of Dominica', 74000, 751, 15.5, -61.33333, 'America/Dominica', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('DOM', 'DO', 'Dominican Republic', null, 10299000, 48670, 19, -70.66667, 'America/Santo_Domingo', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('DZA', 'DZ', 'Algeria', 'People’s Democratic Republic of Algeria', 41657000, 2381741, 28, 3, 'Africa/Algiers', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ECU', 'EC', 'Ecuador', 'Republic of Ecuador', 16291000, 283561, -1.25, -78.25, null, 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('EST', 'EE', 'Estonia', 'Republic of Estonia', 1244000, 45228, 59, 26, 'Europe/Tallinn', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('EGY', 'EG', 'Egypt', 'Arab Republic of Egypt', 99413000, 1001450, 27, 30, 'Africa/Cairo', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ERI', 'ER', 'Eritrea', 'State of Eritrea', 5971000, 117600, 15, 39, 'Africa/Asmara', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ESP', 'ES', 'Spain', 'Kingdom of Spain', 49331000, 505370, 40, -4, 'Europe/Madrid', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ETH', 'ET', 'Ethiopia', 'Federal Democratic Republic of Ethiopia', 108386000, 1104300, 9, 39.5, 'Africa/Addis_Ababa', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('FIN', 'FI', 'Finland', 'Republic of Finland', 5537000, 338145, 64, 26, 'Europe/Helsinki', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('FJI', 'FJ', 'Fiji', 'Republic of Fiji', 926000, 18274, -18, 178, 'Pacific/Fiji', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('FSM', 'FM', 'Micronesia', 'Federated States of Micronesia', 104000, 702, 6.91666, 158.18333, null, 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('FRA', 'FR', 'France', 'French Republic', 67364000, 643801, 46, 2, 'Europe/Paris', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GAB', 'GA', 'Gabon', 'Gabonese Republic', 2119000, 267667, -1, 11.75, 'Africa/Libreville', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GBR', 'GB', 'United Kingdom', 'United Kingdom of Great Britain and Northern Ireland', 65105000, 243610, 54.75844, -2.69531, 'Europe/London', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GRD', 'GD', 'Grenada', null, 112000, 344, 12.11667, -61.66667, 'America/Grenada', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GEO', 'GE', 'Georgia', null, 4926000, 69700, 41.99998, 43.4999, 'Asia/Tbilisi', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GHA', 'GH', 'Ghana', 'Republic of Ghana', 28102000, 238533, 8.1, -1.2, 'Africa/Accra', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GMB', 'GM', 'Gambia', 'Republic of The Gambia', 2093000, 11300, 13.5, -15.5, 'Africa/Banjul', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GIN', 'GN', 'Guinea', 'Republic of Guinea', 11855000, 245857, 10.83333, -10.66667, 'Africa/Conakry', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GNQ', 'GQ', 'Equatorial Guinea', 'Republic of Equatorial Guinea', 797000, 28051, 1.7, 10.5, 'Africa/Malabo', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GRC', 'GR', 'Greece', 'Hellenic Republic', 10762000, 131957, 39, 22, 'Europe/Athens', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GTM', 'GT', 'Guatemala', 'Republic of Guatemala', 16581000, 108889, 15.5, -90.25, 'America/Guatemala', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GNB', 'GW', 'Guinea-Bissau', 'Republic of Guinea-Bissau', 1833000, 36125, 12, -15, 'Africa/Bissau', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('GUY', 'GY', 'Guyana', 'Co-operative Republic of Guyana', 741000, 214969, 5, -59, 'America/Guyana', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('HND', 'HN', 'Honduras', 'Republic of Honduras', 9183000, 112090, 15, -86.5, 'America/Tegucigalpa', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('HRV', 'HR', 'Croatia', 'Republic of Croatia', 4270000, 56594, 45.16667, 15.5, 'Europe/Zagreb', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('HTI', 'HT', 'Haiti', 'Republic of Haiti', 10788000, 27750, 19.07582, -72.29616, 'America/Port-au-Prince', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('HUN', 'HU', 'Hungary', null, 9826000, 93028, 47, 20, 'Europe/Budapest', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('IDN', 'ID', 'Indonesia', 'Republic of Indonesia', 262787000, 1904569, -5, 120, null, 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('IRL', 'IE', 'Ireland', 'Éire', 5068000, 70273, 53, -8, 'Europe/Dublin', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ISR', 'IL', 'Israel', 'State of Israel', 8425000, 20770, 31.5, 34.75, 'Asia/Jerusalem', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('IND', 'IN', 'India', 'Republic of India', 1296834000, 3287263, 22, 79, 'Asia/Kolkata', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('IRQ', 'IQ', 'Iraq', 'Republic of Iraq', 40194000, 438317, 33, 44, 'Asia/Baghdad', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('IRN', 'IR', 'Iran', 'Islamic Republic of Iran', 83025000, 1648195, 32, 53, 'Asia/Tehran', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ISL', 'IS', 'Iceland', 'Republic of Iceland', 344000, 103000, 65, -18, 'Atlantic/Reykjavik', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ITA', 'IT', 'Italy', 'Italian Republic', 62247000, 301340, 42.83333, 12.83333, 'Europe/Rome', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('JAM', 'JM', 'Jamaica', null, 2812000, 10991, 18.16667, -77.25, 'America/Jamaica', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('JOR', 'JO', 'Jordan', 'Hashemite Kingdom of Jordan', 10458000, 89342, 31, 36, 'Asia/Amman', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('JPN', 'JP', 'Japan', null, 126168000, 377915, 35.68536, 139.75309, 'Asia/Tokyo', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('KEN', 'KE', 'Kenya', 'Republic of Kenya', 48398000, 580367, 1, 38, 'Africa/Nairobi', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('KGZ', 'KG', 'Kyrgyzstan', 'Kyrgyz Republic', 5849000, 199951, 41.5, 75, 'Asia/Bishkek', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('KHM', 'KH', 'Cambodia', 'Kingdom of Cambodia', 16450000, 181035, 13, 105, 'Asia/Phnom_Penh', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('KIR', 'KI', 'Kiribati', 'Republic of Kiribati', 109000, 811, 1.421, 172.984, null, 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('COM', 'KM', 'Comoros', 'Union of the Comoros', 821000, 2235, -12.23333, 44.44553, 'Indian/Comoro', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('KNA', 'KN', 'Saint Kitts and Nevis', 'Federation of Saint Kitts and Nevis', 53000, 261, 17.33333, -62.75, 'America/Basseterre', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PRK', 'KP', 'North Korea', 'Democratic People''s Republic of Korea', 25381000, 120538, 40, 127, 'Asia/Pyongyang', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('KOR', 'KR', 'South Korea', 'Republic of Korea', 51418000, 99720, 36.5, 127.75, 'Asia/Seoul', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('KWT', 'KW', 'Kuwait', 'State of Kuwait', 4622000, 17818, 29.5, 47.75, 'Asia/Kuwait', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('KAZ', 'KZ', 'Kazakhstan', 'Republic of Kazakhstan', 18745000, 2724900, 48, 68, null, 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LAO', 'LA', 'Laos', 'Lao People''s Democratic Republic', 7234000, 236800, 18, 105, 'Asia/Vientiane', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LBN', 'LB', 'Lebanon', 'Lebanese Republic', 6100000, 10400, 33.83333, 35.83333, 'Asia/Beirut', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LCA', 'LC', 'Saint Lucia', null, 166000, 616, 13.88333, -60.96667, 'America/Castries', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LIE', 'LI', 'Liechtenstein', 'Principality of Liechtenstein', 39000, 160, 47.16667, 9.53333, 'Europe/Vaduz', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LKA', 'LK', 'Sri Lanka', 'Democratic Socialist Republic of Sri Lanka', 22577000, 65610, 7.75, 80.75, 'Asia/Colombo', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LBR', 'LR', 'Liberia', 'Republic of Liberia', 4810000, 111369, 6.5, -9.5, 'Africa/Monrovia', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LSO', 'LS', 'Lesotho', 'Kingdom of Lesotho', 1962000, 30355, -29.5, 28.25, 'Africa/Maseru', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LTU', 'LT', 'Lithuania', 'Republic of Lithuania', 2793000, 65300, 55.41667, 24, 'Europe/Vilnius', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LUX', 'LU', 'Luxembourg', 'Grand Duchy of Luxembourg', 606000, 2586, 49.75, 6.16667, 'Europe/Luxembourg', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LVA', 'LV', 'Latvia', 'Republic of Latvia', 1924000, 64589, 57, 25, 'Europe/Riga', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('LBY', 'LY', 'Libya', 'State of Libya', 6755000, 1759540, 28, 17, 'Africa/Tripoli', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MAR', 'MA', 'Morocco', 'Kingdom of Morocco', 34314000, 446550, 32, -6, 'Africa/Casablanca', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MCO', 'MC', 'Monaco', 'Principality of Monaco', 38000, 2, 43.73141, 7.41903, 'Europe/Monaco', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MDA', 'MD', 'Moldova', 'Republic of Moldova', 3438000, 33851, 47.25, 28.58333, 'Europe/Chisinau', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MNE', 'ME', 'Montenegro', null, 614000, 13812, 42.75, 19.25, 'Europe/Podgorica', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MDG', 'MG', 'Madagascar', 'Republic of Madagascar', 25684000, 587041, -20, 47, 'Indian/Antananarivo', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MHL', 'MH', 'Marshall Islands', 'Republic of the Marshall Islands', 76000, 181, 7.08971, 171.38027, 'Pacific/Majuro', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MKD', 'MK', 'North Macedonia', 'Republic of North Macedonia', 2119000, 25713, 41.66667, 21.75, 'Europe/Skopje', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MLI', 'ML', 'Mali', 'Republic of Mali', 18430000, 1240192, 18, -2, 'Africa/Bamako', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MMR', 'MM', 'Myanmar', 'Republic of the Union of Myanmar', 55623000, 676578, 21, 96, 'Asia/Yangon', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MNG', 'MN', 'Mongolia', null, 3103000, 1564116, 46, 105, null, 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MRT', 'MR', 'Mauritania', 'Islamic Republic of Mauritania', 3840000, 1030700, 20.25, -10.5, 'Africa/Nouakchott', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MLT', 'MT', 'Malta', 'Republic of Malta', 449000, 316, 35.91667, 14.43333, 'Europe/Malta', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MUS', 'MU', 'Mauritius', 'Republic of Mauritius', 1364000, 2040, -20.3, 57.58333, 'Indian/Mauritius', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MDV', 'MV', 'Maldives', 'Republic of Maldives', 392000, 298, 3.2, 73, 'Indian/Maldives', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MWI', 'MW', 'Malawi', 'Republic of Malawi', 19843000, 118484, -13.5, 34, 'Africa/Blantyre', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MEX', 'MX', 'Mexico', 'United Mexican States', 125959000, 1964375, 23, -102, null, 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MYS', 'MY', 'Malaysia', null, 31810000, 329847, 2.5, 112.5, null, 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('MOZ', 'MZ', 'Mozambique', 'Republic of Mozambique', 27234000, 799380, -18.25, 35, 'Africa/Maputo', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NAM', 'NA', 'Namibia', 'Republic of Namibia', 2533000, 824292, -22, 17, 'Africa/Windhoek', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NER', 'NE', 'Niger', 'Republic of Niger', 19866000, 1267000, 18, 9, 'Africa/Niamey', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NGA', 'NG', 'Nigeria', 'Federal Republic of Nigeria', 203453000, 923768, 10, 8, 'Africa/Lagos', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NIC', 'NI', 'Nicaragua', 'Republic of Nicaragua', 6085000, 130370, 13, -85, 'America/Managua', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NLD', 'NL', 'Netherlands', 'Kingdom of Netherlands', 17151000, 41543, 52.25, 5.75, 'Europe/Amsterdam', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NOR', 'NO', 'Norway', 'Kingdom of Norway', 5372000, 323802, 62, 10, 'Europe/Oslo', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NPL', 'NP', 'Nepal', 'Federal Democratic Republic of Nepal', 29718000, 147181, 28, 84, 'Asia/Kathmandu', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NRU', 'NR', 'Nauru', 'Republic of Nauru', 10000, 21, -0.517, 166.933, 'Pacific/Nauru', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('NZL', 'NZ', 'New Zealand', null, 4546000, 268838, -42, 174, null, 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('OMN', 'OM', 'Oman', 'Sultanate of Oman', 3494000, 309500, 21, 57, 'Asia/Muscat', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PAN', 'PA', 'Panama', 'Republic of Panama', 3801000, 75420, 9, -80, 'America/Panama', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PER', 'PE', 'Peru', 'Republic of Peru', 31331000, 1285216, -10, -75.25, 'America/Lima', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PNG', 'PG', 'Papua New Guinea', 'Independent State of Papua New Guinea', 7027000, 462840, -6, 147, null, 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PHL', 'PH', 'Philippines', 'Republic of Philippines', 105893000, 300000, 13, 122, 'Asia/Manila', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PAK', 'PK', 'Pakistan', 'Islamic Republic of Pakistan', 207863000, 796095, 30, 70, 'Asia/Karachi', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('POL', 'PL', 'Poland', 'Republic of Poland', 38421000, 312685, 52, 20, 'Europe/Warsaw', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PRT', 'PT', 'Portugal', 'Portuguese Republic', 10355000, 92090, 39.6945, -8.13057, 'Europe/Lisbon', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PLW', 'PW', 'Palau', 'Republic of Palau', 22000, 459, 7.51507, 134.57524, 'Pacific/Melekeok', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('PRY', 'PY', 'Paraguay', 'Republic of Paraguay', 7026000, 406752, -23.33333, -58, 'America/Asuncion', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('QAT', 'QA', 'Qatar', 'State of Qatar', 2364000, 11586, 25.5, 51.25, 'Asia/Doha', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ROU', 'RO', 'Romania', null, 21457000, 238391, 46, 25, 'Europe/Bucharest', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SRB', 'RS', 'Serbia', 'Republic of Serbia', 7078000, 77474, 44.81892, 20.45998, 'Europe/Belgrade', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('RUS', 'RU', 'Russia', 'Russian Federation', 142123000, 17098242, 60, 100, null, 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('RWA', 'RW', 'Rwanda', 'Republic of Rwanda', 12187000, 26338, -2, 30, 'Africa/Kigali', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SAU', 'SA', 'Saudi Arabia', 'Kingdom of Saudi Arabia', 33091000, 2149690, 25, 45, 'Asia/Riyadh', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SLB', 'SB', 'Solomon Islands', null, 660000, 28896, -8, 159, 'Pacific/Guadalcanal', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SYC', 'SC', 'Seychelles', 'Republic of Seychelles', 95000, 455, -4.58333, 55.66667, 'Indian/Mahe', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SDN', 'SD', 'Sudan', 'Republic of Sudan', 43121000, 1861484, 16, 30, 'Africa/Khartoum', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SWE', 'SE', 'Sweden', 'Kingdom of Sweden', 10041000, 450295, 62, 15, 'Europe/Stockholm', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SGP', 'SG', 'Singapore', 'Republic of Singapore', 5996000, 697, 1.36667, 103.8, 'Asia/Singapore', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SVN', 'SI', 'Slovenia', 'Republic of Slovenia', 2102000, 20273, 46.08333, 15, 'Europe/Ljubljana', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SVK', 'SK', 'Slovakia', 'Slovak Republic', 5445000, 49035, 48.66667, 19.5, 'Europe/Bratislava', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SLE', 'SL', 'Sierra Leone', 'Republic of Sierra Leone', 6312000, 71740, 8.5, -11.5, 'Africa/Freetown', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SMR', 'SM', 'San Marino', 'Republic of San Marino', 34000, 61, 43.9367, 12.4463, 'Europe/San_Marino', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SEN', 'SN', 'Senegal', 'Republic of Senegal', 15021000, 196722, 14.5, -14.25, 'Africa/Dakar', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SOM', 'SO', 'Somalia', 'Federal Republic of Somalia', 11259000, 637657, 6, 48, 'Africa/Mogadishu', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SUR', 'SR', 'Suriname', 'Republic of Suriname', 598000, 163820, 4, -56, 'America/Paramaribo', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SSD', 'SS', 'South Sudan', 'Republic of South Sudan', 10205000, 644329, 7.5, 30, 'Africa/Juba', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('STP', 'ST', 'Sao Tome and Principe', 'Democratic Republic of Sao Tome and Principe', 204000, 964, 1, 7, 'Africa/Sao_Tome', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SLV', 'SV', 'El Salvador', 'Republic of El Salvador', 6187000, 21041, 13.83333, -88.91667, 'America/El_Salvador', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SYR', 'SY', 'Syria', 'Syrian Arab Republic', 19454000, 185180, 35, 38, 'Asia/Damascus', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('SWZ', 'SZ', 'Eswatini', 'Kingdom of Eswatini', 1087000, 17364, -26.5, 31.5, 'Africa/Mbabane', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TCD', 'TD', 'Chad', 'Republic of Chad', 15833000, 1284000, 15, 19, 'Africa/Ndjamena', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TGO', 'TG', 'Togo', 'Togolese Republic', 8176000, 56785, 8.66667, 1.08333, 'Africa/Lome', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('THA', 'TH', 'Thailand', 'Kingdom of Thailand', 68616000, 513120, 15.5, 101, 'Asia/Bangkok', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TJK', 'TJ', 'Tajikistan', 'Republic of Tajikistan', 8605000, 144100, 39, 71, 'Asia/Dushanbe', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TLS', 'TL', 'Timor-Leste', 'Democratic Republic of Timor-Leste', 1322000, 14874, -8.83333, 125.75, 'Asia/Dili', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TKM', 'TM', 'Turkmenistan', null, 5411000, 488100, 39.75, 59.66667, 'Asia/Ashgabat', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TUN', 'TN', 'Tunisia', 'Republic of Tunisia', 11516000, 163610, 34, 9, 'Africa/Tunis', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TON', 'TO', 'Tonga', 'Kingdom of Tonga', 106000, 747, -20, -175, 'Pacific/Tongatapu', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TUR', 'TR', 'Turkey', 'Republic of Turkey', 81257000, 783562, 39, 35, 'Europe/Istanbul', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TTO', 'TT', 'Trinidad and Tobago', 'Republic of Trinidad and Tobago', 1216000, 5128, 11, -61, 'America/Port_of_Spain', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TUV', 'TV', 'Tuvalu', null, 11000, 26, -8.51719, 179.14478, 'Pacific/Funafuti', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TWN', 'TW', 'Taiwan', null, 23546000, 35980, 24, 121, 'Asia/Taipei', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('TZA', 'TZ', 'Tanzania', 'United Republic of Tanzania', 55451000, 947300, -6, 35, 'Africa/Dar_es_Salaam', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('UKR', 'UA', 'Ukraine', null, 43952000, 603550, 49, 32, null, 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('UGA', 'UG', 'Uganda', 'Republic of Uganda', 40854000, 241038, 1.25, 32.5, 'Africa/Kampala', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('USA', 'US', 'United States', 'United States of America', 329256000, 9833517, 39.76, -98.5, null, 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('URY', 'UY', 'Uruguay', 'Oriental Republic of Uruguay', 3369000, 176215, -33, -56, 'America/Montevideo', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('UZB', 'UZ', 'Uzbekistan', 'Republic of Uzbekistan', 30024000, 447400, 41.66667, 63.83333, null, 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('VAT', 'VA', 'Vatican City', 'Vatican City State', 1000, 0.44, 41.90225, 12.4533, 'Europe/Vatican', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('VCT', 'VC', 'Saint Vincent and the Grenadines', null, 102000, 389, 13.08333, -61.2, 'America/St_Vincent', 'NA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('VEN', 'VE', 'Venezuela', 'Bolivarian Republic of Venezuela', 31689000, 912050, 8, -66, 'America/Caracas', 'SA');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('VNM', 'VN', 'Vietnam', 'Socialist Republic of Vietnam', 97040000, 331210, 16.16667, 107.83333, 'Asia/Ho_Chi_Minh', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('VUT', 'VU', 'Vanuatu', 'Republic of Vanuatu', 288000, 12189, -16, 167, 'Pacific/Efate', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('WSM', 'WS', 'Samoa', 'Independent State of Samoa', 201000, 2831, -13.8, -172.13333, 'Pacific/Apia', 'OC');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('XKX', 'XK', 'Kosovo', 'Republic of Kosovo', 1908000, 10887, 42.58333, 20.91667, 'Europe/Belgrade', 'EU');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('YEM', 'YE', 'Yemen', 'Republic of Yemen', 28667000, 527968, 15.5, 47.5, 'Asia/Aden', 'AS');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ZAF', 'ZA', 'South Africa', 'Republic of South Africa', 55380000, 1219090, -29, 24, 'Africa/Johannesburg', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ZMB', 'ZM', 'Zambia', 'Republic of Zambia', 16445000, 752618, -14.33333, 28.5, 'Africa/Lusaka', 'AF');
INSERT INTO countries (country_id, country_code, name, official_name, population, area_sq_km, latitude, longitude, timezone, region_id) VALUES ('ZWE', 'ZW', 'Zimbabwe', 'Republic of Zimbabwe', 14030000, 390757, -19, 29.75, 'Africa/Harare', 'AF');

/*********************************************/
/****************** CITIES *******************/
/*********************************************/

INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('AND0001', 'Andorra la Vella', 23000, 'Y', 42.50779, 1.52109, 'AND');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ARE0001', 'Abu Dhabi', 1420000, 'Y', 24.45118, 54.39696, 'ARE');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('AFG0001', 'Kabul', 4012000, 'Y', 34.52813, 69.17233, 'AFG');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('ATG0001', 'Saint John''s', 'Saint John’s', 21000, 'Y', 17.12096, -61.84329, 'ATG');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ALB0001', 'Tirana', 476000, 'Y', 41.3275, 19.81889, 'ALB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ARM0001', 'Yerevan', 1080000, 'Y', 40.18111, 44.51361, 'ARM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('AGO0001', 'Luanda', 7774000, 'Y', -8.83682, 13.23432, 'AGO');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ARG0001', 'Buenos Aires', 14967000, 'Y', -34.61315, -58.37723, 'ARG');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('AUT0001', 'Vienna', 1901000, 'Y', 48.20849, 16.37208, 'AUT');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('AUS0001', 'Canberra', 423000, 'Y', -35.28346, 149.12807, 'AUS');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('AZE0001', 'Baku', 2286000, 'Y', 40.37767, 49.89201, 'AZE');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BIH0001', 'Sarajevo', 343000, 'Y', 43.84864, 18.35644, 'BIH');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BRB0001', 'Bridgetown', 89000, 'Y', 13.10732, -59.62021, 'BRB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BGD0001', 'Dhaka', 19578000, 'Y', 23.7104, 90.40744, 'BGD');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BEL0001', 'Brussels', 2050000, 'Y', 50.85045, 4.34878, 'BEL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BFA0001', 'Ouagadougou', 2531000, 'Y', 12.36566, -1.53388, 'BFA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BGR0001', 'Sofia', 1272000, 'Y', 42.69751, 23.32415, 'BGR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BHR0001', 'Manama', 565000, 'Y', 26.22787, 50.58565, 'BHR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BDI0001', 'Bujumbura', 899000, 'Y', -3.39249, 29.36169, 'BDI');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('BEN0001', 'Porto Novo', 'Porto-Novo', 285000, 'Y', 6.49646, 2.60359, 'BEN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BRN0001', 'Bandar Seri Begawan', 241000, 'Y', 4.89035, 114.94006, 'BRN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BOL0001', 'Sucre', 278000, 'Y', -19.03332, -65.26274, 'BOL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BOL0002', 'La Paz', 1814000, 'Y', 0, 0, 'BOL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BRA0001', 'Brasilia', 4470000, 'Y', -15.77972, -47.92972, 'BRA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BHS0001', 'Nassau', 280000, 'Y', 25.05823, -77.34306, 'BHS');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BTN0001', 'Thimphu', 203000, 'Y', 27.46609, 89.64191, 'BTN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BWA0001', 'Gaborone', 269000, 'Y', -24.65451, 25.90859, 'BWA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BLR0001', 'Minsk', 2005000, 'Y', 53.9, 27.56667, 'BLR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('BLZ0001', 'Belmopan', 23000, 'Y', 17.25, -88.76667, 'BLZ');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CAN0001', 'Ottawa', 1363000, 'Y', 45.41117, -75.69812, 'CAN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('COD0001', 'Kinshasa', 13171000, 'Y', -4.32758, 15.31357, 'COD');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CAF0001', 'Bangui', 851000, 'Y', 4.36122, 18.55496, 'CAF');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('COG0001', 'Brazzaville', 2230000, 'Y', -4.26613, 15.28318, 'COG');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CHE0001', 'Bern', 422000, 'Y', 46.94809, 7.44744, 'CHE');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CIV0001', 'Abidjan', 4921000, 'Y', 5.36029, -4.00823, 'CIV');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CIV0002', 'Yamoussoukro', 231000, 'Y', 6.82055, -5.27674, 'CIV');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CHL0001', 'Santiago', 6680000, 'Y', -33.45694, -70.64827, 'CHL');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('CMR0001', 'Yaounde', 'Yaoundé', 3412000, 'Y', 3.86667, 11.51667, 'CMR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CHN0001', 'Beijing', 19618000, 'Y', 39.9075, 116.39723, 'CHN');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('COL0001', 'Bogota', 'Bogotá', 10574000, 'Y', 4.60971, -74.08175, 'COL');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('CRI0001', 'San Jose', 'San José', 1358000, 'Y', 9.93333, -84.08333, 'CRI');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CUB0001', 'Havana', 2136000, 'Y', 23.13302, -82.38304, 'CUB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CPV0001', 'Praia', 168000, 'Y', 14.93152, -23.51254, 'CPV');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CYP0001', 'Nicosia', 269000, 'Y', 35.17531, 33.3642, 'CYP');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('CZE0001', 'Prague', 1292000, 'Y', 50.08804, 14.42076, 'CZE');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('DEU0001', 'Berlin', 3563000, 'Y', 52.52437, 13.41053, 'DEU');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('DJI0001', 'Djibouti', 562000, 'Y', 11.58901, 43.14503, 'DJI');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('DNK0001', 'Copenhagen', 1321000, 'Y', 55.67594, 12.56553, 'DNK');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('DMA0001', 'Roseau', 15000, 'Y', 15.30174, -61.38808, 'DMA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('DOM0001', 'Santo Domingo', 3172000, 'Y', 18.47186, -69.89232, 'DOM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('DZA0001', 'Algiers', 2694000, 'Y', 36.73225, 3.08746, 'DZA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ECU0001', 'Quito', 1822000, 'Y', -0.22985, -78.52495, 'ECU');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('EST0001', 'Tallinn', 437000, 'Y', 59.43696, 24.75353, 'EST');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('EGY0001', 'Cairo', 20076000, 'Y', 30.04442, 31.23571, 'EGY');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ERI0001', 'Asmara', 896000, 'Y', 15.33805, 38.93184, 'ERI');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ESP0001', 'Madrid', 6497000, 'Y', 40.4165, -3.70256, 'ESP');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ETH0001', 'Addis Ababa', 4400000, 'Y', 9.02497, 38.74689, 'ETH');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('FIN0001', 'Helsinki', 1279000, 'Y', 60.16952, 24.93545, 'FIN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('FJI0001', 'Suva', 178000, 'Y', -18.14161, 178.44149, 'FJI');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('FSM0001', 'Palikir', 7000, 'Y', 6.92444, 158.16066, 'FSM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('FRA0001', 'Paris', 10901000, 'Y', 48.85341, 2.3488, 'FRA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GAB0001', 'Libreville', 813000, 'Y', 0.39241, 9.45356, 'GAB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GBR0001', 'London', 9046000, 'Y', 51.50853, -0.12574, 'GBR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GRD0001', 'Saint George''s', 39000, 'Y', 12.05288, -61.75226, 'GRD');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GEO0001', 'Tbilisi', 1077000, 'Y', 41.69411, 44.83368, 'GEO');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GHA0001', 'Accra', 2439000, 'Y', 5.55602, -0.1969, 'GHA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GMB0001', 'Banjul', 437000, 'Y', 13.45274, -16.57803, 'GMB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GIN0001', 'Conakry', 1843000, 'Y', 9.53795, -13.67729, 'GIN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GNQ0001', 'Malabo', 297000, 'Y', 3.75578, 8.78166, 'GNQ');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GRC0001', 'Athens', 3156000, 'Y', 37.98376, 23.72784, 'GRC');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GTM0001', 'Guatemala City', 2851000, 'Y', 14.64072, -90.51327, 'GTM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GNB0001', 'Bissau', 558000, 'Y', 11.86357, -15.59767, 'GNB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('GUY0001', 'Georgetown', 110000, 'Y', 6.80448, -58.15527, 'GUY');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('HND0001', 'Tegucigalpa', 1363000, 'Y', 14.0818, -87.20681, 'HND');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('HRV0001', 'Zagreb', 686000, 'Y', 45.81444, 15.97798, 'HRV');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('HTI0001', 'Port au Prince', 'Port-au-Prince', 2637000, 'Y', 18.54349, -72.33881, 'HTI');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('HUN0001', 'Budapest', 1759000, 'Y', 47.49835, 19.04045, 'HUN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('IDN0001', 'Jakarta', 10517000, 'Y', -6.21462, 106.84513, 'IDN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('IRL0001', 'Dublin', 1201000, 'Y', 53.33306, -6.24889, 'IRL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ISR0001', 'Jerusalem', 907000, 'Y', 31.76831, 35.21371, 'ISR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('IND0001', 'New Delhi', 28514000, 'Y', 28.63576, 77.22445, 'IND');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('IRQ0001', 'Baghdad', 6643000, 'Y', 33.34058, 44.40088, 'IRQ');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('IRN0001', 'Tehran', 8896000, 'Y', 35.69439, 51.42151, 'IRN');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('ISL0001', 'Reykjavik', 'Reykjavík', 216000, 'Y', 64.13548, -21.89541, 'ISL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ITA0001', 'Rome', 4210000, 'Y', 41.89193, 12.51133, 'ITA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('JAM0001', 'Kingston', 589000, 'Y', 17.99702, -76.79358, 'JAM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('JOR0001', 'Amman', 2065000, 'Y', 31.95522, 35.94503, 'JOR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('JPN0001', 'Tokyo', 37468000, 'Y', 35.6895, 139.69171, 'JPN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('KEN0001', 'Nairobi', 4386000, 'Y', -1.28333, 36.81667, 'KEN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('KGZ0001', 'Bishkek', 996000, 'Y', 42.87, 74.59, 'KGZ');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('KHM0001', 'Phnom Penh', 1952000, 'Y', 11.56245, 104.91601, 'KHM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('KIR0001', 'Tarawa', 64000, 'Y', 1.3278, 172.97696, 'KIR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('COM0001', 'Moroni', 62000, 'Y', -11.70216, 43.25506, 'COM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('KNA0001', 'Basseterre', 14000, 'Y', 17.2955, -62.72499, 'KNA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('PRK0001', 'Pyongyang', 3038000, 'Y', 39.03385, 125.75432, 'PRK');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('KOR0001', 'Seoul', 9963000, 'Y', 37.566, 126.9784, 'KOR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('KWT0001', 'Kuwait City', 2989000, 'Y', 29.36972, 47.97833, 'KWT');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('KAZ0001', 'Nur Sultan', 'Nur-Sultan', 1068000, 'Y', 51.1801, 71.44598, 'KAZ');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LAO0001', 'Vientiane', 665000, 'Y', 17.96667, 102.6, 'LAO');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LBN0001', 'Beirut', 2385000, 'Y', 33.89332, 35.50157, 'LBN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LCA0001', 'Castries', 22000, 'Y', 13.9957, -61.00614, 'LCA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LIE0001', 'Vaduz', 5000, 'Y', 47.14151, 9.52154, 'LIE');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LKA0001', 'Colombo', 600000, 'Y', 6.93548, 79.84868, 'LKA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LKA0002', 'Sri Jayewardenepura Kotte', 103000, 'Y', 6.88682, 79.91878, 'LKA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LBR0001', 'Monrovia', 1418000, 'Y', 6.30054, -10.7969, 'LBR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LSO0001', 'Maseru', 202000, 'Y', -29.31667, 27.48333, 'LSO');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LTU0001', 'Vilnius', 536000, 'Y', 54.68916, 25.2798, 'LTU');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LUX0001', 'Luxembourg', 120000, 'Y', 49.61167, 6.13, 'LUX');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LVA0001', 'Riga', 637000, 'Y', 56.946, 24.10589, 'LVA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('LBY0001', 'Tripoli', 1158000, 'Y', 32.88743, 13.18733, 'LBY');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MAR0001', 'Rabat', 1847000, 'Y', 34.01325, -6.83255, 'MAR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MCO0001', 'Monaco', 38000, 'Y', 43.73333, 7.41667, 'MCO');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('MDA0001', 'Chisinau', 'Chişinău', 510000, 'Y', 47.00556, 28.8575, 'MDA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MNE0001', 'Podgorica', 177000, 'Y', 42.44111, 19.26361, 'MNE');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MDG0001', 'Antananarivo', 3058000, 'Y', -18.91368, 47.53613, 'MDG');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MHL0001', 'Majuro', 31000, 'Y', 7.08971, 171.38027, 'MHL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MKD0001', 'Skopje', 584000, 'Y', 41.99646, 21.43141, 'MKD');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MLI0001', 'Bamako', 2447000, 'Y', 12.65, -8, 'MLI');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MMR0001', 'Nay Pyi Taw', 1176000, 'Y', 19.745, 96.12972, 'MMR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MNG0001', 'Ulaanbaatar', 1520000, 'Y', 47.92065, 106.91731, 'MNG');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MRT0001', 'Nouakchott', 1205000, 'Y', 18.08581, -15.9785, 'MRT');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MLT0001', 'Valletta', 213000, 'Y', 35.89968, 14.5148, 'MLT');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MUS0001', 'Port Louis', 149000, 'Y', -20.16194, 57.49889, 'MUS');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MDV0001', 'Male', 177000, 'Y', 4.17521, 73.50916, 'MDV');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MWI0001', 'Lilongwe', 1030000, 'Y', -13.96692, 33.78725, 'MWI');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MEX0001', 'Mexico City', 21581000, 'Y', 19.42847, -99.12766, 'MEX');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MYS0001', 'Kuala Lumpur', 7564000, 'Y', 3.1412, 101.68653, 'MYS');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('MOZ0001', 'Maputo', 1102000, 'Y', -25.96553, 32.58322, 'MOZ');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NAM0001', 'Windhoek', 404000, 'Y', -22.55941, 17.08323, 'NAM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NER0001', 'Niamey', 1214000, 'Y', 13.51366, 2.1098, 'NER');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NGA0001', 'Abuja', 2919000, 'Y', 9.05785, 7.49508, 'NGA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NIC0001', 'Managua', 1048000, 'Y', 12.13282, -86.2504, 'NIC');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NLD0001', 'Amsterdam', 1132000, 'Y', 52.37403, 4.88969, 'NLD');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NLD0002', 'The Hague', 685000, 'Y', 52.08009, 4.31375, 'NLD');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NOR0001', 'Oslo', 1012000, 'Y', 59.91273, 10.74609, 'NOR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NPL0001', 'Kathmandu', 1330000, 'Y', 27.70169, 85.3206, 'NPL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NRU0001', 'Yaren', 1000, 'Y', -0.55085, 166.9252, 'NRU');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('NZL0001', 'Wellington', 411000, 'Y', -41.28664, 174.77557, 'NZL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('OMN0001', 'Muscat', 1447000, 'Y', 23.58413, 58.40778, 'OMN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('PAN0001', 'Panama City', 1783000, 'Y', 30.15881, -85.66021, 'PAN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('PER0001', 'Lima', 10391000, 'Y', -12.04318, -77.02824, 'PER');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('PNG0001', 'Port Moresby', 367000, 'Y', -9.47723, 147.15089, 'PNG');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('PHL0001', 'Manila', 13482000, 'Y', 14.6042, 120.9822, 'PHL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('PAK0001', 'Islamabad', 1061000, 'Y', 33.72148, 73.04329, 'PAK');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('POL0001', 'Warsaw', 1768000, 'Y', 52.22977, 21.01178, 'POL');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('PRT0001', 'Lisbon', 2927000, 'Y', 38.71667, -9.13333, 'PRT');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('PLW0001', 'Melekeok', 299, 'Y', 7.49244, 134.63632, 'PLW');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('PRY0001', 'Asuncion', 'Asunción', 3222000, 'Y', -25.28646, -57.647, 'PRY');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('QAT0001', 'Doha', 633000, 'Y', 25.28545, 51.53096, 'QAT');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ROU0001', 'Bucharest', 1821000, 'Y', 44.43225, 26.10626, 'ROU');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SRB0001', 'Belgrade', 1389000, 'Y', 44.80401, 20.46513, 'SRB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('RUS0001', 'Moscow', 12410000, 'Y', 55.75222, 37.61556, 'RUS');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('RWA0001', 'Kigali', 1058000, 'Y', -1.94995, 30.05885, 'RWA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SAU0001', 'Riyadh', 6907000, 'Y', 24.68773, 46.72185, 'SAU');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SLB0001', 'Honiara', 82000, 'Y', -9.43333, 159.95, 'SLB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SYC0001', 'Victoria', 28000, 'Y', -4.62001, 55.45501, 'SYC');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SDN0001', 'Khartoum', 5534000, 'Y', 15.55177, 32.53241, 'SDN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SWE0001', 'Stockholm', 1583000, 'Y', 59.32938, 18.06871, 'SWE');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SGP0001', 'Singapore', 5792000, 'Y', 1.28967, 103.85007, 'SGP');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SVN0001', 'Ljubljana', 286000, 'Y', 46.05108, 14.50513, 'SVN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SVK0001', 'Bratislava', 430000, 'Y', 48.14816, 17.10674, 'SVK');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SLE0001', 'Freetown', 1136000, 'Y', 8.48714, -13.2356, 'SLE');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SMR0001', 'San Marino', 4000, 'Y', 43.93667, 12.44639, 'SMR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SEN0001', 'Dakar', 2978000, 'Y', 14.6937, -17.44406, 'SEN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SOM0001', 'Mogadishu', 2082000, 'Y', 2.03711, 45.34375, 'SOM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SUR0001', 'Paramaribo', 239000, 'Y', 5.86638, -55.16682, 'SUR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SSD0001', 'Juba', 369000, 'Y', 4.85165, 31.58247, 'SSD');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('STP0001', 'Sao Tome', 'São Tomé', 80000, 'Y', 0.33654, 6.72732, 'STP');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SLV0001', 'San Salvador', 1107000, 'Y', 13.68935, -89.18718, 'SLV');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SYR0001', 'Damascus', 2320000, 'Y', 33.5102, 36.29128, 'SYR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SWZ0001', 'Mbabane', 68000, 'Y', -26.31667, 31.13333, 'SWZ');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('SWZ0002', 'Lobamba', 5800, 'Y', -26.44759, 31.20673, 'SWZ');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('TCD0001', 'N''Djamena', 'N’Djamena', 1323000, 'Y', 12.10672, 15.0444, 'TCD');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('TGO0001', 'Lome', 'Lomé', 1746000, 'Y', 6.12874, 1.22154, 'TGO');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('THA0001', 'Bangkok', 10156000, 'Y', 13.75398, 100.50144, 'THA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TJK0001', 'Dushanbe', 873000, 'Y', 38.53575, 68.77905, 'TJK');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('TLS0001', 'Dili', 'Díli', 281000, 'Y', -8.55861, 125.57361, 'TLS');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TKM0001', 'Ashgabat', 810000, 'Y', 37.95, 58.38333, 'TKM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TUN0001', 'Tunis', 2291000, 'Y', 36.81897, 10.16579, 'TUN');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('TON0001', 'Nuku''alofa', 'Nuku’alofa', 23000, 'Y', -21.13938, -175.2018, 'TON');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TUR0001', 'Ankara', 4919000, 'Y', 39.91987, 32.85427, 'TUR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TTO0001', 'Port of Spain', 544000, 'Y', 10.66668, -61.51889, 'TTO');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TUV0001', 'Funafuti', 7000, 'Y', -8.52425, 179.19417, 'TUV');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TWN0001', 'Taipei', 2706000, 'Y', 25.04776, 121.53185, 'TWN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TZA0001', 'Dar es Salaam', 6048000, 'Y', -6.81857, 39.28921, 'TZA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('TZA0002', 'Dodoma', 262000, 'Y', -6.17221, 35.73947, 'TZA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('UKR0001', 'Kiev', 2957000, 'Y', 50.44784, 30.53368, 'UKR');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('UGA0001', 'Kampala', 2986000, 'Y', 0.31628, 32.58219, 'UGA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('USA0001', 'Washington, D.C.', 5207000, 'Y', 38.88978, -77.00906, 'USA');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('URY0001', 'Montevideo', 1737000, 'Y', -34.90328, -56.18816, 'URY');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('UZB0001', 'Tashkent', 2464000, 'Y', 41.26465, 69.21627, 'UZB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('VAT0001', 'Vatican City', 1000, 'Y', 41.90268, 12.45414, 'VAT');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('VCT0001', 'Kingstown', 27000, 'Y', 13.15527, -61.22742, 'VCT');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('VEN0001', 'Caracas', 2935000, 'Y', 10.48801, -66.87919, 'VEN');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('VNM0001', 'Hanoi', 1064000, 'Y', 21.0245, 105.84117, 'VNM');
INSERT INTO cities (city_id, name, official_name, population, is_capital, latitude, longitude, country_id) VALUES ('VUT0001', 'Port Vila', 'Port-Vila', 53000, 'Y', -17.73648, 168.31366, 'VUT');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('WSM0001', 'Apia', 36000, 'Y', -13.83333, -171.76666, 'WSM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('XKX0001', 'Prishtina', 207062, 'Y', 42.66474, 21.16413, 'XKX');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('YEM0001', 'Sanaa', 2779000, 'Y', 15.35472, 44.20667, 'YEM');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ZAF0001', 'Pretoria', 2378000, 'Y', -25.74486, 28.18783, 'ZAF');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ZAF0002', 'Cape Town', 4430000, 'Y', -33.9254, 18.42355, 'ZAF');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ZAF0003', 'Bloemfontein', 465000, 'Y', -29.12036, 26.22535, 'ZAF');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ZMB0001', 'Lusaka', 2524000, 'Y', -15.40669, 28.28713, 'ZMB');
INSERT INTO cities (city_id, name, population, is_capital, latitude, longitude, country_id) VALUES ('ZWE0001', 'Harare', 1515000, 'Y', -17.82772, 31.05337, 'ZWE');

/*********************************************/
/***************** CURRENCIES ****************/
/*********************************************/

INSERT INTO currencies (currency_id, name, symbol) VALUES ('AED', 'UAE Dirham', 'د.إ');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('AFN', 'Afghani', '؋');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ALL', 'Lek', 'L');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('AMD', 'Armenian Dram', '֏');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('AOA', 'Kwanza', 'Kz');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ARS', 'Argentine Peso', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('AUD', 'Australian Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('AZN', 'Azerbaijani Manat', '₼');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BAM', 'Convertible Mark', 'КМ');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BBD', 'Barbados Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BDT', 'Taka', '৳');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BGN', 'Bulgarian Lev', 'лв');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BHD', 'Bahraini Dinar', 'د.ب');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BIF', 'Burundi Franc', 'FBu');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BND', 'Brunei Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BOB', 'Boliviano', 'Bs.');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BRL', 'Brazilian Real', 'R$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BSD', 'Bahamian Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BTN', 'Ngultrum', 'Nu.');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BWP', 'Pula', 'P');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BYN', 'Belarusian Ruble', 'Br');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('BZD', 'Belize Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CAD', 'Canadian Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CDF', 'Congolese Franc', 'FC');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CHF', 'Swiss Franc', 'CHF');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CLP', 'Chilean Peso', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CNY', 'Yuan Renminbi', '¥');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('COP', 'Colombian Peso', '$');
INSERT INTO currencies (currency_id, name, official_name, symbol) VALUES ('CRC', 'Costa Rican Colon', 'Costa Rican Colón', '₡');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CUC', 'Peso Convertible', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CUP', 'Cuban Peso', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CVE', 'Cabo Verde Escudo', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('CZK', 'Czech Koruna', 'Kč');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('DJF', 'Djibouti Franc', 'Fdj');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('DKK', 'Danish Krone', 'kr.');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('DOP', 'Dominican Peso', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('DZD', 'Algerian Dinar', 'دج');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('EGP', 'Egyptian Pound', 'E£');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ERN', 'Nakfa', 'Nkf');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ETB', 'Ethiopian Birr', 'Br');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('EUR', 'Euro', '€');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('FJD', 'Fiji Dollar', 'FJ$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('GBP', 'Pound Sterling', '£');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('GEL', 'Lari', '₾');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('GHS', 'Ghana Cedi', 'GH₵');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('GMD', 'Dalasi', 'D');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('GNF', 'Guinea Franc', 'FG');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('GTQ', 'Quetzal', 'Q');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('GYD', 'Guyana Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('HNL', 'Lempira', 'L');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('HRK', 'Kuna', 'kn');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('HTG', 'Gourde', 'G');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('HUF', 'Forint', 'Ft');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('IDR', 'Rupiah', 'Rp');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ILS', 'New Israeli Sheqel', '₪');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('INR', 'Indian Rupee', '₹');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('IQD', 'Iraqi Dinar', 'د.ع');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('IRR', 'Iranian Rial', '﷼');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ISK', 'Iceland Krona', 'kr');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('JMD', 'Jamaican Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('JOD', 'Jordanian Dinar', 'د.أ');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('JPY', 'Yen', '¥');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('KES', 'Kenyan Shilling', 'KSh');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('KGS', 'Som', 'сом');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('KHR', 'Riel', '៛');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('KMF', 'Comoro Franc', 'CF');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('KPW', 'North Korean Won', '₩');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('KRW', 'Won', '₩');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('KWD', 'Kuwaiti Dinar', 'د.ك');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('KZT', 'Tenge', '₸');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('LAK', 'Lao Kip', '₭');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('LBP', 'Lebanese Pound', 'ل.ل.');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('LKR', 'Sri Lanka Rupee', '₨');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('LRD', 'Liberian Dollar', 'L$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('LSL', 'Loti', 'L');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('LYD', 'Libyan Dinar', 'ل.د');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MAD', 'Moroccan Dirham', 'DH');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MDL', 'Moldovan Leu', 'L');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MGA', 'Malagasy Ariary', 'Ar');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MKD', 'Denar', 'den');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MMK', 'Kyat', 'K');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MNT', 'Tugrik', '₮');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MRU', 'Ouguiya', 'UM');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MUR', 'Mauritius Rupee', '₨');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MVR', 'Rufiyaa', 'Rf');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MWK', 'Malawian Kwacha', 'K');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MXN', 'Mexican Peso', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MYR', 'Malaysian Ringgit', 'RM');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('MZN', 'Mozambique Metical', 'MT');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('NAD', 'Namibian Dollar', 'N$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('NGN', 'Naira', '₦');
INSERT INTO currencies (currency_id, name, official_name, symbol) VALUES ('NIO', 'Cordoba Oro', 'Córdoba Oro', 'C$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('NOK', 'Norwegian Krone', 'kr');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('NPR', 'Nepalese Rupee', '₨');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('NZD', 'New Zealand Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('OMR', 'Rial Omani', 'ر.ع.');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('PEN', 'Sol', 'S/');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('PGK', 'Kina', 'K');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('PHP', 'Philippine Peso', '₱');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('PKR', 'Pakistan Rupee', '₨');
INSERT INTO currencies (currency_id, name, official_name, symbol) VALUES ('PLN', 'Zloty', 'Złoty', 'zł');
INSERT INTO currencies (currency_id, name, official_name, symbol) VALUES ('PYG', 'Guarani', 'Guaraní', '₲');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('QAR', 'Qatari Rial', 'ر.ق');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('RON', 'Romanian Leu', 'L');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('RSD', 'Serbian Dinar', 'дин');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('RUB', 'Russian Ruble', '₽');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('RWF', 'Rwanda Franc', 'FRw');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SAR', 'Saudi Riyal', 'ر.س');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SBD', 'Solomon Islands Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SCR', 'Seychelles Rupee', 'SRe');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SDG', 'Sudanese Pound', 'ج.س');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SEK', 'Swedish Krona', 'kr');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SGD', 'Singapore Dollar', 'S$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SLL', 'Leone', 'Le');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SOS', 'Somali Shilling', 'Sh.So.');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SRD', 'Surinam Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SSP', 'South Sudanese Pound', 'SS£');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('STN', 'Dobra', 'Db');
INSERT INTO currencies (currency_id, name, official_name, symbol) VALUES ('SVC', 'El Salvador Colon', 'El Salvador Colón', '₡');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SYP', 'Syrian Pound', 'LS');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('SZL', 'Lilangeni', 'L');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('THB', 'Baht', '฿');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('TJS', 'Somoni', 'SM');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('TMT', 'Turkmenistan New Manat', 'T');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('TND', 'Tunisian Dinar', 'د.ت');
INSERT INTO currencies (currency_id, name, official_name, symbol) VALUES ('TOP', 'Pa''anga', 'Pa’anga', 'T$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('TRY', 'Turkish Lira', '₺');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('TTD', 'Trinidad and Tobago Dollar', 'TT$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('TWD', 'New Taiwan Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('TZS', 'Tanzanian Shilling', 'TSh');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('UAH', 'Hryvnia', '₴');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('UGX', 'Uganda Shilling', 'USh');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('USD', 'United States Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('UYU', 'Peso Uruguayo', '$U');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('UZS', 'Uzbekistan Sum', 'лв');
INSERT INTO currencies (currency_id, name, official_name, symbol) VALUES ('VES', 'Bolivar Soberano', 'Bolívar Soberano', 'Bs.S.');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('VND', 'Dong', '₫');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('VUV', 'Vatu', 'VT');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('WST', 'Samoan Tala', 'WS$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('XAF', 'Central African CFA Franc', '₣');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('XCD', 'East Caribbean Dollar', '$');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('XOF', 'West African CFA Franc', 'CFA');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('YER', 'Yemeni Rial', 'ر.ي');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ZAR', 'Rand', 'R');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ZMW', 'Zambian Kwacha', 'K');
INSERT INTO currencies (currency_id, name, symbol) VALUES ('ZWL', 'Zimbabwe Dollar', '$');

/*********************************************/
/************ CURRENCIES_COUNTRIES ***********/
/*********************************************/

INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AED', 'ARE');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AFN', 'AFG');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ALL', 'ALB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AMD', 'ARM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AOA', 'AGO');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ARS', 'ARG');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AUD', 'AUS');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AUD', 'KIR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AUD', 'NRU');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AUD', 'TUV');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('AZN', 'AZE');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BAM', 'BIH');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BBD', 'BRB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BDT', 'BGD');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BGN', 'BGR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BHD', 'BHR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BIF', 'BDI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BND', 'BRN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BOB', 'BOL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BRL', 'BRA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BSD', 'BHS');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BTN', 'BTN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('INR', 'BTN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BWP', 'BWA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BYN', 'BLR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('BZD', 'BLZ');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CAD', 'CAN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CDF', 'COD');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CHF', 'CHE');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CHF', 'LIE');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CLP', 'CHL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CNY', 'CHN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('COP', 'COL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CRC', 'CRI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CUC', 'CUB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CUP', 'CUB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CVE', 'CPV');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('CZK', 'CZE');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('DJF', 'DJI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('DKK', 'DNK');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('DOP', 'DOM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('DZD', 'DZA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EGP', 'EGY');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ERN', 'ERI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ETB', 'ETH');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'AND');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'AUT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'BEL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'CYP');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'DEU');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'ESP');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'EST');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'FIN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'FRA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'GRC');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'IRL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'ITA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'LTU');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'LUX');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'LVA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'MCO');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'MLT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'MNE');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'NLD');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'PRT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'SMR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'SVK');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'SVN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'VAT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('EUR', 'XKX');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('FJD', 'FJI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('GBP', 'GBR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('GEL', 'GEO');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('GHS', 'GHA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('GMD', 'GMB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('GNF', 'GIN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('GTQ', 'GTM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('GYD', 'GUY');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('HNL', 'HND');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('HRK', 'HRV');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('HTG', 'HTI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('HUF', 'HUN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('IDR', 'IDN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ILS', 'ISR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('INR', 'IND');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('IQD', 'IRQ');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('IRR', 'IRN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ISK', 'ISL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('JMD', 'JAM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('JOD', 'JOR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('JPY', 'JPN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('KES', 'KEN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('KGS', 'KGZ');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('KHR', 'KHM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('KMF', 'COM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('KPW', 'PRK');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('KRW', 'KOR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('KWD', 'KWT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('KZT', 'KAZ');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('LAK', 'LAO');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('LBP', 'LBN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('LKR', 'LKA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('LRD', 'LBR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('LSL', 'LSO');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('LYD', 'LBY');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MAD', 'MAR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MDL', 'MDA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MGA', 'MDG');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MKD', 'MKD');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MMK', 'MMR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MNT', 'MNG');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MRU', 'MRT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MUR', 'MUS');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MVR', 'MDV');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MWK', 'MWI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MXN', 'MEX');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MYR', 'MYS');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('MZN', 'MOZ');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('NAD', 'NAM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ZAR', 'NAM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('NGN', 'NGA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('NIO', 'NIC');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('NOK', 'NOR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('NPR', 'NPL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('NZD', 'NZL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('OMR', 'OMN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('PEN', 'PER');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('PGK', 'PNG');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('PHP', 'PHL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('PKR', 'PAK');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('PLN', 'POL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('PYG', 'PRY');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('QAR', 'QAT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('RON', 'ROU');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('RSD', 'SRB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('RSD', 'XKX');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('RUB', 'RUS');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('RWF', 'RWA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SAR', 'SAU');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SBD', 'SLB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SCR', 'SYC');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SDG', 'SDN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SEK', 'SWE');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SGD', 'SGP');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SLL', 'SLE');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SOS', 'SOM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SRD', 'SUR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SSP', 'SSD');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('STN', 'STP');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SVC', 'SLV');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SYP', 'SYR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('SZL', 'SWZ');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('THB', 'THA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('TJS', 'TJK');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('TMT', 'TKM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('TND', 'TUN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('TOP', 'TON');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('TRY', 'TUR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('TTD', 'TTO');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('TWD', 'TWN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('TZS', 'TZA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('UAH', 'UKR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('UGX', 'UGA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'ECU');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'FSM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'HTI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'MHL');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'PAN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'PLW');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'SLV');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'TLS');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('USD', 'USA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('UYU', 'URY');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('UZS', 'UZB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('VES', 'VEN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('VND', 'VNM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('VUV', 'VUT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('WST', 'WSM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XAF', 'CAF');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XAF', 'CMR');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XAF', 'COG');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XAF', 'GAB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XAF', 'GNQ');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XAF', 'TCD');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XCD', 'ATG');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XCD', 'DMA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XCD', 'GRD');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XCD', 'KNA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XCD', 'LCA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XCD', 'VCT');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XOF', 'BEN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XOF', 'BFA');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XOF', 'CIV');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XOF', 'GNB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XOF', 'MLI');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XOF', 'NER');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XOF', 'SEN');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('XOF', 'TGO');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('YER', 'YEM');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ZAR', 'LSO');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ZAR', 'ZAF');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ZMW', 'ZMB');
INSERT INTO currencies_countries (currency_id, country_id) VALUES ('ZWL', 'ZWE');

/*********************************************/
/***************** COMMIT ********************/
/*********************************************/

COMMIT;

/*********************************************/
/*************** Verification ****************/
/*********************************************/

SELECT 'Verification:' AS "Verification" FROM regions WHERE region_id = 'EU';

SELECT 'regions' AS "Table", 7 AS "provided", COUNT(1) AS "actual" FROM regions
UNION ALL
SELECT 'countries' AS "Table", 196 AS "provided", COUNT(1) AS "actual" FROM countries
UNION ALL
SELECT 'cities' AS "Table", 204 AS "provided", COUNT(1) AS "actual" FROM cities
UNION ALL
SELECT 'currencies' AS "Table", 146 AS "provided", COUNT(1) AS "actual" FROM currencies
UNION ALL
SELECT 'currencies_countries' AS "Table", 203 AS "provided", COUNT(1) AS "actual" FROM currencies_countries;

SELECT 'The installation is finished, please check the verification output above!' AS "Thank you!"
   FROM regions WHERE region_id = 'EU'
UNION ALL
SELECT 'If the ''provided'' and ''actual'' row counts match, the installation was successful.' AS "Thank you!"
   FROM regions WHERE region_id = 'EU'
UNION ALL
SELECT 'If the row counts do not match, please check the above output for error messages.' AS "Thank you!"
   FROM regions WHERE region_id = 'EU';
