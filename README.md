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
