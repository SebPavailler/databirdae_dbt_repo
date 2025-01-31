select
    -- apply nullif function on string fields to handle the 'NULL' string
    staff_id
    , nullif(first_name, 'NULL') as staff_first_name
    , nullif(last_name, 'NULL') as staff_last_name
    , nullif(email, 'NULL') as staff_email
    , nullif(phone, 'NULL') as staff_phone_number
    , cast(active as bool) as is_staff_active
    , store_id as staff_store_id
    , safe_cast(manager_id as integer) as staff_manager_id

from {{ source('local_bike_database', 'staffs') }}