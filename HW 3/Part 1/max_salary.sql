        ----- Если в выводе нужно просто приписать рядом имя сотрудника, который получает самую большую зарплату в industry ------
----- without window functions -----
WITH max_salary AS (
    SELECT 
        industry,
        MAX(salary) AS max_sal
    FROM salary 
    GROUP BY industry
), 
highest_paid_employee AS (
    SELECT s.industry, 
        first_name AS name_highest_sal
    FROM salary s 
    INNER JOIN max_salary ms ON ms.max_sal = s.salary and ms.industry = s.industry
)
SELECT 
    s.first_name,
    s.last_name,
    s.salary,
    s.industry,
    h.name_highest_sal
FROM 
    salary s
LEFT JOIN 
    highest_paid_employee h ON s.industry = h.industry
ORDER BY 
    s.industry; 

----- with window functions -----
SELECT 
    first_name,
    last_name,
    salary,
    industry,
	FIRST_VALUE(first_name) OVER (PARTITION BY industry ORDER BY salary DESC) AS name_highest_sal
FROM salary
ORDER BY industry; 


            ----- Если в выводе нужно вывести только сотрудников, которые получают самую большую зарплату в industry ------
----- without window functions -----
WITH max_salary AS (
    SELECT 
       industry,
       MAX(salary) AS max_sal
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
INNER JOIN max_salary ms ON ms.max_sal = s.salary AND ms.industry = s.industry
ORDER BY s.industry;

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
