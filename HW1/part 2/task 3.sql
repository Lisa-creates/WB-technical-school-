---- Первый вариант ------
-- Если считаем, что дат регестарации sellera несколько, то есть значения в date_reg   

SELECT seller_id 
 , STRING_AGG(category, ' - ' ORDER BY category) AS category_pair
FROM sellers 
WHERE EXTRACT(YEAR FROM (TO_DATE(date_reg, 'DD/MM/YYYY'))) = 2022 
GROUP BY seller_id 
HAVING COUNT(category) = 2 
    AND SUM(revenue) > 75000 
    
---- Второй вариант ------
-- Если считаем датой регестарации sellera минимальную дату из date_reg для sellera

SELECT seller_id 
 , STRING_AGG(category, ' - ' ORDER BY category) AS category_pair
FROM sellers 
GROUP BY seller_id 
HAVING EXTRACT(YEAR FROM MIN(TO_DATE((date_reg), 'DD/MM/YYYY'))) = 2022 and 
    COUNT(category) = 2 
    AND SUM(revenue) > 75000
