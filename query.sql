-- List all the player and their scores

SELECT 
    players.name AS player_name,
    games.title AS game_title,
    scores.score
FROM scores
INNER JOIN players ON scores.player_id = players.id
INNER JOIN games ON scores.game_id = games.id;


--  Find High Scorers 

SELECT 
    players.name,
    SUM(scores.score) AS total_score
FROM scores
JOIN players ON scores.player_id = players.id
GROUP BY players.name
ORDER BY total_score DESC
LIMIT 3;

--  Players Who Didn’t Play Any Games 

SELECT 
    players.name
FROM players
LEFT JOIN scores ON players.id = scores.player_id
WHERE scores.id IS NULL;


-- Find Popular Game Genres 

SELECT 
    games.genre,
    COUNT(scores.id) AS times_played
FROM scores
INNER JOIN games ON scores.game_id = games.id
GROUP BY games.genre
ORDER BY times_played DESC;


-- : Recently Joined Players 

SELECT 
    name, 
    join_date
FROM players
WHERE join_date >= CURRENT_DATE - INTERVAL '30 days';



-- Bonus Task: Players' Favorite Games  

SELECT 
    p.name AS player_name,
    g.title AS game_title,
    COUNT(s.id) AS times_played
FROM scores s
JOIN players p ON s.player_id = p.id
JOIN games g ON s.game_id = g.id
GROUP BY p.id, p.name, g.id, g.title
HAVING COUNT(s.id) = (
    SELECT MAX(game_count)
    FROM (
        SELECT COUNT(*) AS game_count
        FROM scores
        WHERE player_id = p.id
        GROUP BY game_id
    ) AS sub
);
