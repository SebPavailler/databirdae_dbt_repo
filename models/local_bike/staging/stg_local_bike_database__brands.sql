select 
    brand_id
    , brand_name
    
from {{ source('local_bike_database', 'brands') }}