USE ROLE RETAIL_ENGINEER;
USE DATABASE RETAIL_DW;

-- Create a stream on staging orders to detect new/changed rows
CREATE OR REPLACE STREAM MONITORING.STREAM_ORDERS_CHANGES
    ON TABLE STAGING.STG_ORDERS
    COMMENT = 'CDC stream: captures INSERT/UPDATE/DELETE on STG_ORDERS';

-- Change log table
CREATE OR REPLACE TABLE MONITORING.ORDERS_CHANGE_LOG (
    LOG_ID          NUMBER AUTOINCREMENT PRIMARY KEY,
    DML_TYPE        VARCHAR(10),    -- INSERT / UPDATE / DELETE
    ORDER_ID        NUMBER,
    CUSTOMER_ID     NUMBER,
    ORDER_DATE      DATE,
    ORDER_TOTAL     NUMBER(12,2),
    DETECTED_AT     TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- ============================================================
-- STORED PROCEDURE — Process stream changes
-- ============================================================
CREATE OR REPLACE PROCEDURE MONITORING.SP_SYNC_ORDER_CHANGES()
RETURNS STRING
LANGUAGE JAVASCRIPT
AS $$
    try {
        // Process stream into change log
        snowflake.execute({
            sqlText: `
                INSERT INTO MONITORING.ORDERS_CHANGE_LOG
                    (DML_TYPE, ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_TOTAL)
                SELECT
                    METADATA$ACTION      AS DML_TYPE,
                    ORDER_ID,
                    CUSTOMER_ID,
                    ORDER_DATE,
                    ORDER_TOTAL_AMOUNT
                FROM MONITORING.STREAM_ORDERS_CHANGES
                WHERE METADATA$ISUPDATE = FALSE
            `
        });

        // Count records processed
        var cnt_res = snowflake.execute({
            sqlText: "SELECT COUNT(*) FROM MONITORING.STREAM_ORDERS_CHANGES"
        });
        cnt_res.next();
        var cnt = cnt_res.getColumnValue(1);

        return 'Stream consumed. Records processed: ' + cnt;
    } catch(err) {
        return 'ERROR: ' + err.message;
    }
$$;

-- ============================================================
-- TASK — Run procedure on schedule when stream has data
-- ============================================================
CREATE OR REPLACE TASK MONITORING.TASK_SYNC_ORDERS
    WAREHOUSE = ANALYTICS_WH
    SCHEDULE  = 'USING CRON 0 * * * * UTC'  -- every hour
    WHEN SYSTEM$STREAM_HAS_DATA('MONITORING.STREAM_ORDERS_CHANGES')
AS
    CALL MONITORING.SP_SYNC_ORDER_CHANGES();

-- Activate task (tasks start SUSPENDED by default)
ALTER TASK MONITORING.TASK_SYNC_ORDERS RESUME;

-- Verify task status
SHOW TASKS IN SCHEMA MONITORING;
SELECT * FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY(
    SCHEDULED_TIME_RANGE_START => DATEADD('hour', -1, CURRENT_TIMESTAMP())
)) ORDER BY SCHEDULED_TIME DESC;