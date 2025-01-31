with empty as (select null)

-- Jinja loop below to build favorite store, category and brand for each consumer
{% for customer_dimension in ["store", "category", "brand"] %}

, customer_{{customer_dimension}} as (

select
    customer_id
    , {{customer_dimension}}_id

    , any_value({{customer_dimension}}_name) as {{customer_dimension}}_name
    , count(distinct order_id) as order_count_per_{{customer_dimension}}

from {{ref('int_local_bike_database__orders_enriched')}}

group by
    customer_id
    , {{customer_dimension}}_id

)

, customer_favorite_{{customer_dimension}} as (

select
    customer_id
    , {{customer_dimension}}_name as favorite_{{customer_dimension}}
    , if(
        count(distinct {{customer_dimension}}_id) over(partition by customer_id) > 1
        , true
        , false
     ) as is_multi_{{customer_dimension}}

from customer_{{customer_dimension}}

qualify
    row_number() over(partition by customer_id order by order_count_per_{{customer_dimension}} desc) = 1
)

{% endfor %}


-- final query below to build a consolidated customer view
select
    --  grouping variable
    orders.customer_id

    -- customer dimensions
    , any_value(orders.customer_state) as customer_state
    , any_value(orders.customer_city) as customer_city
    , any_value(orders.customer_zip_code) as customer_zip_code

    -- customer sales metrics
    , count(distinct orders.order_id) as customer_total_orders
    , sum(orders.item_quantity) as customer_total_items
    , round(sum(orders.item_final_amount)) as customer_lifetime_value

    -- customer lifetime metrics
    , max(orders.order_date) as customer_last_order_date
    , date_diff(current_date(), max(orders.order_date),  day) as customer_recency

    -- customer habits - use Jinja 
{% for customer_dimension in ["store", "category", "brand"] %}
    , any_value(joined_{{customer_dimension}}.favorite_{{customer_dimension}}) as customer_favorite_{{customer_dimension}}
    , any_value(joined_{{customer_dimension}}.is_multi_{{customer_dimension}}) as is_customer_multi_{{customer_dimension}}
{% endfor %}

from {{ref('int_local_bike_database__orders_enriched')}} as orders

-- join tables with customer's favorites - use Jinja
{% for customer_dimension in ["store", "category", "brand"] %}
left join customer_favorite_{{customer_dimension}} as joined_{{customer_dimension}}
    on orders.customer_id = joined_{{customer_dimension}}.customer_id
{% endfor %}

group by customer_id