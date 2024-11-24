WITH task_1 AS (SELECT product_category 
 , SUM(order_ammount) AS total_amount
FROM orders o 
LEFT JOIN products p ON p.product_id = o.product_id 
GROUP BY product_category), 
task_2 AS (
SELECT product_category as highest_amount_category
 , SUM(order_ammount) AS highest_amount 
FROM Orders o 
LEFT JOIN Products p ON p.product_id = o.product_id 
GROUP BY product_category 
ORDER BY SUM(order_ammount) DESC 
LIMIT 1), 
task_3 AS (
SELECT 
    p.product_category,
    p.product_name,
    MAX(o.order_ammount) AS max_sales
FROM 
    Orders o
JOIN Products p ON o.product_id = p.product_id
GROUP BY  p.product_category, p.product_name
HAVING MAX(o.order_ammount) = (
        SELECT MAX(sub_o.order_ammount)
        FROM  Orders sub_o
        JOIN Products sub_p ON sub_o.product_id = sub_p.product_id
        WHERE sub_p.product_category = p.product_category
    GROUP BY sub_p.product_category
    )
ORDER BY  p.product_category) 

SELECT 
    task_1.product_category,
    task_1.total_amount,
    task_2.highest_amount_category,
    task_3.product_name 
FROM 
    task_1 
CROSS JOIN 
    task_2 
LEFT JOIN 
    task_3 ON task_1.product_category = task_3.product_category;
