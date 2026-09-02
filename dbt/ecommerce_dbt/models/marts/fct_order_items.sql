{{ config(materialized='table') }}

select
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    line_amount

from {{ ref('int_order_items') }}