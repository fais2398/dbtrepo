{{config (
    materialized ="table"
)}}

with customers as (
    select 
    id as customer_id,
    first_name,
    last_name
    from raw.jaffle_shop.customers
),

orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from raw.jaffle_shop.orders

),

final as (
select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        coalesce(count(order_id),0) as number_of_orders

    from customers

    left join orders  on (customers.customer_id=orders.customer_id)
    group by 
        customers.customer_id,
        customers.first_name,
        customers.last_name

)

select * from final 


