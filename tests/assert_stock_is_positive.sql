select *
from {{ ref('stg_local_bike_database__stocks') }}
where product_quantity_in_stock < 0