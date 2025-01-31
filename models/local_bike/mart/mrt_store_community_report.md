{% docs mrt_store_community_report %}

This model is intended to provide insights about the communities driven by the 3 Local Bike stores.
It provides an aggregated view at store level, with customer information taken from the int_local_bike_database__customer_consolidated model.
The **Store community** column is derived from the customer's favorite store and serves as grouping variable. We defined a store community as all customers having a given store as favorite's.
Then then model includes the following metrics:
- **Customer count**: The total number of customers in the store community.
- **Average orders**: The average number of orders per customer in the community.
- **Average items**: The average number of items per customer in the community.
- **Average CLV**: The average customer lifetime value across customers in the community.
- **Average recency (years)**: The average time in years between customers' last order and current date in the community.
- **Community top categories**: The top 1, 2 and 3 product categories acclaimed by customers in the community.

It provides a summary view of the store communities behaviour and value, which can be extremely useful for local activations and for driving performance at the store level.

{% enddocs %}
