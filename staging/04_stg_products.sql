CREATE OR REPLACE TABLE STAGING.STG_PRODUCTS AS
SELECT
    P_PARTKEY                               AS PART_ID,
    TRIM(P_NAME)                            AS PART_NAME,
    TRIM(P_MFGR)                            AS MANUFACTURER,
    TRIM(P_BRAND)                           AS BRAND,
    TRIM(P_TYPE)                            AS PART_TYPE,
    -- Parse category from type string (e.g. "ECONOMY ANODIZED STEEL" → "ECONOMY")
    SPLIT_PART(TRIM(P_TYPE), ' ', 1)        AS PART_CATEGORY,
    SPLIT_PART(TRIM(P_TYPE), ' ', 2)        AS PART_MATERIAL_PROCESS,
    SPLIT_PART(TRIM(P_TYPE), ' ', 3)        AS PART_MATERIAL,
    P_SIZE                                  AS SIZE_VALUE,
    -- Size bucketing
    CASE
        WHEN P_SIZE <= 5  THEN 'SMALL'
        WHEN P_SIZE <= 15 THEN 'MEDIUM'
        WHEN P_SIZE <= 30 THEN 'LARGE'
        ELSE 'JUMBO'
    END                                     AS SIZE_CATEGORY,
    TRIM(P_CONTAINER)                       AS CONTAINER_TYPE,
    ROUND(P_RETAILPRICE, 2)                 AS RETAIL_PRICE,
    -- Price tier
    CASE
        WHEN P_RETAILPRICE >= 1800 THEN 'PREMIUM'
        WHEN P_RETAILPRICE >= 1200 THEN 'MID_RANGE'
        WHEN P_RETAILPRICE >= 600  THEN 'STANDARD'
        ELSE 'BUDGET'
    END                                     AS PRICE_TIER,
    _LOADED_AT                              AS RAW_LOADED_AT,
    CURRENT_TIMESTAMP()                     AS STAGED_AT
FROM RAW.PART;