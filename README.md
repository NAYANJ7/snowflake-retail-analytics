```markdown
<div align="center">

# 🏔️ RetailDW
### End-to-End Retail Analytics Data Warehouse on Snowflake

[![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)](https://www.snowflake.com/)
[![SQL](https://img.shields.io/badge/SQL-blue?style=flat&logo=database)](#)
[![Architecture](https://img.shields.io/badge/Architecture-Medallion-orange)](#)
[![Edition](https://img.shields.io/badge/Edition-Standard-lightgrey)](#)
[![Status](https://img.shields.io/badge/Status-Complete-brightgreen)](#)

> A production-style Retail Analytics Data Warehouse built entirely on Snowflake, implementing a full Medallion Architecture (Bronze → Silver → Gold → Analytics) to turn 8.6M+ raw transactional rows into customer, product, and supply-chain insights.

</div>

---

## 📋 Table of Contents

1. [Hero Section](#hero-section)
2. [Badges](#badges)
3. [Banner](#banner)
4. [Table of Contents](#table-of-contents)
5. [Overview](#overview)
6. [Why this project](#why-this-project)
7. [Dataset](#dataset)
8. [Business Problem](#business-problem)
9. [Architecture](#architecture)
10. [Medallion Architecture explanation](#medallion-architecture-explanation)
11. [Star Schema explanation](#star-schema-explanation)
12. [Project Features](#project-features)
13. [Folder Structure](#folder-structure)
14. [Execution Flow](#execution-flow)
15. [Analytics Layer](#analytics-layer)
16. [Sales KPI explanation](#sales-kpi-explanation)
17. [Revenue Growth explanation](#revenue-growth-explanation)
18. [Customer Lifetime Value explanation](#customer-lifetime-value-explanation)
19. [RFM explanation](#rfm-explanation)
20. [Pareto Analysis explanation](#pareto-analysis-explanation)
21. [Supplier Scorecard explanation](#supplier-scorecard-explanation)
22. [Data Quality Monitoring explanation](#data-quality-monitoring-explanation)
23. [Streams & Tasks explanation](#streams--tasks-explanation)
24. [Time Travel explanation](#time-travel-explanation)
25. [Zero Copy Cloning explanation](#zero-copy-cloning-explanation)
26. [Secure Views explanation](#secure-views-explanation)
27. [RBAC explanation](#rbac-explanation)
28. [Engineering Notes](#engineering-notes)
29. [Challenges Faced](#challenges-faced)
30. [Standard Edition Adaptations](#standard-edition-adaptations)
31. [Screenshots](#screenshots)
32. [Tech Stack](#tech-stack)
33. [SQL Concepts Used](#sql-concepts-used)
34. [Window Functions Used](#window-functions-used)
35. [Learning Outcomes](#learning-outcomes)
36. [Future Improvements](#future-improvements)
37. [Quick Start](#quick-start)
38. [Execution Order](#execution-order)
39. [Sample SQL Queries](#sample-sql-queries)
40. [Conclusion](#conclusion)
41. [Author](#author)

---

## 5. Overview

**RetailDW** is a production-style Retail Analytics Data Warehouse built entirely on Snowflake, implementing a full **Medallion Architecture** (Bronze → Silver → Gold → Analytics) to turn 8.6M+ raw transactional rows into customer, product, and supply-chain insights. 

Everything here — ingestion, modeling, security, automation, and analytics — runs on a single free-tier Snowflake trial account, executed end-to-end from the CLI. This project replicates the rigorous data engineering pipelines required by global distributors and manufacturers to track SKUs, sales pipelines, and inventory routing.

## 6. Why this project

Modern data engineering requires more than just moving data; it requires transforming it into actionable business value while ensuring data quality and security. This project was built to demonstrate a complete lifecycle approach:
* Processing high-volume transactional data reliably.
* Structuring complex analytical queries to drive business strategy.
* Applying engineering best practices (RBAC, zero-copy cloning, scheduled tasks).
* Showcasing the capability to build a robust, scalable pipeline suited for high-stakes retail and electrical distribution environments.

## 7. Dataset

This project utilizes the **TPC-H Benchmark Data**, which is built into every Snowflake account at `SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`. No download or external source configuration is required, making this project entirely reproducible by anyone with a free Snowflake trial.

| Table | Rows | Description |
|-------|-----:|-------------|
| ORDERS | 1,500,000 | Customer purchase orders |
| LINEITEM | 6,001,215 | Individual order line items |
| CUSTOMER | 150,000 | Customer master data |
| SUPPLIER | 10,000 | Supplier master data |
| PART | 200,000 | Product/parts catalog |
| PARTSUPP | 800,000 | Part–supplier relationships |
| NATION / REGION | 30 | Geography reference |

## 8. Business Problem

A global retail and supply chain company generates millions of daily transactional records. While the raw data captures every order and line item, it lacks the structure needed for executive-level analytics. The business needs a unified data warehouse to answer critical questions:
* Which customers are highly engaged, and which are at risk of churning?
* How are product categories performing, and which SKUs drive 80% of our revenue?
* Are our suppliers meeting their delivery commitments and quality standards?

## 9. Architecture

The pipeline moves data through four distinct layers, minimizing coupling and maximizing data quality:

```text
SNOWFLAKE_SAMPLE_DATA (source)
        │
        ▼
┌──────────────────────────────────────────────────────┐
│                  RETAIL_DW database                  │
│                                                        │
│  ┌────────┐   ┌──────────┐   ┌────────┐  ┌─────────┐ │
│  │  RAW   │ → │ STAGING  │ → │ MARTS  │→ │ANALYTICS│ │
│  │(Bronze)│   │ (Silver) │   │ (Gold) │  │         │ │
│  └────────┘   └──────────┘   └────────┘  └─────────┘ │
│                                                        │
│  ┌──────────────┐      ┌──────────────────┐           │
│  │  MONITORING  │      │  Advanced Layer  │           │
│  │ (DQ + Logs)  │      │ Streams / Tasks  │           │
│  └──────────────┘      └──────────────────┘           │
└──────────────────────────────────────────────────────┘

```

## 10. Medallion Architecture explanation

* **RAW (Bronze):** An exact copy of the source data, enriched only with basic load metadata (e.g., loaded timestamps, source system tags).
* **STAGING (Silver):** Cleansed, deduplicated, and type-casted data. Business rules are applied here, transforming obscure codes into readable statuses and standardizing timestamps.
* **MARTS (Gold):** Business-modeled data following a Star Schema approach, optimized specifically for fast analytical reads and aggregations.
* **ANALYTICS:** Platinum-level views and logic that pre-calculate KPIs, RFM scores, and Pareto categorizations.

## 11. Star Schema explanation

The MARTS layer adopts a standard Kimball Star Schema for optimized BI engine querying:

* **Grain:** The primary grain is defined at the `FACT_LINEITEM` level (one row per order line item).
* **Dimensions:** Core business entities are broken out into `DIM_CUSTOMERS`, `DIM_PRODUCTS`, and `DIM_SUPPLIERS`.
* **Conformed Dimensions:** A central `DIM_DATE` table joins to order dates, ship dates, commit dates, and receipt dates, allowing for unified time-series reporting across all facts.

## 12. Project Features

| Feature | Implementation |
| --- | --- |
| Medallion Architecture | RAW → STAGING → MARTS → ANALYTICS |
| Star Schema Modeling | 2 fact tables, 4 dimension tables |
| Window Functions | YoY/MoM revenue growth, RFM scoring, Pareto analysis, CLV |
| Streams & Tasks | CDC pipeline with hourly incremental sync |
| Time Travel | Historical point-in-time queries and recovery pattern |
| Zero-Copy Cloning | Instant DEV/TEST database and table clones |
| Scheduled Aggregate Refresh | Task-driven refresh tables (materialized-view equivalent) |
| Role-Based Data Masking | Secure views enforcing masking via `CURRENT_ROLE()` |
| Region-Based Row Filtering | Secure view row filtering (row-access-policy equivalent) |
| RBAC | 4-tier role hierarchy (Admin → Engineer → Analyst → Viewer) |
| Data Quality | 7-check automated DQ suite with result logging |
| Stored Procedures | JavaScript-based pipeline automation |

## 13. Folder Structure

```text
snowflake-retail-analytics/
├── setup/          → Warehouses, databases, RBAC roles
├── raw/            → Bronze layer: source ingestion
├── staging/        → Silver layer: cleansing + enrichment
├── marts/          → Gold layer: star schema
│   ├── dimensions/ → DIM_DATE, DIM_CUSTOMERS, DIM_PRODUCTS, DIM_SUPPLIERS
│   └── facts/      → FACT_ORDERS, FACT_LINEITEM
├── analytics/      → Business views: KPIs, RFM, CLV, Pareto, supplier scorecard
├── advanced/       → Streams, Tasks, Time Travel, Cloning, secure views
├── monitoring/     → Automated data quality checks
└── docs/
    ├── architecture-diagram.jpg
    └── screenshots/
        ├── sales-kpis.png
        ├── rfm-segmentation.png
        ├── product-performance.png
        ├── supplier-scorecard.png
        └── secure-view-masking.png

```

## 14. Execution Flow

The project is orchestrated sequentially via SnowSQL.

1. **Setup Scripts:** Provisions standard and transform warehouses, databases, and a 4-tier RBAC framework.
2. **Raw Ingestion:** Extracts the 8.6M rows from TPC-H into the Bronze schema.
3. **Staging Scripts:** Applies transformations, cleans string values, and casts dates.
4. **Marts Deployment:** Generates surrogate keys, builds the dimension tables first, and then loads fact tables to ensure referential integrity.
5. **Analytics Layer:** Creates dynamic views for reporting.
6. **Advanced / Monitoring:** Activates Streams for CDC, schedules background Tasks, and executes the DQ validation suite.

## 15. Analytics Layer

The final layer serves as the semantic model for BI tools, delivering ready-to-query insights. It houses 7 core analytical views designed to answer specific business domains:

1. `VW_SALES_SUMMARY`
2. `VW_REVENUE_GROWTH`
3. `VW_CUSTOMER_LTV`
4. `VW_RFM_SEGMENTATION`
5. `VW_PRODUCT_PERFORMANCE`
6. `VW_SHIP_MODE_ANALYSIS`
7. `VW_SUPPLIER_SCORECARD`

## 16. Sales KPI explanation

The sales summary tracks fundamental metrics aggregated by year, quarter, and month. It computes the total number of unique orders, net and gross revenue, discount impacts, and overall unit volumes. It also measures fulfillment efficiency by calculating on-time delivery rates and analyzing return volume percentages to provide a holistic view of operational health.

## 17. Revenue Growth explanation

Tracking business momentum requires contextualizing current sales against historical performance. This view utilizes Snowflake's powerful `LAG()` window function to shift historical revenue figures into the current row. It calculates Month-over-Month (MoM) and Year-over-Year (YoY) growth percentages precisely, allowing executives to identify cyclical trends and seasonality.

## 18. Customer Lifetime Value explanation

The Customer LTV analysis evaluates the long-term profitability of each account. It extracts the first and last order dates to determine tenure in months, then calculates the monthly revenue rate and order frequency. It utilizes `NTILE(10)` and `PERCENT_RANK()` to assign revenue deciles and percentiles, categorizing the customer base by their overall revenue share.

## 19. RFM explanation

RFM (Recency, Frequency, Monetary) segmentation is used for targeted retention strategies. Customers are scored on a scale of 1 to 5 for each metric using `NTILE(5)`. The combined scores map accounts into actionable segments: Champions, Loyal, At-Risk, and Lost. This ensures marketing and sales efforts are directed efficiently based on data rather than intuition.

## 20. Pareto Analysis explanation

Product catalog performance is mapped using the 80/20 Pareto principle. By calculating a running cumulative percentage of total net revenue via window functions, products are automatically categorized into A, B, or C tiers. This identifies the high-value SKUs that disproportionately drive revenue and should be prioritized in inventory routing.

## 21. Supplier Scorecard explanation

To optimize supply chain operations, suppliers are evaluated on a composite 100-point scale. The formula blends their on-time delivery rate (40 points), product quality/return rate (40 points), and average delivery speed (20 points). This quantitative scorecard takes the guesswork out of vendor probation and preferred supplier routing.

## 22. Data Quality Monitoring explanation

A robust pipeline demands automated validation. The monitoring layer utilizes stored procedures to run a 7-check data quality suite. Checks include validating non-null primary keys, identifying orphaned line items, ensuring no negative revenue values, checking referential integrity between orders and customers, and verifying logic bounds (e.g., discounts between 0 and 1). Results are tracked over time in a persistent log table.

## 23. Streams & Tasks explanation

To mimic real-world production environments where data arrives continuously, this project utilizes Snowflake Streams for Change Data Capture (CDC). A stream observes the Staging layer for `INSERT`/`UPDATE`/`DELETE` operations. A scheduled Snowflake Task runs on an hourly CRON schedule, automatically triggering a JavaScript stored procedure to process the delta records into a log table.

## 24. Time Travel explanation

Snowflake's native Time Travel feature is leveraged for historical point-in-time querying and disaster recovery. The engineering layer includes scripts demonstrating how to query the database as it existed `AT(OFFSET => -3600)` (1 hour ago) and includes a recovery pattern to instantly restore rows that were accidentally deleted using query IDs.

## 25. Zero Copy Cloning explanation

To support safe development, Zero-Copy Cloning is utilized. This Snowflake architecture allows the instantaneous creation of `_DEV` and `_TEST` databases without duplicating underlying storage. Engineers can safely test destructive DML operations or schema changes on production-volume data without paying for additional storage costs or waiting for data replication.

## 26. Secure Views explanation

PII protection is enforced natively at the database level. By leveraging `SECURE VIEW` alongside `CASE WHEN CURRENT_ROLE()` logic, the architecture masks sensitive fields (like customer phone numbers and names) on the fly. The `RETAIL_ADMIN` role views the raw data, while the `RETAIL_VIEWER` role sees heavily redacted strings, ensuring compliance without duplicating tables.

## 27. RBAC explanation

Security is structured using a best-practice 4-tier Role-Based Access Control hierarchy:

* `RETAIL_ADMIN`: Full ownership and configuration rights.
* `RETAIL_ENGINEER`: Full privileges to build pipelines and execute ELT on the transformative warehouses.
* `RETAIL_ANALYST`: Select access to the MARTS and ANALYTICS schemas.
* `RETAIL_VIEWER`: Strict read-only access limited to curated analytical views.

## 28. Engineering Notes

This repository focuses on producing modular, readable, and highly maintainable SQL. Rather than relying heavily on complex external orchestrators, the core transformation logic pushes the compute down into Snowflake's elastic warehouses using standard SQL and native JavaScript stored procedures. This keeps infrastructure lean, processing fast, and minimizes security perimeters.

## 29. Challenges Faced

The most significant challenge was engineering an enterprise-grade pipeline on a standard free-tier account. Many common architectural patterns assume the presence of high-end features. Bridging this gap required diving deep into Snowflake's foundational features and writing custom procedural code to mimic enterprise automation dynamically.

## 30. Standard Edition Adaptations

This project runs on Snowflake **Standard Edition** (free trial) — which doesn't include Enterprise+ features like native **Materialized Views** and **Dynamic Data Masking / Row Access Policies**. Rather than skip these, they were rebuilt using available patterns:

| Enterprise+ Feature | Standard Edition Equivalent Built Here |
| --- | --- |
| `CREATE MATERIALIZED VIEW` | A regular table + a `TASK` on a CRON schedule calling a stored procedure to rebuild it |
| `CREATE MASKING POLICY` | A `SECURE VIEW` with a `CASE WHEN CURRENT_ROLE() ...` expression per column |
| `CREATE ROW ACCESS POLICY` | A `SECURE VIEW` with a `CASE WHEN CURRENT_ROLE() ...` expression in the `WHERE` clause |

## 31. Screenshots section with markdown image placeholders

### Sales KPIs

### RFM Segmentation

### Product Performance

### Supplier Scorecard

### Secure View Masking

## 32. Tech Stack

* **Snowflake** — Cloud Data Warehouse (Standard Edition)
* **SnowSQL** — CLI for script execution and automation
* **VS Code** — primary editor, PowerShell integrated terminal
* **SQL** — standard SQL + Snowflake Scripting (JavaScript stored procedures)
* **Git / GitHub** — version control, phase-by-phase commit history

## 33. SQL Concepts Used

The transformation layer relies heavily on advanced SQL paradigms. Common Table Expressions (CTEs) were extensively used to modularize the logic for complex aggregations. Extensive use of `CASE` statements handles data cleansing and conditional bucketing (e.g., size categories, pricing tiers). Implicit and explicit `JOIN` logic maps referential integrity across the Star Schema.

## 34. Window Functions Used

Window functions drove the most critical analytical insights:

* `LAG()`: To pull prior month/year values for MoM and YoY calculations.
* `NTILE()`: To uniformly distribute customers into quantiles for RFM scoring.
* `PERCENT_RANK()`: To define the relative standing of customer revenue lifetime value.
* `SUM() OVER()`: Used with an `ORDER BY` clause to calculate running totals for cumulative Pareto percentages.

## 35. Learning Outcomes

* Designing a multi-layer data warehouse from raw ingestion through to business-ready analytics views.
* Writing analytical SQL beyond basic queries: window functions, CTEs, RFM scoring, Pareto/ABC classification.
* Diagnosing real platform constraints and rebuilding Enterprise-only features using Standard-Edition-compatible patterns.
* Setting up RBAC from scratch: warehouses, databases, schemas, and a 4-tier role hierarchy with future grants.
* Automating data quality validation with stored procedures and a persistent results log.

## 36. Future Improvements

Future iterations of this repository will focus on continuous integration. Implementing `dbt` (Data Build Tool) will modularize the staging and marts layers, adding native testing and documentation capabilities. Additionally, connecting this warehouse to a live BI dashboard (like Streamlit, Tableau, or PowerBI) will provide a graphical front-end to the rich analytical views.

## 37. Quick Start

1. Sign up for a [free Snowflake trial](https://signup.snowflake.com/) (Standard Edition is enough — this whole project runs on it).
2. Clone this repo locally to your machine.
3. Ensure SnowSQL is installed and configured with your account credentials.
4. Execute the SQL scripts in sequential order to build the infrastructure, ingest the data, and generate the analytics.
5. Explore the analytics views in Snowsight or connect your preferred BI tool.

## 38. Execution Order

Run the scripts exactly in this order:
`setup/` → `raw/` → `staging/` → `marts/` (dimensions before facts) → `analytics/` → `advanced/` → `monitoring/`.

## 39. Sample SQL Queries

Here is a quick look at the logic driving the Customer LTV View:

```sql
WITH customer_base AS (
    SELECT
        FO.CUSTOMER_ID,
        DC.CUSTOMER_NAME,
        MIN(FO.ORDER_DATE)                              AS FIRST_ORDER_DATE,
        MAX(FO.ORDER_DATE)                              AS LAST_ORDER_DATE,
        DATEDIFF('month', MIN(FO.ORDER_DATE), MAX(FO.ORDER_DATE)) AS TENURE_MONTHS,
        COUNT(DISTINCT FO.ORDER_ID)                     AS TOTAL_ORDERS,
        SUM(FL.NET_PRICE)                               AS TOTAL_REVENUE
    FROM MARTS.FACT_ORDERS FO
    JOIN MARTS.FACT_LINEITEM FL ON FO.ORDER_ID = FL.ORDER_ID
    JOIN MARTS.DIM_CUSTOMERS DC ON FO.CUSTOMER_ID = DC.CUSTOMER_ID
    GROUP BY 1, 2
)
SELECT
    *,
    TOTAL_REVENUE / NULLIF(TENURE_MONTHS, 0)            AS MONTHLY_REV_RATE,
    NTILE(10) OVER (ORDER BY TOTAL_REVENUE DESC)         AS REVENUE_DECILE
FROM customer_base;

```

## 40. Conclusion

RetailDW provides a comprehensive blueprint for structuring complex data at scale. By strictly adhering to the Medallion Architecture and fully leveraging Snowflake's distinct cloud-native features, it demonstrates how raw, noisy data is efficiently transformed into trusted, secure, and highly performant analytics ready to power business intelligence.

## 41. Author

Nayan Jain

Data Engineer | Machine Learning | Real-Time Pipelines

[LinkedIn](https://linkedin.com) | [GitHub](https://github.com)

```

```
