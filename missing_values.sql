-- Filling dates and player names with "unknown" in appearances table
UPDATE football_players.appearances
SET date = COALESCE(date, '1900-01-01'),
    player_name = COALESCE(player_name, 'Unknown');

-- Filling manager names with "unknown" in club_games table
UPDATE football_players.club_games
SET own_manager_name = COALESCE(own_manager_name, 'unknown'),
    opponent_manager_name = COALESCE(opponent_manager_name, 'unknown');

-- Handling missing data in clubs table

-- Calculating foreigners percentage where possible
UPDATE football_players.clubs
SET foreigners_percentage = CASE
    WHEN squad_size > 0 THEN (foreigners_number::FLOAT / squad_size) * 100
    ELSE 0
END;

-- Adding 'age' column to players table
ALTER TABLE football_players.players
ADD COLUMN age INT;
UPDATE football_players.players
SET age = EXTRACT(YEAR FROM age(CURRENT_DATE, date_of_birth));

-- Imputing average age for each club based on players' ages
UPDATE football_players.clubs AS c
SET average_age = subq.avg_age
FROM (
    SELECT p.current_club_id, AVG(p.age) AS avg_age
    FROM football_players.players AS p
    GROUP BY p.current_club_id
) AS subq
WHERE c.club_id = subq.current_club_id;

-- Removing the 'total_market_value' column
-- ALTER TABLE football_players.clubs
-- DROP COLUMN total_market_value;

-- Filling country names and domestic league codes in competitions table
UPDATE football_players.competitions
SET
    country_name = COALESCE(country_name, 'international competition'),
    domestic_league_code = COALESCE(domestic_league_code, 'international competition')
WHERE country_id = -1;

-- Filling games table
UPDATE football_players.games
SET home_club_manager_name = COALESCE(home_club_manager_name, 'unknown'),
    away_club_manager_name = COALESCE(away_club_manager_name, 'unknown'),
    home_club_name = COALESCE(home_club_name, 'unknown'),
    away_club_name = COALESCE(away_club_name, 'unknown');

-- Imputing missing attendance values using the mean attendance for each club, or 0 if there is no data
WITH club_attendance AS (
    SELECT
        home_club_id,
        AVG(attendance) AS avg_attendance
    FROM
        football_players.games
    WHERE
        attendance IS NOT NULL
    GROUP BY
        home_club_id
)
UPDATE football_players.games AS g
SET attendance = COALESCE(g.attendance, ca.avg_attendance::INT, 0)
FROM club_attendance AS ca
WHERE g.home_club_id = ca.home_club_id AND g.attendance IS NULL;

UPDATE football_players.games
SET attendance = 0
WHERE attendance IS NULL;

-- Removing the 'player_in_id' column
ALTER TABLE football_players.game_events
DROP COLUMN player_in_id;

-- Players table

-- First Name. If missing, replace with "Unknown".
UPDATE football_players.players
SET first_name = COALESCE(first_name, 'unknown');

-- Date of Birth. If missing, replace with a placeholder date or leave as null.
UPDATE football_players.players
SET date_of_birth = COALESCE(date_of_birth, '1900-01-01');

-- Sub Position. If missing, replace with "Unknown Position".
UPDATE football_players.players
SET sub_position = COALESCE(sub_position, 'unknown position');

-- Foot. If missing, replace with "Unknown".
UPDATE football_players.players
SET foot = COALESCE(foot, 'unknown');

-- Height in cm. Replace missing values with the average height.
UPDATE football_players.players
SET height_in_cm = COALESCE(height_in_cm, (SELECT AVG(height_in_cm) FROM football_players.players WHERE height_in_cm IS NOT NULL));

-- Market Value and Highest Market Value in EUR. Replace missing values with 0 or average values.
UPDATE football_players.players
SET
    market_value_in_eur = COALESCE(market_value_in_eur, 0),
    highest_market_value_in_eur = COALESCE(highest_market_value_in_eur, 0);

-- Contract Expiration Date. If missing, replace with a far future date.
UPDATE football_players.players
SET contract_expiration_date = COALESCE(contract_expiration_date, '9999-12-31');


-- Checking missing values in imported tables
-- Here selected only columns with missing values after importing data to tables

SELECT
    COUNT(*) - COUNT(date) AS null_date,
    COUNT(*) - COUNT(player_name) AS null_player_name
FROM football_players.appearances;

SELECT
    COUNT(*) - COUNT(own_manager_name) AS null_own_manager_name,
    COUNT(*) - COUNT(opponent_manager_name) AS null_opponent_manager_name
FROM football_players.club_games;

SELECT
    COUNT(*) - COUNT(average_age) AS null_average_age,
    COUNT(*) - COUNT(foreigners_percentage) AS null_foreigners_percentage
FROM football_players.clubs;

SELECT
    COUNT(*) - COUNT(country_name) AS null_country_name,
    COUNT(*) - COUNT(domestic_league_code) AS null_domestic_league_code
FROM football_players.competitions;

SELECT
    COUNT(*) - COUNT(home_club_manager_name) AS null_home_club_manager_name,
    COUNT(*) - COUNT(away_club_manager_name) AS null_away_club_manager_name,
    COUNT(*) - COUNT(attendance) AS null_attendance,
    COUNT(*) - COUNT(home_club_name) AS null_home_club_name,
    COUNT(*) - COUNT(away_club_name) AS null_away_club_name
FROM football_players.games;

SELECT
    COUNT(*) - COUNT(first_name) AS null_first_name,
    COUNT(*) - COUNT(date_of_birth) AS null_date_of_birth,
    COUNT(*) - COUNT(sub_position) AS null_sub_position,
    COUNT(*) - COUNT(foot) AS null_foot,
    COUNT(*) - COUNT(height_in_cm) AS null_height_in_cm,
    COUNT(*) - COUNT(market_value_in_eur) AS null_market_value_in_eur,
    COUNT(*) - COUNT(highest_market_value_in_eur) AS null_highest_market_value_in_eur,
    COUNT(*) - COUNT(contract_expiration_date) AS null_contract_expiration_date
FROM football_players.players;

SELECT
    COUNT(*) - COUNT(first_name) AS null_first_name,
    COUNT(*) - COUNT(date_of_birth) AS null_date_of_birth,
    COUNT(*) - COUNT(sub_position) AS null_sub_position,
    COUNT(*) - COUNT(foot) AS null_foot,
    COUNT(*) - COUNT(height_in_cm) AS null_height_in_cm,
    COUNT(*) - COUNT(market_value_in_eur) AS null_market_value_in_eur,
    COUNT(*) - COUNT(highest_market_value_in_eur) AS null_highest_market_value_in_eur,
    COUNT(*) - COUNT(contract_expiration_date) AS null_contract_expiration_date
FROM football_players.players;

