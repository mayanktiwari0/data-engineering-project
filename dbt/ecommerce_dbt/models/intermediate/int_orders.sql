select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status,
    sum(oi.line_amount) as order_amount

from {{ ref('stg_orders') }} o

left join {{ ref('int_order_items') }} oi
    on o.order_id = oi.order_id

group by
    o.order_id,
    o.customer_id,
    o.order_date,
    o.order_status