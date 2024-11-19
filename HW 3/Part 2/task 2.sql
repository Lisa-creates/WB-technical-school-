----- Если не нужна ещё аггрегация по городу ------
SELECT 
	DISTINCT(s."DATE") AS date_ 
    , "CITY" As CITY 
    , SUM("QTY") OVER (PARTITION by s."DATE") / SUM("QTY") OVER ()::FLOAT AS SUM_SALES_REL 
FROM sales s 
LEFT JOIN goods g ON g."ID_GOOD" = s."ID_GOOD" 
LEFT JOIN shops sh ON sh."SHOPNUMBER" = s."SHOPNUMBER"
WHERE g."CATEGORY" = 'ЧИСТОТА' 
ORDER BY s."DATE" 

----- Если нужна дополнительная аггрегация по городу ------
SELECT 
	DISTINCT(s."DATE") AS date_ 
    , "CITY" As CITY 
    , SUM("QTY") OVER (PARTITION by s."DATE", "CITY") / SUM("QTY") OVER ()::FLOAT AS SUM_SALES_REL 
FROM sales s 
LEFT JOIN goods g ON g."ID_GOOD" = s."ID_GOOD" 
LEFT JOIN shops sh ON sh."SHOPNUMBER" = s."SHOPNUMBER"
WHERE g."CATEGORY" = 'ЧИСТОТА' 
ORDER BY s."DATE" 
