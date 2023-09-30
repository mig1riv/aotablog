{{ config(
    materialized='view'
) }}

select
    id                  as payment_id,
    orderid             as order_id,
    paymentmethod       as payment_method,
    status              as payment_status,
    amount              as payment_amount,
    created             as created_dt,
    _batched_at         as etl_batched_dttm
from {{ source('stripe', 'payment') }}
