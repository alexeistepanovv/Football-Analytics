-- Few simple queries to get familiar with data

-- Number of Games Played Each Season 2014-2022
SELECT season, COUNT(*) AS total_games
FROM football_players.games
GROUP BY season;

-- Average goals per game
SELECT AVG(home_club_goals + away_club_goals) AS avg_goals_per_game
FROM football_players.games;

-- Distribution of Players' Ages
SELECT age, COUNT(*) AS number_of_players
FROM football_players.players
GROUP BY age
ORDER BY age;

-- Average player market value
SELECT ROUND(AVG(market_value_in_eur) / 1000000, 3) || 'M' AS avg_market_value_millions
FROM football_players.players;

-- Highest average attendance by club
SELECT c.name, AVG(g.attendance) AS avg_attendance
FROM football_players.games g
JOIN football_players.clubs c ON g.home_club_id = c.club_id
GROUP BY c.name
ORDER BY avg_attendance DESC
LIMIT 10;

-- Top payed football players
SELECT name, market_value_in_eur
FROM football_players.players
ORDER BY market_value_in_eur DESC
LIMIT 10;

SELECT country_of_citizenship, COUNT(*) AS number_of_players
FROM football_players.players
GROUP BY country_of_citizenship
ORDER BY number_of_players DESC
LIMIT 10;

-- Analysis question 1. How does age affects players performance and value?
SELECT age, ROUND(AVG(market_value_in_eur) / 1000000, 4) AS avg_market_value_millions
FROM football_players.players
GROUP BY age
ORDER BY age;

SELECT
    p.current_club_domestic_competition_id AS league_id,
    AVG(p.age) AS average_age,
    AVG(a.goals) AS average_goals,
    AVG(a.assists) AS average_assists
FROM football_players.players p
JOIN football_players.appearances a ON p.player_id = a.player_id
GROUP BY p.current_club_domestic_competition_id, p.age;

-- Average Goals by Age Groups and League
SELECT
    p.current_club_domestic_competition_id AS league_id,
    CASE
        WHEN p.age BETWEEN 18 AND 21 THEN '18-21'
        WHEN p.age BETWEEN 22 AND 25 THEN '22-25'
        WHEN p.age BETWEEN 26 AND 29 THEN '26-29'
        WHEN p.age BETWEEN 30 AND 33 THEN '30-33'
        WHEN p.age BETWEEN 34 AND 37 THEN '34-37'
        ELSE '38+'
    END AS age_group,
    ROUND(AVG(a.goals), 3) AS average_goals
FROM football_players.players p
JOIN football_players.appearances a ON p.player_id = a.player_id
GROUP BY league_id, age_group;

-- Average Assists by Age Groups and League
SELECT
    p.current_club_domestic_competition_id AS league_id,
    CASE
        WHEN p.age BETWEEN 18 AND 21 THEN '18-21'
        WHEN p.age BETWEEN 22 AND 25 THEN '22-25'
        WHEN p.age BETWEEN 26 AND 29 THEN '26-29'
        WHEN p.age BETWEEN 30 AND 33 THEN '30-33'
        WHEN p.age BETWEEN 34 AND 37 THEN '34-37'
        ELSE '38+'
    END AS age_group,
    AVG(a.assists) AS average_assists
FROM football_players.players p
JOIN football_players.appearances a ON p.player_id = a.player_id
GROUP BY league_id, age_group;