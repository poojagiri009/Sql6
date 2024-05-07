
-- Using IN
SELECT player_id, device_id FROM Activity a WHERE event_date IN (
    SELECT min(event_date) FROM Activity b WHERE a.player_id=b.player_id
)

--Using equality operator instead of IN - time limit exceeded
SELECT player_id, device_id FROM Activity a WHERE event_date = (
    SELECT MIN(event_date) FROM Activity b WHERE a.player_id=b.player_id
)

-- Using RANK
WITH CTE AS(
    SELECT player_id,device_id, 
    RANK() OVER(PARTITION BY player_id ORDER BY event_date) as rnk
    FROM Activity
)

SELECT player_id,device_id FROM CTE
WHERE rnk = 1

-- USING FIRST_VALUE
SELECT DISTINCT player_id,FIRST_VALUE(device_id) 
OVER(PARTITION BY player_id ORDER BY event_date) as device_id
FROM Activity
	
	
--USING LAST VALUE
SELECT DISTINCT player_id,LAST_VALUE(device_id) 
OVER(PARTITION BY player_id ORDER BY event_date DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as device_id
FROM 
	
	
-- Using tuple IN
SELECT a1.player_id,a1.device_id FROM Activity a1 
WHERE (a1.player_id,a1.event_date) IN 
(SELECT a2.player_id,MIN(a2.event_date) FROM Activity a2
GROUP BY a2.player_id)

-- Using JOIN instead of IN
WITH CTE AS
(SELECT a2.player_id,MIN(a2.event_date) as event_date FROM Activity a2
GROUP BY a2.player_id)

SELECT a1.player_id,a1.device_id FROM Activity a1 
JOIN CTE c 
ON a1.player_id=c.player_id AND
a1.event_date = c.event_date
