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
SELECT e.Year
FROM bottling_export_dedup AS e
LEFT JOIN production AS p USING (Year)
WHERE p.Year IS NULL;
SELECT n.Year
FROM bottling_national AS n
LEFT JOIN production AS p USING (Year)
WHERE p.Year IS NULL;
SELECT n.Year
FROM bottling_national AS n
LEFT JOIN production AS p USING (Year)
WHERE p.Year IS NULL;

USE mezcal;

-- Production years missing in bottling_export_dedup
SELECT p.Year
FROM production AS p
LEFT JOIN bottling_export_dedup AS e USING (Year)
WHERE e.Year IS NULL
ORDER BY p.Year;

-- Production years missing in bottling_national
SELECT p.Year
FROM production AS p
LEFT JOIN bottling_national AS n USING (Year)
WHERE n.Year IS NULL
ORDER BY p.Year;
USE mezcal;

SELECT DISTINCT i.Year
FROM indicators_2021_2024 AS i
LEFT JOIN production AS p USING (Year)
WHERE p.Year IS NULL
ORDER BY i.Year;
ALTER TABLE bottling_export_dedup
  ADD CONSTRAINT fk_export_year
  FOREIGN KEY (Year) REFERENCES production (Year)
  ON UPDATE CASCADE
  ON DELETE RESTRICT;

ALTER TABLE bottling_national
  ADD CONSTRAINT fk_national_year
  FOREIGN KEY (Year) REFERENCES production (Year)
  ON UPDATE CASCADE
  ON DELETE RESTRICT;

ALTER TABLE indicators_2021_2024
  ADD CONSTRAINT fk_indicators_year
  FOREIGN KEY (Year) REFERENCES production (Year)
  ON UPDATE CASCADE
  ON DELETE RESTRICT;
  SHOW CREATE TABLE indicators_2021_2024\G;
  USE mezcal;
SHOW CREATE TABLE indicators_2021_2024;
USE mezcal;

CREATE OR REPLACE VIEW clean_bottling AS
SELECT 
    p.Year,
    b_exp.Liters AS Export_Liters,
    b_nat.Liters AS National_Liters,
    (b_exp.Liters + b_nat.Liters) AS Total_Bottling,
    ROUND((b_exp.Liters / (b_exp.Liters + b_nat.Liters)) * 100, 2) AS Export_Share_Pct,
    ROUND((b_nat.Liters / (b_exp.Liters + b_nat.Liters)) * 100, 2) AS National_Share_Pct
FROM production p
JOIN bottling_export_dedup b_exp ON p.Year = b_exp.Year
JOIN bottling_national b_nat ON p.Year = b_nat.Year
ORDER BY p.Year;
USE mezcal;

SELECT 
  Year, 
  Export_Liters, 
  National_Liters, 
  Total_Bottling, 
  Export_Share_Pct, 
  National_Share_Pct
FROM clean_bottling
ORDER BY Year
LIMIT 20;

USE mezcal;

CREATE OR REPLACE VIEW clean_production AS
SELECT 
    p.Year,
    p.Production_liters,
    LAG(p.Production_liters) OVER (ORDER BY p.Year) AS Prev_Year_Liters,
    ROUND(
        ((p.Production_liters - LAG(p.Production_liters) OVER (ORDER BY p.Year)) 
        / LAG(p.Production_liters) OVER (ORDER BY p.Year)) * 100, 2
    ) AS YoY_Pct
FROM production p
ORDER BY p.Year;

USE mezcal;

CREATE OR REPLACE VIEW clean_indicators AS
SELECT 
    Year,
    MAX(CASE WHEN Indicator = 'Employment' THEN Value END) AS Employment,
    MAX(CASE WHEN Indicator = 'Brands' THEN Value END) AS Brands,
    MAX(CASE WHEN Indicator = 'Certified_Producers' THEN Value END) AS Certified_Producers
FROM indicators_2021_2024
GROUP BY Year
ORDER BY Year;

CREATE OR REPLACE VIEW kpi_production_cagr AS
WITH bounds AS (
  SELECT MIN(Year) AS start_year, MAX(Year) AS end_year FROM production
),
vals AS (
  SELECT 
    b.start_year,
    b.end_year,
    (SELECT Production_liters FROM production WHERE Year = b.start_year) AS start_liters,
    (SELECT Production_liters FROM production WHERE Year = b.end_year) AS end_liters
  FROM bounds b
)
SELECT 
  start_year,
  end_year,
  start_liters,
  end_liters,
  (end_year - start_year) AS n_years,
  ROUND((POW(end_liters / start_liters, 1 / (end_year - start_year)) - 1) * 100, 2) AS CAGR_Pct
FROM vals;
CREATE OR REPLACE VIEW clean_mezcal AS
SELECT 
  p.Year,
  p.Production_liters,
  p.YoY_Pct,
  b.Export_Liters,
  b.National_Liters,
  b.Total_Bottling,
  b.Export_Share_Pct,
  b.National_Share_Pct
FROM clean_production p
JOIN clean_bottling b USING (Year)
ORDER BY p.Year;
USE mezcal;

CREATE OR REPLACE VIEW clean_mezcal_full AS
SELECT 
    p.Year,
    p.Production_liters,
    p.YoY_Pct,
    b.Export_Liters,
    b.National_Liters,
    b.Total_Bottling,
    b.Export_Share_Pct,
    b.National_Share_Pct,
    i.Employment,
    i.Brands,
    i.Certified_Producers
FROM clean_production p
JOIN clean_bottling b USING (Year)
LEFT JOIN clean_indicators i USING (Year)
ORDER BY p.Year;