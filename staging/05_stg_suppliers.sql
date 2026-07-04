CREATE OR REPLACE TABLE STAGING.STG_SUPPLIERS AS
SELECT
    S_SUPPKEY                               AS SUPPLIER_ID,
    TRIM(S_NAME)                            AS SUPPLIER_NAME,
    TRIM(S_ADDRESS)                         AS ADDRESS,
    S_NATIONKEY                             AS NATION_ID,
    TRIM(S_PHONE)                           AS PHONE_NUMBER,
    ROUND(S_ACCTBAL, 2)                     AS ACCOUNT_BALANCE,
    CASE
        WHEN S_ACCTBAL >= 8000 THEN 'PREFERRED'
        WHEN S_ACCTBAL >= 4000 THEN 'STANDARD'
        ELSE 'PROBATION'
    END                                     AS SUPPLIER_TIER,
    _LOADED_AT                              AS RAW_LOADED_AT,
    CURRENT_TIMESTAMP()                     AS STAGED_AT
FROM RAW.SUPPLIER;