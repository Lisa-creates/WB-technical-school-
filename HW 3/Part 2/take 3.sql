WITH count_ AS (
    SELECT
        "DATE",
        "SHOPNUMBER",
        "ID_GOOD",
        COUNT("ID_GOOD") OVER (PARTITION BY "SHOPNUMBER", "DATE", "ID_GOOD") AS count_product
    FROM sales 
), 
TOP AS (SELECT  
    "DATE",
    "SHOPNUMBER",
    "ID_GOOD",
    ROW_NUMBER() OVER (PARTITION BY "SHOPNUMBER", "DATE" ORDER BY count_product DESC) AS rn
FROM count_
)

SELECT  
    "DATE",
    "SHOPNUMBER",
    "ID_GOOD"
FROM TOP
WHERE rn <= 3 
