-- ============================================================
-- DATABASES & SCHEMAS — Medallion Architecture
-- ============================================================

USE ROLE SYSADMIN;

CREATE DATABASE IF NOT EXISTS RETAIL_DW
    DATA_RETENTION_TIME_IN_DAYS = 7
    COMMENT = 'RetailDW — Retail Analytics Data Warehouse';

USE DATABASE RETAIL_DW;

-- BRONZE — exact copy of source, metadata-enriched only
CREATE SCHEMA IF NOT EXISTS RAW
    DATA_RETENTION_TIME_IN_DAYS = 3
    COMMENT = 'Bronze layer: raw ingested data, no business transformations';

-- SILVER — cleansed, typed, deduplicated, enriched
CREATE SCHEMA IF NOT EXISTS STAGING
    DATA_RETENTION_TIME_IN_DAYS = 5
    COMMENT = 'Silver layer: cleansed and standardized data';

-- GOLD — business-modeled star schema
CREATE SCHEMA IF NOT EXISTS MARTS
    DATA_RETENTION_TIME_IN_DAYS = 7
    COMMENT = 'Gold layer: fact and dimension tables for analytics';

-- PLATINUM — analyst-facing views and metrics
CREATE SCHEMA IF NOT EXISTS ANALYTICS
    DATA_RETENTION_TIME_IN_DAYS = 7
    COMMENT = 'Analytics views, KPI views, materialized aggregates';

-- OPS — pipeline monitoring and DQ
CREATE SCHEMA IF NOT EXISTS MONITORING
    DATA_RETENTION_TIME_IN_DAYS = 30
    COMMENT = 'Data quality results, pipeline logs, stream monitoring';

SHOW SCHEMAS IN DATABASE RETAIL_DW;