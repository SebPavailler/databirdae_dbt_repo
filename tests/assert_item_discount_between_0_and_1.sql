select *
from {{ ref('stg_local_bike_database__order_items') }}
where item_discount < 0 or item_discount > 1