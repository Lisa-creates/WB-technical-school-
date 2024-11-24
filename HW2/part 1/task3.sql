WITH customers AS (
SELECT * 
FROM orders_new_3 
WHERE EXTRACT(DAY FROM((shipment_date)::TIMESTAMP - (order_date)::TIMESTAMP)) > 5 
 OR order_status = 'Cancel'
  ) 
  
 SELECT name 
  , SUM(CASE WHEN order_status != 'Cancel' THEN 1 ELSE 0 END)
    , SUM(CASE WHEN order_status = 'Cancel' THEN 1 ELSE 0 END)
 , SUM(order_ammount) as total_amount 
 FROM customers 
 LEFT JOIN customers_new_3 c ON c.customer_id = customers.customer_id 
 GROUP by name 
 ORDER BY total_amount DESC
