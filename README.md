# End-to-End E-Commerce Data Engineering Project

An end-to-end data engineering pipeline that ingests e-commerce data from AWS S3, loads it into Snowflake using Fivetran, transforms and tests the data using dbt, orchestrates the workflow with Apache Airflow, and serves the final data to Power BI for analytics.

## Architecture

AWS S3
  ↓
Fivetran
  ↓
Snowflake RAW
  ↓
dbt
  ├── Staging
  ├── Intermediate
  └── Marts
  ↓
Apache Airflow
  ↓
Snowflake Analytics Layer
  ↓
Power BI

## Tech Stack

* **AWS S3** – Source data storage
* **Fivetran** – Automated data ingestion
* **Snowflake** – Cloud data warehouse
* **dbt** – Data transformation, modeling and testing
* **Apache Airflow** – Pipeline orchestration
* **Power BI** – Data visualization and reporting
* **SQL** – Data transformation and analytical logic
* **Docker** – Airflow environment

## Pipeline

### 1. Data Ingestion

E-commerce source files are stored in an AWS S3 bucket.

Fivetran ingests the source data from S3 into the RAW layer of Snowflake.

### 2. Data Transformation

dbt transforms the RAW data through multiple layers:

RAW
 ↓
Staging
 ↓
Intermediate
 ↓
Marts


The dbt project contains:

* Staging models
* Intermediate transformation models
* Incremental model
* Dimension tables
* Fact tables
* Source definitions
* Schema tests

### 3. Data Quality

dbt tests are used to validate the transformed data, including:

* Unique values
* Not-null values
* Referential integrity
* Accepted values

### 4. Pipeline Orchestration

Apache Airflow orchestrates the transformation workflow.

The pipeline performs:

Validate RAW Data
      ↓
Run dbt Models
      ↓
Run dbt Tests


The Airflow DAG ensures that the transformation and data-quality steps execute in the correct order.

### 5. Analytics & Power BI Dashboard

The final Snowflake analytics layer is connected to Power BI using **DirectQuery** to provide interactive e-commerce reporting.

The Power BI dashboard includes:

#### Key Performance Indicators

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Total Payments

#### Business Analysis

- Order Status Breakdown
- Items Sold by Product
- Revenue Trend over Time
- Items Sold by Category
- Payment Status Breakdown
- Revenue by State

#### Interactive Filters

- Order Date
- Product Category
- Order Status

The dashboard allows users to interactively filter the data and analyze revenue, orders, customers, products, payments and geographic performance.

**Power BI file:** ecommerce_dashboard.pbix

## dbt Data Model

The project contains the following analytical models.

### Dimensions

* `dim_customers`
* `dim_products`

### Facts

* `fct_orders`
* `fct_order_items`
* `fct_payments`

### Intermediate Models

* `int_customers`
* `int_orders`
* `int_order_items`
* `int_orders_incremental`

## Project Structure

data-engineering-project/
│
├── airflow/
│   ├── dags/
│   │   └── ecommerce_pipeline.py
│   └── docker-compose.yaml
│
├── dbt/
│   └── ecommerce_dbt/
│       ├── models/
│       │   ├── staging/
│       │   ├── intermediate/
│       │   └── marts/
│       ├── macros/
│       ├── snapshots/
│       ├── seeds/
│       ├── tests/
│       └── dbt_project.yml
│
└── README.md


## Key Skills Demonstrated

* Building an end-to-end data pipeline
* Cloud data ingestion
* Snowflake data warehousing
* ELT architecture
* dbt data transformation and dimensional modeling
* Incremental data processing
* Data quality testing
* Airflow DAG orchestration
* Docker-based development
* Power BI integration
* SQL-based data transformation

## Outcome

The project demonstrates a complete modern data engineering workflow, from raw data ingestion through transformation, testing, orchestration and business intelligence reporting.
