{% docs int_local_bike_database__customer_consolidated %}

This model provides an aggregated view of customers, especially adding some custom calculations on orders and favorite store, category and brand.
The model includes the following metrics:
- **Customer total orders**: The total number of orders placed for each customer.
- **Customer total items**: The total quantity of items purchased by each customer.
- **Customer lifetime value**: The sum of the final amount of all items purchased by each customer. This provides the total revenue brought by each consumer to Local Bike.
- **Customer recency**: The time difference in days between each customer's last order and the current date.
- **Customer's favorites**: The store/category/brand for which each customer has the highest number or orders.
- **Customer 'is multi'**: Boolean indicating if each customer has placed order in multiple stores/categories/brands.

It provides a comprehensive view of each customer, allowing for easy analysis of customer behaviour.

{% enddocs %}
