select
    order_id,
    customer_id,
    order_date,
    lower(trim(order_status)) as order_status,
    _fivetran_synced

from {{ source('ecommerce', 'orders') }}