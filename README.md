# snowflake-retail-analytics
End-to-End Data Warehouse on Snowflake | Medallion Architecture | TPC-H Dataset

[![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=flat&logo=snowflake&logoColor=white)](https://www.snowflake.com/)
[![SQL](https://img.shields.io/badge/SQL-blue?style=flat&logo=database)](.)
[![Architecture](https://img.shields.io/badge/Architecture-Medallion-orange)](.)
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

---

## 🏗️ Architecture
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
| RBAC | 4-tier role hierarchy (Admin → Engineer → Analyst → Viewer) |
| Data Quality | 7-check automated DQ suite with result logging |
| Stored Procedures | JavaScript-based pipeline automation |

---

## 📈 Analytics Built

1. **Sales KPIs** — Revenue, orders, units; MoM and YoY growth; YTD aggregation
2. **Customer LTV** — Lifetime value, tenure, monthly spend rate, revenue percentile
3. **RFM Segmentation** — Champions / Loyal / At-Risk / Lost segment labeling
4. **Product Performance** — ABC analysis, Pareto (80/20) classification
5. **Supplier Scorecard** — On-time rate, return rate, composite supplier score
6. **Shipping Analysis** — Delivery days, std deviation, on-time rate by ship mode

---

## 🛠️ Tech Stack
- **Snowflake** — Cloud Data Warehouse (Standard Edition)
- **SnowSQL** — CLI for automation
- **VS Code** + Snowflake Extension
- **SQL** — Standard SQL + Snowflake Scripting

---

## 📁 Repo Structure
```
snowflake-retail-analytics/
├── setup/          → Warehouses, databases, RBAC roles
├── raw/            → Bronze layer: source ingestion
├── staging/        → Silver layer: cleansing + enrichment
├── marts/          → Gold layer: star schema
│   ├── dimensions/ → DIM_DATE, DIM_CUSTOMERS, etc.
│   └── facts/      → FACT_ORDERS, FACT_LINEITEM
├── analytics/      → Business views and KPI queries
├── advanced/       → Streams, Tasks, Cloning, Masking
├── monitoring/     → Data quality checks
└── docs/           → Architecture diagrams
```

---

## ⚡ Quick Start

1. Sign up for a [free Snowflake trial](https://signup.snowflake.com/)
2. Clone this repo
3. Run scripts in order: `setup/` → `raw/` → `staging/` → `marts/` → `analytics/`
4. Explore analytics views with any BI tool or Snowsight

---

## 🌟 What I Learned
- Designing scalable multi-layer data warehouses from scratch
- Snowflake-native features that aren't available in other DW platforms
- Writing complex analytical SQL: window functions, CTEs, RFM, Pareto
- Data quality automation with stored procedures and result tracking
- Role-based security and dynamic data masking for enterprise compliance
