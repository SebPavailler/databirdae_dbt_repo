select
    -- apply nullif/safe_cast function on string fields to handle the 'NULL' string
    store_id
    , nullif(store_name, 'NULL') as store_name
    , nullif(phone, 'NULL') as store_phone_number
    , nullif(email, 'NULL') as store_email
    , nullif(street, 'NULL') as store_street
    , nullif(city, 'NULL') as store_city
    , nullif(state, 'NULL') as store_state
    , safe_cast(zip_code as integer) as store_zip_code
    
from {{ source('local_bike_database', 'stores') }}