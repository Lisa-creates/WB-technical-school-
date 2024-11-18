----- with window functions -----

WITH salary_employees AS (
    SELECT 
        first_name,
        last_name,
        salary,
        industry,
        FIRST_VALUE(first_name) OVER (PARTITION BY industry ORDER BY salary DESC) AS name_highest_sal,
        FIRST_VALUE(salary) OVER (PARTITION BY industry ORDER BY salary DESC) AS max_salary
    FROM salary 
)
SELECT 
    first_name,
    last_name,
    salary,
    industry,
    name_highest_sal
FROM salary_employees 
WHERE salary = max_salary 
ORDER BY industry; 
