select
    concat(order_id, item_id) as order_item_sk 
    , order_id
    , item_id
    , product_id
    , quantity as item_quantity
    , list_price as item_list_price_per_unit
    , discount as item_discount

from {{ source('local_bike_database', 'order_items') }}