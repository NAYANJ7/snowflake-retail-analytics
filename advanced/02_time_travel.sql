USE ROLE RETAIL_ANALYST;
USE WAREHOUSE ANALYTICS_WH;
USE DATABASE RETAIL_DW;

-- 1. Query data as it looked 1 hour ago
SELECT COUNT(*), SUM(ORDER_TOTAL_AMOUNT) AS TOTAL_REV
FROM MARTS.FACT_ORDERS
AT(OFFSET => -3600);   -- -3600 seconds = 1 hour ago

-- 2. Compare current vs yesterday's state
SELECT
    'NOW'       AS snapshot,
    COUNT(*)    AS total_orders,
    SUM(ORDER_TOTAL_AMOUNT) AS total_revenue
FROM MARTS.FACT_ORDERS
UNION ALL
SELECT
    '24H_AGO',
    COUNT(*),
    SUM(ORDER_TOTAL_AMOUNT)
FROM MARTS.FACT_ORDERS
AT(OFFSET => -86400);  -- 86400 seconds = 24 hours

-- 3. Simulate: accidentally delete some orders
-- DELETE FROM MARTS.FACT_ORDERS WHERE ORDER_YEAR = 1994;
-- (run above only as a test in dev/clone environment!)

-- 4. Recover deleted rows via Time Travel
-- First get the query ID of the DELETE statement from:
-- SELECT QUERY_ID, QUERY_TEXT, START_TIME
-- FROM TABLE(INFORMATION_SCHEMA.QUERY_HISTORY())
-- WHERE QUERY_TEXT LIKE '%DELETE FROM MARTS.FACT_ORDERS%'
-- ORDER BY START_TIME DESC LIMIT 1;

-- Then restore:
-- INSERT INTO MARTS.FACT_ORDERS
-- SELECT * FROM MARTS.FACT_ORDERS
--   BEFORE(STATEMENT => '<paste-query-id-here>');

-- 5. Create recovery table from historical snapshot
CREATE OR REPLACE TABLE MARTS.FACT_ORDERS_BACKUP_1H AS
SELECT * FROM MARTS.FACT_ORDERS AT(OFFSET => -3600);

SELECT 'Original', COUNT(*) FROM MARTS.FACT_ORDERS
UNION ALL
SELECT 'Backup',   COUNT(*) FROM MARTS.FACT_ORDERS_BACKUP_1H;