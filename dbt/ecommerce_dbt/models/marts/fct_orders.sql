{{ config(materialized='table') }}

select
    order_id,
    customer_id,
    order_date,
    order_status,
    order_amount

from {{ ref('int_orders') }}