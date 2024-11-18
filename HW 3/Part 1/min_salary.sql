----- Without window functions -------
WITH min_salary AS (
    SELECT 
       industry,
       MIN(salary) AS min_sal
    FROM salary 
  	GROUP BY industry
)
SELECT 
    first_name,
    last_name,
    salary,
    s.industry,
    first_name AS name_highest_sal
FROM salary s
INNER JOIN min_salary ms ON ms.min_sal = s.salary AND ms.industry = s.industry
ORDER BY s.industry;

----- With window functions -------
WITH salary_employees AS (
    SELECT 
        first_name,
        last_name,
        salary,
        industry,
        FIRST_VALUE(first_name) OVER (PARTITION BY industry ORDER BY salary) AS name_highest_sal,
        FIRST_VALUE(salary) OVER (PARTITION BY industry ORDER BY salary) AS max_salary
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
