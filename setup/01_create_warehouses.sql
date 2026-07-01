-- ============================================================
-- WAREHOUSES — Virtual compute resources
-- ============================================================

USE ROLE SYSADMIN;

-- Primary analytics warehouse (pay-as-you-go, auto-suspend)
CREATE WAREHOUSE IF NOT EXISTS ANALYTICS_WH
    WAREHOUSE_SIZE   = 'X-SMALL'
    AUTO_SUSPEND     = 60         -- Suspend after 60s of inactivity
    AUTO_RESUME      = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Main analytics warehouse for reporting and ad-hoc queries';

-- Transformation warehouse (slightly bigger for heavy ELT)
CREATE WAREHOUSE IF NOT EXISTS TRANSFORM_WH
    WAREHOUSE_SIZE   = 'SMALL'
    AUTO_SUSPEND     = 120
    AUTO_RESUME      = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Used for ELT transformations — raw to staging to marts';

-- Show warehouses
SHOW WAREHOUSES;