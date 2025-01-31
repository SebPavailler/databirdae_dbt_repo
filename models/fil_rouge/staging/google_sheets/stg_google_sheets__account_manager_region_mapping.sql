select
    account_manager,
    state
from {{ source('module2', 'account_manager_region_mapping') }}
