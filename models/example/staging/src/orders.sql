{{ config(
    materialized='view'
) }}

select
    id              as id,
    user_id         as customer_id,
    status          as order_status,
    order_date      as order_dt, 
    _etl_loaded_at   as etl_load_dttm
from {{ source('jaffle_shop','orders') }}