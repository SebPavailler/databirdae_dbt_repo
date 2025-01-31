select
    -- apply nullif function on string fields to handle the 'NULL' string
    customer_id
    , nullif(first_name, 'NULL') as customer_first_name
    , nullif(last_name, 'NULL') as customer_last_name
    , nullif(phone, 'NULL') as customer_phone_number
    , nullif(email, 'NULL') as customer_email
    , nullif(street, 'NULL') as customer_street
    , nullif(city, 'NULL') as customer_city
    , nullif(state, 'NULL') as customer_state
    , safe_cast(zip_code as integer) as customer_zip_code
    
from {{ source('local_bike_database', 'customers') }}