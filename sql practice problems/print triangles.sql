
-- right angled triangle
WITH RECURSIVE pattern AS (
    SELECT 20 AS n
    UNION ALL
    SELECT n - 1
    FROM pattern
    WHERE n > 1
)
SELECT REPEAT('* ', n)
FROM pattern;

-- equilateral triangle

WITH RECURSIVE triangle AS (
    SELECT 1 AS row_num
    UNION ALL
    SELECT row_num + 1
    FROM triangle
    WHERE row_num < 5
)
SELECT 
    SPACE(5 - row_num) || REPEAT('* ', row_num) AS pattern
FROM 
    triangle;

