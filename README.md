<div align="center">

# 🏔️ RetailDW

### End-to-End Retail Analytics Data Warehouse on Snowflake

**Medallion Architecture • Star Schema • 8.6M+ Records • Snowflake Standard Edition**

[![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)](https://www.snowflake.com/)
![SQL](https://img.shields.io/badge/SQL-025E8C?style=for-the-badge)
![Architecture](https://img.shields.io/badge/Architecture-Medallion-orange?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=for-the-badge)

</div>

---

# 📖 Overview

RetailDW is a production-style **Retail Analytics Data Warehouse** built entirely on **Snowflake** using the **Medallion Architecture**.

The project transforms over **8.6 million** TPC-H benchmark records into business-ready analytical models using dimensional modeling, advanced SQL, and Snowflake-native features.

Key concepts demonstrated include:

- Medallion Architecture (Bronze → Silver → Gold)
- Star Schema Design
- Analytical SQL
- Streams & Tasks
- Time Travel
- Zero-Copy Cloning
- Role-Based Access Control (RBAC)
- Secure Views
- Data Quality Monitoring

---

# 📊 Dataset

Source:

```
SNOWFLAKE_SAMPLE_DATA.TPCH_SF1
```

| Table | Rows |
|-------|------:|
| ORDERS | 1,500,000 |
| LINEITEM | 6,001,215 |
| CUSTOMER | 150,000 |
| SUPPLIER | 10,000 |
| PART | 200,000 |
| PARTSUPP | 800,000 |

**Total Data Processed:** **8.6M+ Rows**

---

# 🏗️ Architecture

```
TPCH Sample Data
      │
      ▼
 RAW (Bronze)
      │
      ▼
STAGING (Silver)
      │
      ▼
 MARTS (Gold)
      │
      ▼
ANALYTICS
```

## Star Schema

```
                 DIM_DATE
                     │
DIM_CUSTOMERS ─ FACT_ORDERS
                     │
              FACT_LINEITEM
               │         │
      DIM_PRODUCTS  DIM_SUPPLIERS
```

---

# 🚀 Features

| Feature | Description |
|---------|-------------|
| Medallion Architecture | Bronze → Silver → Gold data pipeline |
| Star Schema | Fact & Dimension modeling |
| Analytics Views | Sales KPIs, CLV, RFM, Pareto, Supplier Scorecards |
| Streams & Tasks | Automated incremental processing |
| Time Travel | Historical queries & recovery |
| Zero-Copy Cloning | Instant development/testing environments |
| Secure Views | Role-based data masking |
| RBAC | Multi-role security model |
| Data Quality | Automated validation framework |

---

# 📈 Analytics

The Analytics layer provides ready-to-query business views.

### Sales KPIs
- Revenue
- Orders
- Units Sold
- Average Order Value
- Return Rate

### Revenue Growth
- Month-over-Month Growth
- Year-over-Year Growth
- YTD Revenue

### Customer Analytics
- Customer Lifetime Value (CLV)
- Revenue Percentile
- Customer Ranking

### RFM Segmentation
- Champions
- Loyal Customers
- Potential Loyalists
- At Risk
- Lost Customers

### Product Analytics
- Product Revenue
- Pareto (ABC Classification)
- Product Ranking

### Supplier Scorecards
- On-Time Delivery
- Return Rate
- Supplier Performance Score

---

# ⚡ Advanced Snowflake Features

This project demonstrates several Snowflake-native capabilities:

- ✅ Streams (CDC)
- ✅ Tasks (Automation)
- ✅ Time Travel
- ✅ Zero-Copy Cloning
- ✅ Secure Views
- ✅ Stored Procedures
- ✅ RBAC
- ✅ Data Quality Monitoring

---

# 📂 Repository Structure

```text
setup/
raw/
staging/
marts/
analytics/
advanced/
monitoring/
docs/
```

---

# ▶️ Execution Order

Run the scripts in the following order:

```
setup/
   ↓
raw/
   ↓
staging/
   ↓
marts/
   ↓
analytics/
   ↓
advanced/
   ↓
monitoring/
```

---

# 📸 Screenshots

Store project screenshots inside:

```
docs/screenshots/
```

Recommended screenshots:

- Architecture
- Sales KPIs
- Revenue Growth
- Customer LTV
- RFM Segmentation
- Product Performance
- Supplier Scorecard
- Streams & Tasks
- Time Travel
- Zero-Copy Cloning
- Secure View Masking
- Data Quality Dashboard

---

# 🛠️ Tech Stack

| Category | Technology |
|----------|------------|
| Cloud Data Warehouse | Snowflake |
| Query Language | SQL |
| Stored Procedures | JavaScript |
| CLI | SnowSQL |
| IDE | VS Code |
| Version Control | Git & GitHub |

---

# 📚 Key Learnings

Through this project I gained practical experience in:

- Building production-style data warehouses
- Designing Medallion Architectures
- Star Schema Modeling
- Advanced SQL & Window Functions
- Snowflake Security (RBAC & Secure Views)
- Streams & Tasks Automation
- Time Travel & Cloning
- Data Quality Frameworks

---

# 🚀 Future Improvements

- dbt Integration
- Airflow Orchestration
- Power BI Dashboard
- Snowpark Transformations
- CI/CD with GitHub Actions
- Infrastructure as Code using Terraform

---

# 👨‍💻 Author

**Nayan Jain**

Aspiring Data Engineer | Data Analyst

If you found this project useful, consider giving it a ⭐ on GitHub.

---
