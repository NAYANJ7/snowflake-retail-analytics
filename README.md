<div align="center">

# 🏔️ RetailDW
### End-to-End Retail Analytics Data Warehouse on Snowflake

**Production-Grade Data Warehouse • Medallion Architecture • Star Schema • 8.6M+ Benchmark Records**

<p>

[![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)](https://www.snowflake.com/)
[![SQL](https://img.shields.io/badge/SQL-025E8C?style=for-the-badge)](.)
[![Architecture](https://img.shields.io/badge/Architecture-Medallion-orange?style=for-the-badge)](.)
[![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)](.)
[![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](.)

</p>

*A production-style Retail Analytics Data Warehouse built entirely on Snowflake, implementing Medallion Architecture, dimensional modeling, analytical SQL, data quality monitoring, security, and automation using Snowflake-native capabilities.*

</div>

---

# 📖 Table of Contents

- [Overview](#-overview)
- [Why This Project?](#-why-this-project)
- [Dataset](#-dataset)
- [Business Problem](#-business-problem)
- [Architecture](#-architecture)
- [Medallion Architecture](#-medallion-architecture)
- [Star Schema Design](#-star-schema-design)
- [Project Highlights](#-project-highlights)
- [Repository Structure](#-repository-structure)
- [Execution Flow](#-execution-flow)
- [Analytics Layer](#-analytics-layer)
- [Advanced Snowflake Features](#-advanced-snowflake-features)
- [Engineering Notes](#-engineering-notes)
- [Screenshots](#-screenshots)
- [Tech Stack](#-tech-stack)
- [Quick Start](#-quick-start)
- [Learning Outcomes](#-learning-outcomes)
- [Future Improvements](#-future-improvements)

---

# 🔍 Overview

RetailDW is an **end-to-end cloud data warehouse** built completely on **Snowflake** using the **Medallion Architecture**.

The project demonstrates how raw transactional data can be transformed into business-ready analytical models by applying industry-standard data engineering practices.

Instead of simply creating tables and running SQL queries, this project simulates how a modern enterprise data warehouse is designed.

The pipeline begins with raw source data and progresses through multiple transformation layers before exposing business-friendly analytical views for reporting and decision-making.

The implementation follows the same architectural principles commonly used by organizations building enterprise-scale data platforms on Snowflake.

---

# 💡 Why This Project?

Most portfolio projects demonstrate only SQL querying.

This project focuses on **data engineering** rather than simple analytics.

It showcases:

- Production-style Medallion Architecture
- Dimensional Data Modeling
- Star Schema Design
- Enterprise SQL
- Snowflake Native Features
- Security Implementation
- Data Quality Monitoring
- Automated Refresh Pipelines
- Business Analytics Layer

Instead of solving one analytical question, this project builds an entire analytics platform from the ground up.

---

# 📊 Dataset

The project uses the **TPC-H Benchmark Dataset**, which is built directly into every Snowflake account.

Source:

```
SNOWFLAKE_SAMPLE_DATA.TPCH_SF1
```

No downloads are required.

Anyone with a free Snowflake account can reproduce this project.

## Dataset Statistics

| Table | Records | Description |
|-------|---------:|------------|
| ORDERS | 1,500,000 | Customer Orders |
| LINEITEM | 6,001,215 | Order Line Items |
| CUSTOMER | 150,000 | Customer Master Data |
| SUPPLIER | 10,000 | Supplier Information |
| PART | 200,000 | Product Catalog |
| PARTSUPP | 800,000 | Supplier Inventory |
| NATION | 25 | Country Reference |
| REGION | 5 | Region Reference |

### Total Data Processed

> **8.6 Million+ Rows**

---

# 🏢 Business Problem

Imagine a multinational retail company operating across multiple countries.

Every day, millions of transactions are generated involving:

- Customer Orders
- Product Sales
- Supplier Deliveries
- Shipping Operations
- Inventory
- Revenue

Raw operational data is not suitable for business reporting.

The organization needs a centralized analytical platform capable of answering questions such as:

- Which customers generate the highest lifetime value?
- Which suppliers perform best?
- Which products contribute to 80% of revenue?
- Which shipping modes are most efficient?
- Which regions generate the most sales?
- How is revenue changing month-over-month?
- Which customers are at risk of churn?

RetailDW solves these problems by transforming raw transactional data into analytical models optimized for reporting.

---

# 🏗️ Architecture

```
                   SNOWFLAKE_SAMPLE_DATA
                          │
                          ▼
                ┌───────────────────────┐
                │        RAW            │
                │      Bronze Layer     │
                └───────────────────────┘
                          │
                          ▼
                ┌───────────────────────┐
                │      STAGING          │
                │      Silver Layer     │
                └───────────────────────┘
                          │
                          ▼
                ┌───────────────────────┐
                │        MARTS          │
                │      Gold Layer       │
                └───────────────────────┘
                          │
                          ▼
                ┌───────────────────────┐
                │      ANALYTICS        │
                │ Business Ready Views  │
                └───────────────────────┘
                          │
                          ▼
                Dashboards / BI / Reports
```

---

# 🥇 Medallion Architecture

The warehouse follows the Medallion Architecture, separating data into logical layers.

## 🟤 Bronze Layer (RAW)

The Bronze layer stores source data exactly as received.

Characteristics:

- No business transformations
- Metadata columns added
- Immutable copy of source
- Historical preservation

---

## ⚪ Silver Layer (STAGING)

The Silver layer standardizes and enriches the data.

Operations include:

- Data Cleaning
- Null Handling
- Type Conversion
- Deduplication
- Standardized Naming
- Derived Columns
- Business Rules

---

## 🟡 Gold Layer (MARTS)

The Gold layer contains optimized dimensional models.

This layer includes:

- Fact Tables
- Dimension Tables
- Surrogate Keys
- Business Metrics
- Analytical Models

The Gold layer is designed for fast analytical querying.

---

# ⭐ Star Schema Design

The project implements a classic dimensional model.

```
                 DIM_DATE
                     │
DIM_CUSTOMERS ─ FACT_ORDERS
                     │
              FACT_LINEITEM
              │            │
      DIM_PRODUCTS   DIM_SUPPLIERS
```

## Fact Tables

- FACT_ORDERS
- FACT_LINEITEM

## Dimension Tables

- DIM_CUSTOMERS
- DIM_PRODUCTS
- DIM_SUPPLIERS
- DIM_DATE

This design minimizes joins while maximizing analytical performance.

---

# 🚀 Project Highlights

✅ Medallion Architecture

✅ 8.6 Million+ Records

✅ Star Schema

✅ Window Functions

✅ Customer Lifetime Value

✅ RFM Segmentation

✅ Pareto Analysis

✅ Supplier Scorecards

✅ Streams & Tasks

✅ Time Travel

✅ Zero-Copy Cloning

✅ Secure Views

✅ Role-Based Access Control

✅ Data Quality Monitoring

✅ Stored Procedures

# 📁 Repository Structure

The project is organized into modular layers, making each stage of the pipeline easy to understand, maintain, and extend.

```text
snowflake-retail-analytics/
│
├── README.md
├── .gitignore
├── .env.example
│
├── setup/
│   ├── 01_create_warehouses.sql
│   ├── 02_create_databases.sql
│   └── 03_create_roles.sql
│
├── raw/
│   └── 01_load_raw_tables.sql
│
├── staging/
│   ├── 01_stg_orders.sql
│   ├── 02_stg_customers.sql
│   ├── 03_stg_lineitem.sql
│   ├── 04_stg_products.sql
│   └── 05_stg_suppliers.sql
│
├── marts/
│   ├── dimensions/
│   │   ├── dim_date.sql
│   │   ├── dim_customers.sql
│   │   ├── dim_products.sql
│   │   └── dim_suppliers.sql
│   │
│   └── facts/
│       ├── fact_orders.sql
│       └── fact_lineitem.sql
│
├── analytics/
│   ├── 01_sales_kpis.sql
│   ├── 02_customer_analytics.sql
│   ├── 03_product_performance.sql
│   └── 04_supplier_analysis.sql
│
├── advanced/
│   ├── 01_streams_and_tasks.sql
│   ├── 02_time_travel.sql
│   ├── 03_cloning.sql
│   ├── 04_materialized_views.sql
│   └── 05_security.sql
│
├── monitoring/
│   └── 01_data_quality.sql
│
└── docs/
    ├── architecture.png
    └── screenshots/
```

---

# ⚙️ Project Execution Flow

The warehouse is built incrementally.

Each layer depends on the successful completion of the previous one.

```
Setup
   │
   ▼
RAW Layer
   │
   ▼
STAGING Layer
   │
   ▼
MARTS Layer
   │
   ▼
ANALYTICS Layer
   │
   ▼
Advanced Snowflake Features
   │
   ▼
Monitoring
```

Execution order:

1. Configure Warehouses
2. Create Database & Schemas
3. Configure RBAC
4. Load RAW tables
5. Build STAGING tables
6. Create Dimension tables
7. Create Fact tables
8. Create Analytics Views
9. Configure Streams & Tasks
10. Configure Security
11. Run Data Quality Checks

---

# 📈 Analytics Layer

The Analytics schema exposes business-friendly views that are optimized for reporting and dashboarding.

Instead of querying raw transactional tables, analysts interact directly with these curated views.

---

## 💰 Sales KPI Dashboard

The Sales KPI view provides executive-level metrics describing overall business performance.

Metrics include:

- Total Revenue
- Gross Revenue
- Net Revenue
- Average Order Value
- Total Orders
- Unique Customers
- Total Units Sold
- Return Rate
- On-Time Delivery Rate

Business Value:

This serves as the primary reporting layer for executive dashboards.

📷 Screenshot

```text
docs/screenshots/sales_kpis.png
```

```markdown
![Sales KPIs](docs/screenshots/sales_kpis.png)
```

---

## 📈 Revenue Growth Analysis

Revenue is analyzed over time using SQL window functions.

Metrics:

- Monthly Revenue
- Quarterly Revenue
- Yearly Revenue
- Month-over-Month Growth
- Year-over-Year Growth
- Year-To-Date Revenue

Window Functions Used

- LAG()
- SUM() OVER()

Business Value

Enables trend analysis and long-term revenue forecasting.

📷 Screenshot

```markdown
![Revenue Growth](docs/screenshots/revenue_growth.png)
```

---

## 👥 Customer Lifetime Value (CLV)

Each customer is evaluated based on their historical purchasing behavior.

Metrics:

- Lifetime Revenue
- Average Order Value
- Purchase Frequency
- Customer Tenure
- Revenue Contribution
- Revenue Percentile

Business Value

Helps identify high-value customers for loyalty and retention initiatives.

📷 Screenshot

```markdown
![Customer LTV](docs/screenshots/customer_ltv.png)
```

---

## 🎯 RFM Segmentation

Customers are segmented using the RFM framework.

R → Recency

F → Frequency

M → Monetary Value

Customer Segments:

- Champions
- Loyal Customers
- Potential Loyalists
- New Customers
- At Risk
- Lost Customers

Functions Used

- NTILE()
- CASE
- Window Functions

Business Value

Supports customer retention and targeted marketing campaigns.

📷 Screenshot

```markdown
![RFM](docs/screenshots/rfm_segmentation.png)
```

---

## 📦 Product Performance

Each product is evaluated using revenue contribution and sales metrics.

Metrics

- Revenue
- Units Sold
- Average Selling Price
- Discount Rate
- Return Rate
- Revenue Rank

The project also performs Pareto Analysis (80/20 Rule).

Products are automatically classified into:

- A Class
- B Class
- C Class

Business Value

Identifies products responsible for the majority of company revenue.

📷 Screenshot

```markdown
![Product Performance](docs/screenshots/product_performance.png)
```

---

## 🚚 Supplier Scorecard

Each supplier receives a composite performance score.

Metrics include:

- Revenue Generated
- Delivery Performance
- Return Rate
- Average Delivery Time
- On-Time Percentage
- Supplier Score

Business Value

Enables procurement teams to identify top-performing suppliers.

📷 Screenshot

```markdown
![Supplier Scorecard](docs/screenshots/supplier_scorecard.png)
```

---

# 🚀 Advanced Snowflake Features

One of the primary goals of this project was to showcase Snowflake-specific capabilities beyond traditional SQL.

---

## 🌊 Streams

Snowflake Streams provide Change Data Capture (CDC) without requiring external tools.

The project uses Streams to detect inserts, updates, and deletes in staging tables.

Benefits:

- Incremental Processing
- CDC
- Pipeline Automation
- Reduced Compute Cost

📷 Screenshot

```markdown
![Streams](docs/screenshots/streams.png)
```

---

## ⏰ Tasks

Snowflake Tasks automate SQL execution using schedules.

The project demonstrates:

- Scheduled Refresh
- Automated Pipeline Execution
- Incremental Updates
- Dependency Management

Benefits

- Fully Automated Data Pipeline
- No External Scheduler Required

📷 Screenshot

```markdown
![Tasks](docs/screenshots/tasks.png)
```

---

## ⏳ Time Travel

Snowflake Time Travel allows querying historical versions of data.

The project demonstrates:

- Historical Queries
- Recovery After Delete
- Point-in-Time Analysis

Business Value

Provides protection against accidental data loss.

📷 Screenshot

```markdown
![Time Travel](docs/screenshots/time_travel.png)
```

---

## 🧬 Zero-Copy Cloning

Zero-Copy Cloning creates instant copies of databases without duplicating storage.

The project demonstrates cloning for:

- Development
- Testing
- Backup
- Experimentation

Benefits

- Instant Environment Creation
- Minimal Storage Cost

📷 Screenshot

```markdown
![Cloning](docs/screenshots/cloning.png)
```

---

## 🔒 Secure Views & Dynamic Masking

Sensitive customer information is protected using Secure Views.

Depending on the active role:

- Administrators view complete data.
- Analysts view partially masked data.
- Viewers access only approved information.

Protected Fields

- Customer Name
- Phone Number
- Personal Details

Business Value

Supports enterprise-grade data governance.

📷 Screenshots

```markdown
![Admin View](docs/screenshots/masking_admin.png)

![Viewer View](docs/screenshots/masking_viewer.png)
```

---

## 👤 Role-Based Access Control (RBAC)

The warehouse implements a hierarchical role model.

```
ACCOUNTADMIN
      │
RETAIL_ADMIN
      │
RETAIL_ENGINEER
      │
RETAIL_ANALYST
      │
RETAIL_VIEWER
```

Privileges are assigned using Snowflake RBAC principles.

Benefits

- Principle of Least Privilege
- Secure Data Access
- Enterprise Governance

---

## ✅ Data Quality Monitoring

A dedicated Monitoring layer validates data after each pipeline stage.

Quality Checks include:

- Null Value Detection
- Duplicate Detection
- Row Count Validation
- Primary Key Validation
- Foreign Key Validation
- Invalid Date Detection
- Business Rule Validation

Results are stored in monitoring tables for auditing.

📷 Screenshot

```markdown
![Data Quality](docs/screenshots/data_quality.png)
```

---

# 📸 Project Screenshots

The following screenshots are recommended for the repository.

docs/
└── screenshots/
    ├── architecture.png
    ├── raw_tables.png
    ├── staging_tables.png
    ├── marts_tables.png
    ├── analytics_views.png
    ├── sales_kpis.png
    ├── revenue_growth.png
    ├── customer_ltv.png
    ├── rfm_segmentation.png
    ├── product_performance.png
    ├── supplier_scorecard.png
    ├── streams.png
    ├── tasks.png
    ├── time_travel.png
    ├── cloning.png
    ├── masking_admin.png
    ├── masking_viewer.png
    └── data_quality.png
