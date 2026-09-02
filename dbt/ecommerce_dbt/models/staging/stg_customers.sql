select
    customer_id,
    customer_name,
    lower(trim(email)) as email,
    trim(city) as city,
    trim(state) as state,
    signup_date,
    _fivetran_synced

from {{ source('ecommerce', 'customers') }}