USE mezcal;

DROP TABLE IF EXISTS bottling_export;
CREATE TABLE bottling_export (
  Year   INT       NOT NULL,
  Liters DOUBLE    NOT NULL
);