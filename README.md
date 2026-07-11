<<<<<<< HEAD
<div align="center">

# 🏔️ RetailDW
### End-to-End Retail Analytics Data Warehouse on Snowflake

*Medallion Architecture · Star Schema · TPC-H Benchmark Dataset (8.6M+ rows)*
=======
# snowflake-retail-analytics
End-to-End Data Warehouse on Snowflake | Medallion Architecture | TPC-H Dataset
>>>>>>> d4c90e99c9fa8249c768c6a7296d898a47b0d8e1

[![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)](https://www.snowflake.com/)
[![SQL](https://img.shields.io/badge/SQL-blue?style=flat&logo=database)](.)
[![Architecture](https://img.shields.io/badge/Architecture-Medallion-orange)](.)
<<<<<<< HEAD
[![Edition](https://img.shields.io/badge/Edition-Standard-lightgrey)](.)
[![Status](https://img.shields.io/badge/Status-Complete-brightgreen)](.)

</div>

---

## 📋 Table of Contents
- [🔎 Overview](#-overview)
- [📊 Dataset](#-dataset)
- [🏗️ Architecture](#-architecture)
- [⚙️ Key Features](#-key-features)
- [🧠 Engineering Notes: Standard Edition Adaptations](#-engineering-notes-standard-edition-adaptations)
- [📈 Analytics in Action](#-analytics-in-action)
- [🛠️ Tech Stack](#-tech-stack)
- [📁 Repository Structure](#-repository-structure)
- [⚡ Quick Start](#-quick-start)
- [🌟 What I Learned](#-what-i-learned)

---

## 🔎 Overview

**RetailDW** is a production-style Retail Analytics Data Warehouse built entirely on Snowflake, implementing a full **Medallion Architecture** (Bronze → Silver → Gold → Analytics) to turn 8.6M+ raw transactional rows into customer, product, and supply-chain insights.

Everything here — ingestion, modeling, security, automation, and analytics — runs on a single free-tier Snowflake trial account, executed end-to-end from the CLI.

---

## 📊 Dataset

**TPC-H Benchmark Data** — built into every Snowflake account at `SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`. No download, no external source, no setup friction. Anyone with a free Snowflake trial can reproduce this project exactly.

| Table | Rows | Description |
|-------|-----:|-------------|
| ORDERS | 1,500,000 | Customer purchase orders |
| LINEITEM | 6,001,215 | Individual order line items |
| CUSTOMER | 150,000 | Customer master data |
| SUPPLIER | 10,000 | Supplier master data |
| PART | 200,000 | Product/parts catalog |
| PARTSUPP | 800,000 | Part–supplier relationships |
| NATION / REGION | 30 | Geography reference |

**Business story:** a global retail & supply chain company, modeled from raw source data through to executive-level analytics.
=======
[![Status](https://img.shields.io/badge/Status-Complete-green)](.)

A **production-grade Retail Analytics Data Warehouse** built on Snowflake,
implementing a full Medallion Architecture (Bronze → Silver → Gold) to deliver
customer, product, and supply chain insights from 7.5M+ records.

---

## 📊 Dataset: TPC-H Benchmark
| Table | Rows | Description |
|-------|------|-------------|
| ORDERS | 1,500,000 | Customer purchase orders |
| LINEITEM | 6,001,215 | Order line items |
| CUSTOMER | 150,000 | Customer master |
| SUPPLIER | 10,000 | Supplier master |
| PART | 200,000 | Product catalog |
| NATION/REGION | 30 | Geography reference |

> Reproducible by anyone with a free Snowflake trial account — no data download required.
>>>>>>> d4c90e99c9fa8249c768c6a7296d898a47b0d8e1

---

## 🏗️ Architecture
<<<<<<< HEAD

<div align="center">
  <img src="docs/architecture-diagram.jpg" alt="RetailDW architecture diagram — Medallion layers from raw TPC-H source through to analytics views" width="800">
</div>

<br>

The pipeline moves data through four layers, each with a distinct job:

```
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
│  │  MONITORING  │      │  Advanced Layer   │           │
│  │ (DQ + Logs)  │      │ Streams / Tasks   │           │
│  └──────────────┘      └──────────────────┘           │
└──────────────────────────────────────────────────────┘
```

**Star schema (MARTS layer):**

```
                    DIM_DATE
                       │
DIM_CUSTOMERS ─── FACT_ORDERS
                       │
                  FACT_LINEITEM ─── DIM_PRODUCTS
                       │
                   DIM_SUPPLIERS
```

- **Grain:** `FACT_LINEITEM` — one row per order line item
- **Conformed dimension:** `DIM_DATE` joins to order, ship, commit, and receipt dates

---

## ⚙️ Key Features

| Feature | Implementation |
|---|---|
| Medallion Architecture | RAW → STAGING → MARTS → ANALYTICS |
| Star Schema Modeling | 2 fact tables, 4 dimension tables |
| Window Functions | YoY/MoM revenue growth, RFM scoring, Pareto analysis, CLV |
| Streams & Tasks | CDC pipeline with hourly incremental sync |
| Time Travel | Historical point-in-time queries and recovery pattern |
| Zero-Copy Cloning | Instant DEV/TEST database and table clones |
| Scheduled Aggregate Refresh | Task-driven refresh tables (materialized-view equivalent) |
| Role-Based Data Masking | Secure views enforcing masking via `CURRENT_ROLE()` |
| Region-Based Row Filtering | Secure view row filtering (row-access-policy equivalent) |
=======
```
Source (TPCH_SF1)
      │
      ▼
  RAW (Bronze) — exact copy + metadata columns
      │
      ▼
STAGING (Silver) — cleansed, typed, enriched, business rules applied
      │
      ▼
 MARTS (Gold) — Star schema: Fact + Dimension tables
      │
      ▼
ANALYTICS — Views: KPIs, RFM, CLV, Pareto, Supplier Scorecards
```

### Star Schema
- `FACT_ORDERS` + `FACT_LINEITEM` (grain: order line)
- `DIM_CUSTOMERS` | `DIM_PRODUCTS` | `DIM_SUPPLIERS` | `DIM_DATE`

---

## 🚀 Key Features

| Feature | Implementation |
|---------|----------------|
| Medallion Architecture | RAW → STAGING → MARTS → ANALYTICS |
| Star Schema Modeling | 2 Fact tables, 4 Dimension tables |
| Window Functions | YoY Growth, RFM Scoring, Pareto Analysis, CLV |
| Streams & Tasks | CDC pipeline with hourly incremental sync |
| Time Travel | Historical queries, accidental delete recovery |
| Zero-Copy Cloning | Instant DEV/TEST environment creation |
| Materialized Views | Pre-computed daily & monthly aggregations |
| Dynamic Data Masking | Role-based PII protection |
| Row Access Policies | Region-based row-level security |
>>>>>>> d4c90e99c9fa8249c768c6a7296d898a47b0d8e1
| RBAC | 4-tier role hierarchy (Admin → Engineer → Analyst → Viewer) |
| Data Quality | 7-check automated DQ suite with result logging |
| Stored Procedures | JavaScript-based pipeline automation |

---

<<<<<<< HEAD
## 🧠 Engineering Notes: Standard Edition Adaptations

This project runs on Snowflake **Standard Edition** (free trial) — which doesn't include two Enterprise+ features that most reference architectures assume: native **Materialized Views** and **Dynamic Data Masking / Row Access Policies**. Rather than skip these capabilities, they were rebuilt using patterns available on every Snowflake edition:

| Enterprise+ Feature | Standard Edition Equivalent Built Here |
|---|---|
| `CREATE MATERIALIZED VIEW` | A regular table + a `TASK` on a CRON schedule calling a stored procedure to rebuild it |
| `CREATE MASKING POLICY` | A `SECURE VIEW` with a `CASE WHEN CURRENT_ROLE() ...` expression per column |
| `CREATE ROW ACCESS POLICY` | A `SECURE VIEW` with a `CASE WHEN CURRENT_ROLE() ...` expression in the `WHERE` clause |

End-user behavior is identical — different roles see different data — but every line of SQL runs on a $0 account. This constraint-driven substitution was one of the more useful parts of building the project.

---

## 📈 Analytics in Action

### Sales KPIs — Revenue, MoM & YoY Growth
<img src="docs/screenshots/sales-kpis.png" alt="Sales KPI query results in Snowsight" width="700">

Revenue, order counts, and units sold aggregated by year/quarter/month, with month-over-month and year-over-year growth calculated via `LAG()` window functions.

### RFM Customer Segmentation
<img src="docs/screenshots/rfm-segmentation.png" alt="RFM segmentation query results in Snowsight" width="700">

Customers scored 1–5 on Recency, Frequency, and Monetary value using `NTILE(5)`, then labeled into segments — Champions, Loyal, At-Risk, Lost — for retention targeting.

### Product Performance — ABC / Pareto Analysis
<img src="docs/screenshots/product-performance.png" alt="Product performance query results in Snowsight" width="700">

Products ranked by revenue contribution with a running cumulative percentage, classifying each into A/B/C tiers using the 80/20 Pareto rule.

### Supplier Scorecard
<img src="docs/screenshots/supplier-scorecard.png" alt="Supplier scorecard query results in Snowsight" width="700">

A composite 100-point supplier score blending on-time delivery rate, return rate, and average delivery speed.

### Role-Based Masking, Verified
<img src="docs/screenshots/secure-view-masking.png" alt="Secure view masking comparison across roles in Snowsight" width="700">

The same `VW_CUSTOMERS_MASKED` view, queried as `RETAIL_ADMIN` (full data) vs. `RETAIL_VIEWER` (masked name and phone) — proof the role-based protection actually works.

> 💡 Save your Snowsight screenshots into `docs/screenshots/` using the filenames above, or rename them to match — see the setup note at the end of this file.
=======
## 📈 Analytics Built

1. **Sales KPIs** — Revenue, orders, units; MoM and YoY growth; YTD aggregation
2. **Customer LTV** — Lifetime value, tenure, monthly spend rate, revenue percentile
3. **RFM Segmentation** — Champions / Loyal / At-Risk / Lost segment labeling
4. **Product Performance** — ABC analysis, Pareto (80/20) classification
5. **Supplier Scorecard** — On-time rate, return rate, composite supplier score
6. **Shipping Analysis** — Delivery days, std deviation, on-time rate by ship mode
>>>>>>> d4c90e99c9fa8249c768c6a7296d898a47b0d8e1

---

## 🛠️ Tech Stack
<<<<<<< HEAD

- **Snowflake** — Cloud Data Warehouse (Standard Edition)
- **SnowSQL** — CLI for script execution and automation
- **VS Code** — primary editor, PowerShell integrated terminal
- **SQL** — standard SQL + Snowflake Scripting (JavaScript stored procedures)
- **Git / GitHub** — version control, phase-by-phase commit history

---

## 📁 Repository Structure

```
snowflake-retail-analytics/
├── README.md
├── .gitignore
├── .env.example
=======
- **Snowflake** — Cloud Data Warehouse (Standard Edition)
- **SnowSQL** — CLI for automation
- **VS Code** + Snowflake Extension
- **SQL** — Standard SQL + Snowflake Scripting

---

## 📁 Repo Structure
```
snowflake-retail-analytics/
>>>>>>> d4c90e99c9fa8249c768c6a7296d898a47b0d8e1
├── setup/          → Warehouses, databases, RBAC roles
├── raw/            → Bronze layer: source ingestion
├── staging/        → Silver layer: cleansing + enrichment
├── marts/          → Gold layer: star schema
<<<<<<< HEAD
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
=======
│   ├── dimensions/ → DIM_DATE, DIM_CUSTOMERS, etc.
│   └── facts/      → FACT_ORDERS, FACT_LINEITEM
├── analytics/      → Business views and KPI queries
├── advanced/       → Streams, Tasks, Cloning, Masking
├── monitoring/     → Data quality checks
└── docs/           → Architecture diagrams
>>>>>>> d4c90e99c9fa8249c768c6a7296d898a47b0d8e1
```

---

## ⚡ Quick Start

<<<<<<< HEAD
1. Sign up for a [free Snowflake trial](https://signup.snowflake.com/) (Standard Edition is enough — this whole project runs on it)
2. Clone this repo
3. Run scripts in order: `setup/` → `raw/` → `staging/` → `marts/` (dimensions before facts) → `analytics/` → `advanced/` → `monitoring/`
4. Explore the analytics views in Snowsight or any BI tool

> **Gotcha:** accounts created via signup.snowflake.com use the hyphenated account identifier format (`orgname-accountname`), not the legacy dot format. Use the exact value from Snowsight → Account → Account Identifier.
=======
1. Sign up for a [free Snowflake trial](https://signup.snowflake.com/)
2. Clone this repo
3. Run scripts in order: `setup/` → `raw/` → `staging/` → `marts/` → `analytics/`
4. Explore analytics views with any BI tool or Snowsight
>>>>>>> d4c90e99c9fa8249c768c6a7296d898a47b0d8e1

---

## 🌟 What I Learned
<<<<<<< HEAD

- Designing a multi-layer data warehouse from raw ingestion through to business-ready analytics views
- Writing analytical SQL beyond basic queries: window functions, CTEs, RFM scoring, Pareto/ABC classification
- Diagnosing real platform constraints and rebuilding Enterprise-only features (materialized views, masking/row-access policies) using Standard-Edition-compatible patterns
- Setting up RBAC from scratch: warehouses, databases, schemas, and a 4-tier role hierarchy with future grants
- Automating data quality validation with stored procedures and a persistent results log
- Running the entire build from the CLI (SnowSQL + PowerShell), including debugging account identifiers, authentication, and reserved-keyword SQL errors along the way

---

<div align="center">

Built by **Nayan** — Data Engineering Portfolio Project
<!-- add LinkedIn / portfolio links here -->

</div>
=======
- Designing scalable multi-layer data warehouses from scratch
- Snowflake-native features that aren't available in other DW platforms
- Writing complex analytical SQL: window functions, CTEs, RFM, Pareto
- Data quality automation with stored procedures and result tracking
- Role-based security and dynamic data masking for enterprise compliance
>>>>>>> d4c90e99c9fa8249c768c6a7296d898a47b0d8e1
