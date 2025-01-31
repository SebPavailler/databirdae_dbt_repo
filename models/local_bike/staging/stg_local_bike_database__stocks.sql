select
    concat(store_id, product_id) as store_product_sk
    , store_id
    , product_id
    , quantity as product_quantity_in_stock
    
from {{ source('local_bike_database', 'stocks') }}