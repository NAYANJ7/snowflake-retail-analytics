CREATE OR REPLACE TABLE STAGING.STG_CUSTOMERS AS
SELECT
    C_CUSTKEY                               AS CUSTOMER_ID,
    TRIM(C_NAME)                            AS CUSTOMER_NAME,
    TRIM(C_ADDRESS)                         AS ADDRESS,
    C_NATIONKEY                             AS NATION_ID,
    TRIM(C_PHONE)                           AS PHONE_NUMBER,
    ROUND(C_ACCTBAL, 2)                     AS ACCOUNT_BALANCE,
    UPPER(TRIM(C_MKTSEGMENT))              AS MARKET_SEGMENT,
    -- Tiering based on account balance
    CASE
        WHEN C_ACCTBAL >= 8000 THEN 'PLATINUM'
        WHEN C_ACCTBAL >= 5000 THEN 'GOLD'
        WHEN C_ACCTBAL >= 2000 THEN 'SILVER'
        WHEN C_ACCTBAL >= 0    THEN 'BRONZE'
        ELSE 'AT_RISK'
    END                                     AS CUSTOMER_TIER,
    _LOADED_AT                              AS RAW_LOADED_AT,
    CURRENT_TIMESTAMP()                     AS STAGED_AT
FROM RAW.CUSTOMER
WHERE C_CUSTKEY IS NOT NULL;