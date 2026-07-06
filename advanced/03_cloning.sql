USE ROLE ACCOUNTADMIN;
GRANT CREATE DATABASE ON ACCOUNT TO ROLE RETAIL_ENGINEER;

USE ROLE RETAIL_ENGINEER;
USE WAREHOUSE TRANSFORM_WH;

-- Clone entire database for dev environment (instantaneous!)
CREATE DATABASE IF NOT EXISTS RETAIL_DW_DEV
    CLONE RETAIL_DW
    COMMENT = 'Development clone of production DW';

-- Clone for testing
CREATE DATABASE IF NOT EXISTS RETAIL_DW_TEST
    CLONE RETAIL_DW
    COMMENT = 'Testing clone of production DW';

-- Clone just the marts schema
CREATE SCHEMA IF NOT EXISTS RETAIL_DW_DEV.MARTS_V2
    CLONE RETAIL_DW.MARTS;

-- Clone a single table for experimentation
CREATE OR REPLACE TABLE RETAIL_DW_DEV.MARTS.FACT_ORDERS_EXPERIMENT
    CLONE RETAIL_DW.MARTS.FACT_ORDERS;

-- Verify clone integrity (fixed: rows -> row_count)
SELECT 'PROD' AS env, COUNT(*) AS row_count, SUM(ORDER_TOTAL_AMOUNT) AS total FROM RETAIL_DW.MARTS.FACT_ORDERS
UNION ALL
SELECT 'DEV',         COUNT(*),              SUM(ORDER_TOTAL_AMOUNT)          FROM RETAIL_DW_DEV.MARTS.FACT_ORDERS;

-- Clones are independent — modifications to clone don't affect origin