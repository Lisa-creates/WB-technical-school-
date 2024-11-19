        ----- Если в выводе нужно просто приписать рядом имя сотрудника, который получает самую большую зарплату в industry ------
----- Without window functions -------
WITH min_salary AS (
    SELECT 
        industry,
        MIN(salary) AS min_sal
    FROM salary 
    GROUP BY industry
), 
lowest_paid_employee AS (
    SELECT s.industry, 
        first_name AS name_lowest_sal
    FROM salary s 
    INNER JOIN min_salary ms ON ms.min_sal = s.salary and ms.industry = s.industry
)
SELECT 
    s.first_name,
    s.last_name,
    s.salary,
    s.industry,
    h.name_lowest_sal
FROM 
    salary s
LEFT JOIN 
    lowest_paid_employee h ON s.industry = h.industry
ORDER BY 
    s.industry; 

----- With window functions -------
SELECT 
    first_name,
    last_name,
    salary,
    industry,
	FIRST_VALUE(first_name) OVER (PARTITION BY industry ORDER BY salary ASC) AS name_lowest_sal 
FROM salary
ORDER BY industry; 

            ----- Если в выводе нужно вывести только сотрудников, которые получают самую большую зарплату в industry ------
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
