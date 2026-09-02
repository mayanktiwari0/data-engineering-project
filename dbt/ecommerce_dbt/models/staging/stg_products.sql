select
    product_id,
    trim(product_name) as product_name,
    trim(category) as category,
    trim(subcategory) as subcategory,
    unit_price,
    _fivetran_synced

from {{ source('ecommerce', 'products') }}