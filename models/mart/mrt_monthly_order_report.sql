select
    DATE_TRUNC(order_created_at, month) AS order_month
    , coalesce(count(distinct user_id),0) as total_monthly_user_count
    , coalesce(count(order_id),0) as total_monthly_order_count
    , coalesce(
        count(distinct case when user_state='JAWA TIMUR' then user_id end)
        ,0) as jawa_timur_monthly_user_count

from 
    {{ ref("int_sales_database__order") }}

group by order_month

order by order_month

