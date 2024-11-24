-- Будем считать, что неуспешный = 'poor' 
SELECT seller_id 
    , FLOOR(EXTRACT(DAY FROM (NOW() - MIN(TO_DATE(date_reg, 'DD/MM/YYYY')))) / 30) AS month_from_regidtration 
    , (SELECT MAX(delivery_days) - MIN(delivery_days) AS max_delivery_days 
FROM sellers 
WHERE category != 'Bedding')
FROM sellers 
WHERE category != 'Bedding' 
GROUP BY seller_id 
HAVING COUNT(category) > 1 AND SUM(revenue) <= 50000
ORDER BY seller_id 

