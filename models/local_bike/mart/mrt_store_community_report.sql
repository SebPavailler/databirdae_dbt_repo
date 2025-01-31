with store_categories as (

select
    customer_favorite_store
    , customer_favorite_category
    ,count(distinct customer_id) as customer_count_per_category

from {{ref('int_local_bike_database__customer_consolidated')}}

group by 
    customer_favorite_store
    , customer_favorite_category

)

, store_top_3_categories as (

select
    customer_favorite_store
    , customer_favorite_category
    , row_number() over(
        partition by customer_favorite_store 
        order by customer_count_per_category desc
        ) as category_rank

from store_categories

qualify
    row_number() over(
        partition by customer_favorite_store 
        order by customer_count_per_category desc
        ) <= 3
)


select
    --  grouping variable
    cust.customer_favorite_store as store_community

    -- calculated metrics 
    , count(distinct cust.customer_id) as customer_count
    , round(avg(cust.customer_total_orders),1) as average_orders
    , round(avg(cust.customer_total_items)) as average_items
    , round(avg(cust.customer_lifetime_value)) as average_clv
    , round(avg(cust.customer_recency/365),1) as average_recency_years

    --joined metrics
    {% for top_cat in [1,2,3] %}
    , max(case when top_3.category_rank = {{top_cat}}
        then top_3.customer_favorite_category end) as community_top_{{top_cat}}_category
    {% endfor %}

from {{ref('int_local_bike_database__customer_consolidated')}} cust

left join store_top_3_categories as top_3
    on cust.customer_favorite_store = top_3.customer_favorite_store

group by
    cust.customer_favorite_store


