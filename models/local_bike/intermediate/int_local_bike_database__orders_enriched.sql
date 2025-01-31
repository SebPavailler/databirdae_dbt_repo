select
    -- primary key
    concat(oi.order_id, oi.item_id) as order_item_sk 

    -- order information
    , oi.order_id
    , o.order_date

    -- item product information
    , oi.item_id
     , oi.product_id
    , p.product_name as item_name
    , p.product_category_id as category_id
    , cat.category_name as category_name
    , p.product_brand_id as brand_id
    , b.brand_name as brand_name

    -- item sale information
    , oi.item_quantity
    , oi.item_list_price_per_unit
    , oi.item_discount
    , oi.item_quantity * oi.item_list_price_per_unit as item_total_amount
    , round(oi.item_quantity * oi.item_list_price_per_unit *(oi.item_discount),2) as item_discount_amount
    , round(oi.item_quantity * oi.item_list_price_per_unit * (1 - oi.item_discount),2) as item_final_amount

    -- customer information
    , o.customer_id
    , cust.customer_state
    , cust.customer_city
    , cust.customer_zip_code

    -- store information
    , o.store_id
    , sto.store_name

    -- staff information
    , o.staff_id
    , concat(sta.staff_first_name, ' ', sta.staff_last_name) as staff_name


from {{ref('stg_local_bike_database__order_items')}} as oi

left join {{ref('stg_local_bike_database__orders')}} as o
    on oi.order_id = o.order_id

left join {{ref('stg_local_bike_database__products')}} as p
    on oi.product_id = p.product_id

left join {{ref('stg_local_bike_database__brands')}} as b
    on p.product_brand_id = b.brand_id

left join {{ref('stg_local_bike_database__categories')}} as cat
    on p.product_category_id = cat.category_id

left join {{ref('stg_local_bike_database__customers')}} as cust
    on o.customer_id = cust.customer_id

left join {{ref('stg_local_bike_database__stores')}} as sto
    on o.store_id = sto.store_id

left join {{ref('stg_local_bike_database__staffs')}} as sta
    on o.staff_id = sta.staff_id