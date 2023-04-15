{{config (
    materialized ="incremental",
    unique="order_id"
)}}

with orders as (
    select * from {{ref('stg_orders')}}
    {% if is_incremental()%}
    where order_date > (select max(order_date) from {{this}})
    {% endif %}
)

select * from orders
