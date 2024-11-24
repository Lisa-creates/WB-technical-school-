SELECT seller_id 
 , COUNT(category) AS total_categ 
 , AVG(rating) AS avg_rating 
 , SUM(revenue) AS total_revenue
 , CASE WHEN SUM(revenue) > 50000 THEN 'rich' 
 ELSE 'poor' END AS seller_type
FROM sellers 
WHERE category != 'Bedding' 
GROUP BY seller_id
HAVING COUNT(category) > 1 
ORDER BY seller_id 
