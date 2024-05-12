WITH CTE AS (SELECT customer_id, YEAR(order_date) as 'year', 
SUM(price) as price FROM Orders
GROUP BY customer_id,year
ORDER BY customer_id,year)

SELECT c1.customer_id FROM CTE c1
LEFT JOIN CTE c2
ON c1.customer_id = c2.customer_id
AND c1.year + 1 = c2.year 
AND c2.price > c1.price
GROUP BY c1.customer_id
HAVING COUNT(*) - COUNT(c2.customer_id) = 1