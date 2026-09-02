select
    payment_id,
    order_id,
    payment_date,
    lower(trim(payment_method)) as payment_method,
    lower(trim(payment_status)) as payment_status,
    amount,
    _fivetran_synced

from {{ source('ecommerce', 'payments') }}