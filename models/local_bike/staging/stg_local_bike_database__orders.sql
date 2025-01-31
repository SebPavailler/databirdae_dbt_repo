select
    -- use of safe_cast to make sure date type columns are cast to date with 'NULL' strings set to null values
    order_id
    , customer_id
    , order_status
    , safe_cast(order_date as date) as order_date
    , safe_cast(required_date as date) as required_date
    , safe_cast(shipped_date as date) as shipped_date
    , store_id
    , staff_id

from {{ source('local_bike_database', 'orders') }}