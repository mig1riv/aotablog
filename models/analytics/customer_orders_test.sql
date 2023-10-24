with customers as (

    select
        customer_id,
        first_name,
        last_name

    from {{ ref('customers') }}

),

orders as (

    select
        id as order_id,
        customer_id,
        order_dt,
        order_status

    from {{ ref('orders') }}

),

customer_orders as (

    select
        customer_id,

        min(order_dt) as first_order_dt,
        max(order_dt) as most_recent_order_dt,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_dt,
        customer_orders.most_recent_order_dt,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final
limit 1