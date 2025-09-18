USE mezcal;
SELECT COUNT(*) AS total_rows FROM bottling_export;
SELECT MIN(Year) AS first_year, MAX(Year) AS last_year FROM bottling_export;
SELECT * FROM bottling_export ORDER BY Year LIMIT 5;

USE mezcal;

CREATE TABLE IF NOT EXISTS bottling_national (
  Year INT,
  Liters DOUBLE
);

USE mezcal;
SELECT COUNT(*) AS total_rows FROM bottling_national;
SELECT MIN(Year) AS first_year, MAX(Year) AS last_year FROM bottling_national;
SELECT * FROM bottling_national ORDER BY Year LIMIT 50;