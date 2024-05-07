SELECT a1.player_id, a1.event_date, 
SUM(a1.games_played) OVER(PARTITION BY a1.player_id ORDER BY a1.event_date) AS games_played_so_far 
FROM Activity a1

-- Another way - gives time limit exceeded
SELECT a1.player_id,a1.event_date,
(SELECT SUM(a2.games_played) FROM Activity a2
WHERE a1.player_id=a2.player_id AND
a2.event_date <= a1.event_date) AS games_played_so_far FROM Activity a1

