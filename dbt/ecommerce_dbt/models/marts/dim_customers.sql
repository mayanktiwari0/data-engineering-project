{{ config(materialized='table') }}

select
    customer_id,
    customer_name,
    email,
    city,
    state,
    signup_date,
    total_orders,
    total_spend,
    first_order_date,
    last_order_date

from {{ ref('int_customers') }}