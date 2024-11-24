WITH count_order AS (
SELECT COUNT(order_id) AS count_
FROM orders_new_3 
GROUP BY customer_id) 

SELECT name
 , AVG(EXTRACT(EPOCH FROM((shipment_date)::TIMESTAMP - (order_date)::TIMESTAMP)) / 3600) AS avg_time 
 , SUM(order_ammount) as sum_customers 
FROM orders_new_3 o 
LEFT JOIN customers_new_3 c ON o.customer_id = C.customer_id 
GROUP by name
HAVING COUNT(order_id) = (SELECT MAX(count_) FROM count_order) 
ORDER BY sum_customers 
