--Write your MySQL query statement below
SELECT
ROUND(SQRT(POW(p2.x-p1.x,2)+POW(p2.y-p1.y,2)),2) as shortest
FROM Point2d p1,Point2d p2
WHERE p1.x != p2.x OR p1.y != p2.y
ORDER BY shortest
LIMIT 1

-- Using min
SELECT
ROUND(MIN(SQRT(POW(p2.x-p1.x,2)+POW(p2.y-p1.y,2))),2) as shortest
FROM Point2d p1,Point2d p2
WHERE p1.x != p2.x OR p1.y != p2.y

-- reduce total number of comparisons (reduce duplicate computations)
SELECT
ROUND(MIN(SQRT(POW(p2.x-p1.x,2)+POW(p2.y-p1.y,2))),2) as shortest
FROM Point2d p1,Point2d p2
WHERE 
(p1.x <= p2.x AND p1.y < p2.y) 
OR
(p1.x <= p2.x AND p1.y > p2.y)
OR 
(p1.x > p2.x AND p1.y = p2.y)  