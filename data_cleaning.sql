-- Check for duplicates
SELECT *, COUNT(*)
FROM football_players.appearances
GROUP BY appearance_id, game_id, player_id, player_club_id, player_current_club_id, date,
         player_name, competition_id, yellow_cards, red_cards, goals, assists, minutes_played
HAVING COUNT(*) > 1;
-- Checking data consistency
SELECT a.*
FROM football_players.appearances a
LEFT JOIN football_players.players p ON a.player_id = p.player_id
WHERE p.player_id IS NULL;

SELECT a.*
FROM football_players.appearances a
LEFT JOIN football_players.games g ON a.game_id = g.game_id
WHERE g.game_id IS NULL;

SELECT a.*
FROM football_players.appearances a
LEFT JOIN football_players.clubs c ON a.player_club_id = c.club_id
WHERE c.club_id IS NULL;

SELECT a.*
FROM football_players.appearances a
LEFT JOIN football_players.competitions comp ON a.competition_id = comp.competition_id
WHERE comp.competition_id IS NULL;

-- Deleting appearances without corresponding 'player_id' in players, 'game_id' in games
-- and 'player_club_id' in clubs. There is no inconsistencies in competition_id with competition table

DELETE FROM football_players.appearances a
WHERE NOT EXISTS (
    SELECT 1 FROM football_players.players p
    WHERE a.player_id = p.player_id
);

DELETE FROM football_players.appearances a
WHERE NOT EXISTS (
    SELECT 1 FROM football_players.games g
    WHERE a.game_id = g.game_id
);

DELETE FROM football_players.appearances a
WHERE NOT EXISTS (
    SELECT 1 FROM football_players.clubs c
    WHERE a.player_club_id = c.club_id
);

-- Checking game_id consistency
SELECT cg.*
FROM football_players.club_games cg
LEFT JOIN football_players.games g ON cg.game_id = g.game_id
WHERE g.game_id IS NULL;
