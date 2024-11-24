--- Основной запрос ---
SELECT city, age, COUNT(DISTINCT(ID)) AS count_users 
FROM users 
GROUP BY city, age
ORDER BY city,  count_users DESC 

--- Дополнительный запрос для "категорий" ---
SELECT city
 , CASE
        WHEN age BETWEEN 0 AND 20 THEN 'young'
        WHEN age BETWEEN 21 AND 49 THEN 'adult'
        WHEN age >= 50 THEN 'old'
      END AS category 
 , COUNT(DISTINCT(ID)) AS count_users 
FROM users 
GROUP BY city, CASE
        WHEN age BETWEEN 0 AND 20 THEN 'young'
        WHEN age BETWEEN 21 AND 49 THEN 'adult'
        WHEN age >= 50 THEN 'old'
      END
ORDER BY city,  count_users DESC 

