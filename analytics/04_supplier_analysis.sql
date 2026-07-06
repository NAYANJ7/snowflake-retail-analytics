CREATE OR REPLACE VIEW ANALYTICS.VW_SUPPLIER_SCORECARD AS
WITH supplier_metrics AS (
    SELECT
        FL.SUPPLIER_ID,
        DS.SUPPLIER_NAME,
        DS.NATION_NAME,
        DS.REGION_NAME,
        DS.SUPPLIER_TIER,
        COUNT(DISTINCT FL.ORDER_ID)                     AS TOTAL_ORDERS,
        COUNT(DISTINCT FL.PART_ID)                      AS DISTINCT_PARTS,
        SUM(FL.QUANTITY)                                AS TOTAL_UNITS,
        SUM(FL.NET_PRICE)                               AS TOTAL_REVENUE,
        ROUND(AVG(FL.DELIVERY_DAYS), 2)                 AS AVG_DELIVERY_DAYS,
        COUNT(CASE WHEN FL.IS_RETURNED THEN 1 END)      AS TOTAL_RETURNS,
        COUNT(CASE WHEN FL.IS_ON_TIME THEN 1 END)       AS ON_TIME_DELIVERIES,
        COUNT(FL.LINE_NUMBER)                           AS TOTAL_LINE_ITEMS
    FROM MARTS.FACT_LINEITEM FL
    JOIN MARTS.DIM_SUPPLIERS DS ON FL.SUPPLIER_ID = DS.SUPPLIER_ID
    GROUP BY 1, 2, 3, 4, 5
)
SELECT
    *,
    ROUND(TOTAL_RETURNS / NULLIF(TOTAL_LINE_ITEMS, 0) * 100, 2)      AS RETURN_RATE_PCT,
    ROUND(ON_TIME_DELIVERIES / NULLIF(TOTAL_LINE_ITEMS, 0) * 100, 2) AS ON_TIME_RATE_PCT,
    TOTAL_REVENUE / NULLIF(TOTAL_ORDERS, 0)                          AS REVENUE_PER_ORDER,
    -- Composite supplier score (100-point scale)
    ROUND(
        (ON_TIME_DELIVERIES / NULLIF(TOTAL_LINE_ITEMS, 0)) * 40 +   -- 40 pts: On-time
        (1 - TOTAL_RETURNS / NULLIF(TOTAL_LINE_ITEMS, 0)) * 40 +    -- 40 pts: Quality
        GREATEST(0, (30 - AVG_DELIVERY_DAYS) / 30) * 20             -- 20 pts: Speed
    , 1)                                                              AS SUPPLIER_SCORE,
    RANK() OVER (ORDER BY TOTAL_REVENUE DESC)                        AS REVENUE_RANK,
    RANK() OVER (ORDER BY ON_TIME_RATE_PCT DESC)                     AS ON_TIME_RANK
FROM supplier_metrics;