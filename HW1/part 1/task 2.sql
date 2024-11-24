SELECT 
    ROUND(AVG(price), 2) AS avg_price,
    category 
FROM products
WHERE LOWER(name) LIKE '%hair%' OR LOWER(name) LIKE '%home%'
GROUP BY category; 
