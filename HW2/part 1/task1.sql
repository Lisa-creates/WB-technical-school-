WITH max_time AS (
  SELECT MAX(EXTRACT(EPOCH FROM((shipment_date)::TIMESTAMP - (order_date)::TIMESTAMP)) / 3600) AS max_waiting_time_in_hours
FROM orders_new_3 o 
  )

SELECT C.name
 , MAX(EXTRACT(EPOCH FROM((shipment_date)::TIMESTAMP - (order_date)::TIMESTAMP)) / 3600) AS waiting_time_in_hours_for_customer
FROM orders_new_3 o 
LEFT JOIN customers_new_3 c ON c.customer_id = o.customer_id
GROUP BY C.name 
HAVING MAX(EXTRACT(EPOCH FROM((shipment_date)::TIMESTAMP - (order_date)::TIMESTAMP)) / 3600) = (SELECT * FROM max_time) 
