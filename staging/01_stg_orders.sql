USE ROLE RETAIL_ENGINEER;
USE WAREHOUSE TRANSFORM_WH;
USE DATABASE RETAIL_DW;

CREATE OR REPLACE TABLE STAGING.STG_ORDERS AS
SELECT
    O_ORDERKEY                              AS ORDER_ID,
    O_CUSTKEY                               AS CUSTOMER_ID,
    UPPER(TRIM(O_ORDERSTATUS))              AS ORDER_STATUS_CODE,
    ROUND(O_TOTALPRICE, 2)                  AS ORDER_TOTAL_AMOUNT,
    O_ORDERDATE::DATE                       AS ORDER_DATE,
    YEAR(O_ORDERDATE)                       AS ORDER_YEAR,
    MONTH(O_ORDERDATE)                      AS ORDER_MONTH,
    QUARTER(O_ORDERDATE)                    AS ORDER_QUARTER,
    DAYNAME(O_ORDERDATE)                    AS ORDER_DAY_NAME,
    DAYOFWEEK(O_ORDERDATE)                  AS ORDER_DAY_OF_WEEK,
    UPPER(TRIM(O_ORDERPRIORITY))            AS ORDER_PRIORITY,
    UPPER(TRIM(O_CLERK))                    AS CLERK,
    O_SHIPPRIORITY                          AS SHIPPING_PRIORITY,
    -- Decode status code to human-readable
    CASE O_ORDERSTATUS
        WHEN 'O' THEN 'OPEN'
        WHEN 'F' THEN 'FULFILLED'
        WHEN 'P' THEN 'PARTIALLY_FULFILLED'
        ELSE 'UNKNOWN'
    END                                     AS ORDER_STATUS_DESC,
    -- Business segmentation
    CASE
        WHEN O_TOTALPRICE >= 200000 THEN 'HIGH_VALUE'
        WHEN O_TOTALPRICE >= 50000  THEN 'MEDIUM_VALUE'
        ELSE 'LOW_VALUE'
    END                                     AS ORDER_VALUE_TIER,
    -- Metadata passthrough
    _LOADED_AT                              AS RAW_LOADED_AT,
    _SOURCE_SYSTEM,
    CURRENT_TIMESTAMP()                     AS STAGED_AT
FROM RAW.ORDERS
-- Data quality filters
WHERE O_ORDERKEY  IS NOT NULL
  AND O_CUSTKEY   IS NOT NULL
  AND O_ORDERDATE IS NOT NULL
  AND O_TOTALPRICE > 0;