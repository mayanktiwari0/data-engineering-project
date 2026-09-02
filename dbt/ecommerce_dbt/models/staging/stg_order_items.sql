select
    order_item_id,
    order_id,
    product_id,
    quantity,
    unit_price,
    _fivetran_synced

from {{ source('ecommerce', 'order_items') }}