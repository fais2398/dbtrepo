with payments as (

select * from {{ref('stg_payment')}}
)

select orderid,sum(amount) as total_amt from payments
group by orderid having total_amt <0