CREATE OR REPLACE TABLE STAGING.STG_LINEITEM AS
SELECT
    L_ORDERKEY                                              AS ORDER_ID,
    L_PARTKEY                                               AS PART_ID,
    L_SUPPKEY                                               AS SUPPLIER_ID,
    L_LINENUMBER                                            AS LINE_NUMBER,
    ROUND(L_QUANTITY, 0)::INT                               AS QUANTITY,
    ROUND(L_EXTENDEDPRICE, 2)                               AS EXTENDED_PRICE,
    ROUND(L_DISCOUNT, 4)                                    AS DISCOUNT_RATE,
    ROUND(L_TAX, 4)                                         AS TAX_RATE,
    -- Calculated financial metrics
    ROUND(L_EXTENDEDPRICE * (1 - L_DISCOUNT), 2)            AS NET_PRICE,
    ROUND(L_EXTENDEDPRICE * (1 - L_DISCOUNT) * (1 + L_TAX), 2) AS GROSS_PRICE,
    ROUND(L_EXTENDEDPRICE * L_DISCOUNT, 2)                  AS DISCOUNT_AMOUNT,
    UPPER(L_RETURNFLAG)                                     AS RETURN_FLAG,
    UPPER(L_LINESTATUS)                                     AS LINE_STATUS,
    L_SHIPDATE::DATE                                        AS SHIP_DATE,
    L_COMMITDATE::DATE                                      AS COMMIT_DATE,
    L_RECEIPTDATE::DATE                                     AS RECEIPT_DATE,
    -- Delivery performance metrics
    DATEDIFF('day', L_SHIPDATE,   L_RECEIPTDATE)            AS DELIVERY_DAYS,
    DATEDIFF('day', L_COMMITDATE, L_RECEIPTDATE)            AS DAYS_LATE_TO_COMMIT,
    -- Boolean flags
    CASE WHEN L_RETURNFLAG = 'R' THEN TRUE ELSE FALSE END  AS IS_RETURNED,
    CASE WHEN DATEDIFF('day', L_COMMITDATE, L_RECEIPTDATE) <= 0 THEN TRUE ELSE FALSE END AS IS_ON_TIME,
    UPPER(TRIM(L_SHIPINSTRUCT))                             AS SHIP_INSTRUCTIONS,
    UPPER(TRIM(L_SHIPMODE))                                 AS SHIP_MODE,
    _LOADED_AT                                              AS RAW_LOADED_AT,
    CURRENT_TIMESTAMP()                                     AS STAGED_AT
FROM RAW.LINEITEM
WHERE L_ORDERKEY IS NOT NULL
  AND L_PARTKEY  IS NOT NULL
  AND L_SUPPKEY  IS NOT NULL;