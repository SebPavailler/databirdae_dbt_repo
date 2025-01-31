select
    product_id
    , product_name
    , brand_id as product_brand_id
    , category_id as product_category_id
    , model_year as product_model_year
    , list_price as product_list_price
    
from {{ source('local_bike_database', 'products') }}