USE ROLE RETAIL_ENGINEER;
USE DATABASE RETAIL_DW;

-- ============================================================
-- VIEW 1: Overall Sales Summary by Year/Quarter/Month
-- ============================================================
CREATE OR REPLACE VIEW ANALYTICS.VW_SALES_SUMMARY AS
SELECT
    FO.ORDER_YEAR,
    FO.ORDER_QUARTER,
    FO.ORDER_MONTH,
    COUNT(DISTINCT FO.ORDER_ID)                                     AS TOTAL_ORDERS,
    COUNT(DISTINCT FO.CUSTOMER_ID)                                  AS UNIQUE_CUSTOMERS,
    SUM(FL.NET_PRICE)                                               AS TOTAL_NET_REVENUE,
    SUM(FL.GROSS_PRICE)                                             AS TOTAL_GROSS_REVENUE,
    SUM(FL.DISCOUNT_AMOUNT)                                         AS TOTAL_DISCOUNTS,
    SUM(FL.QUANTITY)                                                AS TOTAL_UNITS_SOLD,
    AVG(FO.ORDER_TOTAL_AMOUNT)                                      AS AVG_ORDER_VALUE,
    SUM(FL.NET_PRICE) / NULLIF(COUNT(DISTINCT FO.ORDER_ID), 0)     AS REVENUE_PER_ORDER,
    COUNT(CASE WHEN FL.IS_RETURNED THEN 1 END)                      AS TOTAL_RETURNS,
    ROUND(
        COUNT(CASE WHEN FL.IS_RETURNED THEN 1 END) /
        NULLIF(COUNT(FL.LINE_NUMBER), 0) * 100, 2
    )                                                               AS RETURN_RATE_PCT,
    COUNT(CASE WHEN FL.IS_ON_TIME THEN 1 END)                       AS ON_TIME_DELIVERIES,
    ROUND(
        COUNT(CASE WHEN FL.IS_ON_TIME THEN 1 END) /
        NULLIF(COUNT(FL.LINE_NUMBER), 0) * 100, 2
    )                                                               AS ON_TIME_RATE_PCT
FROM MARTS.FACT_ORDERS FO
JOIN MARTS.FACT_LINEITEM FL ON FO.ORDER_ID = FL.ORDER_ID
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;


-- ============================================================
-- VIEW 2: Revenue with Month-over-Month and Year-over-Year Growth
-- ============================================================
CREATE OR REPLACE VIEW ANALYTICS.VW_REVENUE_GROWTH AS
WITH monthly_revenue AS (
    SELECT
        ORDER_YEAR,
        ORDER_MONTH,
        SUM(ORDER_TOTAL_AMOUNT) AS MONTHLY_REVENUE,
        COUNT(DISTINCT ORDER_ID) AS MONTHLY_ORDERS
    FROM MARTS.FACT_ORDERS
    GROUP BY 1, 2
),
with_lag AS (
    SELECT
        *,
        LAG(MONTHLY_REVENUE, 1)  OVER (ORDER BY ORDER_YEAR, ORDER_MONTH) AS PREV_MONTH_REV,
        LAG(MONTHLY_REVENUE, 12) OVER (ORDER BY ORDER_YEAR, ORDER_MONTH) AS PREV_YEAR_SAME_MONTH_REV
    FROM monthly_revenue
)
SELECT
    ORDER_YEAR,
    ORDER_MONTH,
    MONTHLY_REVENUE,
    MONTHLY_ORDERS,
    PREV_MONTH_REV,
    PREV_YEAR_SAME_MONTH_REV,
    -- MoM Growth
    ROUND(
        (MONTHLY_REVENUE - PREV_MONTH_REV) / NULLIF(PREV_MONTH_REV, 0) * 100, 2
    )                                                               AS MOM_GROWTH_PCT,
    -- YoY Growth
    ROUND(
        (MONTHLY_REVENUE - PREV_YEAR_SAME_MONTH_REV) /
        NULLIF(PREV_YEAR_SAME_MONTH_REV, 0) * 100, 2
    )                                                               AS YOY_GROWTH_PCT,
    -- YTD Revenue (resets each year)
    SUM(MONTHLY_REVENUE) OVER (
        PARTITION BY ORDER_YEAR ORDER BY ORDER_MONTH
    )                                                               AS YTD_REVENUE
FROM with_lag
ORDER BY ORDER_YEAR, ORDER_MONTH;