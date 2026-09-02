select
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.state,
    c.signup_date,
    count(o.order_id) as total_orders,
    coalesce(sum(o.order_amount), 0) as total_spend,
    min(o.order_date) as first_order_date,
    max(o.order_date) as last_order_date

from {{ ref('stg_customers') }} c

left join {{ ref('int_orders') }} o
    on c.customer_id = o.customer_id

group by
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.state,
    c.signup_date