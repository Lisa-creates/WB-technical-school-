CREATE TABLE query (
    searchid SERIAL PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    userid INT,
    ts BIGINT, -- Время в формате Unix
    devicetype VARCHAR(50),
    deviceid VARCHAR(50),
    query VARCHAR(255)
); 

INSERT INTO query (year, month, day, userid, ts, devicetype, deviceid, query) VALUES
(2024, 11, 16, 1, 1700000300, 'android', 'dev1', 'купить телефон'),
(2024, 11, 16, 1, 1700000360, 'android', 'dev1', 'телефон samsung'),
(2024, 11, 16, 1, 1700000900, 'android', 'dev1', 'samsung galaxy'),

(2024, 11, 16, 2, 1700000500, 'ios', 'dev2', 'куртка зимняя'),
(2024, 11, 16, 2, 1700000800, 'ios', 'dev7', 'зимняя куртка недорого'),

(2024, 11, 16, 3, 1700001900, 'android', 'dev3', 'купить о'),
(2024, 11, 16, 3, 1700002500, 'android', 'dev3', 'купить одея'),
(2024, 11, 16, 3, 1700002561, 'android', 'dev3', 'купить одеяло'),

(2024, 11, 16, 4, 1700000000, 'ios', 'dev4', 'купить ноутбук'),
(2024, 11, 16, 4, 1700000060, 'ios', 'dev4', 'ноутбук для работы'),
(2024, 11, 16, 4, 1700000120, 'ios', 'dev6', 'ноутбук hp'),

(2024, 11, 18, 5, 1700000600, 'android', 'dev5', 'смартф');



WITH query_data AS (
    SELECT 
        *,
        LEAD(ts) OVER (PARTITION BY userid, deviceid ORDER BY ts) AS next_ts,
        LEAD(query) OVER (PARTITION BY userid, deviceid ORDER BY ts) AS next_query,
        LENGTH(query) AS query_len,
        LEAD(LENGTH(query)) OVER (PARTITION BY userid, deviceid ORDER BY ts) AS next_query_len
    FROM query
)

SELECT 
        year, 
        month, 
        day, 
        userid, 
        ts, 
        next_ts, 
        devicetype, 
        deviceid, 
        query,
        next_query,
        CASE 
            WHEN next_ts IS NULL THEN 1 
            WHEN (next_ts - ts) > 60 AND next_query_len < query_len THEN 2 
            WHEN (next_ts - ts) > 180 THEN 1 
            ELSE 0
        END AS is_final
    FROM query_data
 WHERE devicetype = 'android' 
AND CASE 
         WHEN next_ts IS NULL THEN 1 
         WHEN (next_ts - ts) > 60 AND next_query_len < query_len THEN 2 -- Следующий запрос короче + > 1 минуты
         WHEN (next_ts - ts) > 180 THEN 1 
         ELSE 0
         END IN (1, 2) 
 AND year = 2024 AND month = 11 AND day = 16;
