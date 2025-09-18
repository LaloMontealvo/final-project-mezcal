CREATE SCHEMA IF NOT EXISTS mezcal DEFAULT CHARACTER SET utf8mb4;
USE mezcal;

DROP TABLE IF EXISTS production;
CREATE TABLE production (
  Year INT,
  Production_liters DOUBLE
);