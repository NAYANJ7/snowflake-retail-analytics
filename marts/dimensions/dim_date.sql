USE ROLE RETAIL_ENGINEER;
USE WAREHOUSE TRANSFORM_WH;
USE DATABASE RETAIL_DW;

CREATE OR REPLACE TABLE MARTS.DIM_DATE AS
WITH date_spine AS (
    -- Generate every date from 1992-01-01 to 2000-12-31
    SELECT DATEADD('day', SEQ4(), '1992-01-01'::DATE) AS DATE_DAY
    FROM TABLE(GENERATOR(ROWCOUNT => 3287))  -- ~9 years
)
SELECT
    -- Surrogate key: YYYYMMDD integer
    TO_NUMBER(TO_CHAR(DATE_DAY, 'YYYYMMDD'))    AS DATE_KEY,
    DATE_DAY                                    AS FULL_DATE,
    YEAR(DATE_DAY)                              AS YEAR,
    QUARTER(DATE_DAY)                           AS QUARTER_NUM,
    CONCAT('Q', QUARTER(DATE_DAY))              AS QUARTER_ABBR,
    MONTH(DATE_DAY)                             AS MONTH_NUM,
    MONTHNAME(DATE_DAY)                         AS MONTH_NAME,
    LEFT(MONTHNAME(DATE_DAY), 3)                AS MONTH_SHORT,
    WEEK(DATE_DAY)                              AS WEEK_OF_YEAR,
    DAYOFYEAR(DATE_DAY)                         AS DAY_OF_YEAR,
    DAYOFMONTH(DATE_DAY)                        AS DAY_OF_MONTH,
    DAYOFWEEK(DATE_DAY)                         AS DAY_OF_WEEK_NUM,
    DAYNAME(DATE_DAY)                           AS DAY_NAME,
    LEFT(DAYNAME(DATE_DAY), 3)                  AS DAY_SHORT,
    CASE WHEN DAYOFWEEK(DATE_DAY) IN (0,6) THEN TRUE ELSE FALSE END AS IS_WEEKEND,
    CASE WHEN DAYOFWEEK(DATE_DAY) IN (0,6) THEN FALSE ELSE TRUE END AS IS_WEEKDAY,
    -- Composite labels
    CONCAT('Q', QUARTER(DATE_DAY), ' ', YEAR(DATE_DAY)) AS QUARTER_YEAR_LABEL,
    CONCAT(YEAR(DATE_DAY), '-', LPAD(MONTH(DATE_DAY), 2, '0')) AS YEAR_MONTH,
    -- Fiscal year (assuming Jan fiscal start)
    YEAR(DATE_DAY)                              AS FISCAL_YEAR,
    QUARTER(DATE_DAY)                           AS FISCAL_QUARTER
FROM date_spine;

-- Verify
SELECT MIN(FULL_DATE), MAX(FULL_DATE), COUNT(*) FROM MARTS.DIM_DATE;