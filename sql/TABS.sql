USE mezcal;
SHOW TABLES LIKE 'bottling%';
SELECT COUNT(*) AS n FROM bottling_national;
DESCRIBE bottling_national;
SELECT * FROM bottling_national LIMIT 3;

USE mezcal;
SELECT COUNT(*) FROM bottling_national;
SELECT * FROM bottling_national ORDER BY Year LIMIT 5;

USE mezcal;
SELECT COUNT(*) AS rows FROM bottling_national;
SELECT COUNT(DISTINCT Year) AS distinct_years FROM bottling_national;
SELECT MIN(Year) AS first_year, MAX(Year) AS last_year FROM bottling_national;
SELECT * FROM bottling_national ORDER BY Year LIMIT 5;

USE mezcal;
SHOW TABLES LIKE 'indicator%';
DESCRIBE indicators_2021_2024;

ALTER TABLE `indicators_2021_2024`
  MODIFY COLUMN `Year` INT NOT NULL,
  MODIFY COLUMN `Indicator` VARCHAR(64) NOT NULL,
  MODIFY COLUMN `Value` DOUBLE;
  
USE mezcal;
DESCRIBE indicators_2021_2024;

SELECT COUNT(*) AS rows, MIN(Year) AS first_year, MAX(Year) AS last_year
FROM indicators_2021_2024;

SELECT Indicator, COUNT(*) AS n
FROM indicators_2021_2024
GROUP BY Indicator;

SELECT *
FROM indicators_2021_2024
ORDER BY Year, Indicator
LIMIT 5;
USE mezcal;
SELECT
  COUNT(*) AS total_rows,
  MIN(`Year`) AS first_year,
  MAX(`Year`) AS last_year
FROM indicators_2021_2024;
SELECT Indicator, COUNT(*) AS rows_per_indicator
FROM indicators_2021_2024
GROUP BY Indicator
ORDER BY Indicator;

SELECT
  SUM(Year IS NULL)      AS null_years,
  SUM(Indicator IS NULL) AS null_indicators,
  SUM(Value IS NULL)     AS null_values
FROM indicators_2021_2024;

SELECT *
FROM indicators_2021_2024
WHERE Value < 0
LIMIT 10;

SELECT COUNT(*) AS total_rows,
       MIN(Year) AS first_year,
       MAX(Year) AS last_year
FROM indicators_2021_2024;

SELECT Year, Indicator, COUNT(*) AS c
FROM indicators_2021_2024
GROUP BY Year, Indicator
HAVING c > 1;

ALTER TABLE indicators_2021_2024
ADD CONSTRAINT uq_year_indicator UNIQUE (Year, Indicator);

USE mezcal;

ALTER TABLE production
  ADD CONSTRAINT pk_production PRIMARY KEY (Year);

ALTER TABLE bottling_export
  ADD CONSTRAINT pk_bottling_export PRIMARY KEY (Year);

ALTER TABLE bottling_national
  ADD CONSTRAINT pk_bottling_national PRIMARY KEY (Year);
SELECT COUNT(*) AS total_rows, COUNT(DISTINCT Year) AS distinct_years
FROM bottling_export;

SELECT Year, COUNT(*) AS c, MIN(Liters) AS min_liters, MAX(Liters) AS max_liters
FROM bottling_export
GROUP BY Year
HAVING c > 1
ORDER BY Year;
USE mezcal;

CREATE TABLE bottling_export_dedup AS
SELECT Year, MAX(Liters) AS Liters
FROM bottling_export
GROUP BY Year;

USE mezcal;

CREATE TABLE bottling_export_dedup AS
SELECT Year, MAX(Liters) AS Liters
FROM bottling_export
GROUP BY Year;

USE mezcal;

DROP TABLE IF EXISTS bottling_export_dedup;

CREATE TABLE bottling_export_dedup AS
SELECT Year, MAX(Liters) AS Liters
FROM bottling_export
GROUP BY Year;

USE mezcal;
ALTER TABLE bottling_export_dedup
  ADD CONSTRAINT pk_bottling_export_dedup PRIMARY KEY (Year);
  SELECT COUNT(*) AS total_rows, COUNT(DISTINCT Year) AS distinct_years
FROM bottling_export_dedup;
USE mezcal;
SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT Year) AS distinct_years
FROM production;
SELECT Year, COUNT(*) AS c
FROM production
GROUP BY Year
HAVING c > 1;
USE mezcal;

ALTER TABLE production
  MODIFY COLUMN Year INT NOT NULL,
  ADD CONSTRAINT pk_production PRIMARY KEY (Year);
