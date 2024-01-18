-- Creating tables
CREATE TABLE football_players.clubs (
    club_id SERIAL PRIMARY KEY,
    club_code VARCHAR(255),
    name VARCHAR(255),
    domestic_competition_id VARCHAR(50),
    total_market_value VARCHAR(50),
    squad_size INT,
    average_age FLOAT,
    foreigners_number INT,
    foreigners_percentage FLOAT,
    national_team_players INT,
    stadium_name VARCHAR(255),
    stadium_seats INT,
    net_transfer_record VARCHAR(255),
    coach_name VARCHAR(255),
    last_season INT,
    url VARCHAR(500)
);

CREATE TABLE football_players.competitions(
    competition_id VARCHAR(50),
    competition_code VARCHAR(50),
    name VARCHAR(255),
    sub_type VARCHAR(255),
    type VARCHAR(255),
    country_id INT,
    country_name VARCHAR(50),
    domestic_league_code VARCHAR(50),
    confederation VARCHAR(50),
    url VARCHAR(500)
);

CREATE TABLE football_players.games (
    game_id SERIAL PRIMARY KEY,
    competition_id VARCHAR(50),
    season INT,
    round VARCHAR(50),
    date DATE,
    home_club_id INT NOT NULL,
    away_club_id INT NOT NULL,
    home_club_goals INT,
    away_club_goals INT,
    home_club_position INT,
    away_club_position INT,
    home_club_manager_name VARCHAR(255),
    away_club_manager_name VARCHAR(255),
    stadium VARCHAR(255),
    attendance INT,
    referee VARCHAR(255),
    url VARCHAR(255),
    home_club_name VARCHAR(255),
    away_club_name VARCHAR(255),
    aggregate VARCHAR(50),
    competition_type VARCHAR(50)
);

CREATE TABLE football_players.players (
    player_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    name VARCHAR(255),
    last_season INT,
    current_club_id INT,
    player_code VARCHAR(100),
    country_of_birth VARCHAR(100),
    city_of_birth VARCHAR(100),
    country_of_citizenship VARCHAR(100),
    date_of_birth DATE,
    sub_position VARCHAR(100),
    position VARCHAR(100),
    foot VARCHAR(50),
    height_in_cm INT,
    market_value_in_eur INT,
    highest_market_value_in_eur INT,
    contract_expiration_date DATE,
    agent_name VARCHAR(255),
    image_url TEXT,
    url TEXT,
    current_club_domestic_competition_id VARCHAR(50),
    current_club_name VARCHAR(255)
);

CREATE TABLE football_players.appearances (
    appearance_id VARCHAR(50) PRIMARY KEY,
    game_id INT NOT NULL,
    player_id INT NOT NULL,
    player_club_id INT,
    player_current_club_id INT,
    date DATE,
    player_name VARCHAR(255),
    competition_id VARCHAR(50) NOT NULL,
    yellow_cards INT DEFAULT 0 CHECK (yellow_cards >= 0 AND yellow_cards <= 2),
    red_cards INT DEFAULT 0 CHECK (red_cards >= 0 AND red_cards <= 1),
    goals INT DEFAULT 0 CHECK (goals >= 0),
    assists INT DEFAULT 0 CHECK (assists >= 0),
    minutes_played INT CHECK (minutes_played >= 0)
);

CREATE TABLE football_players.club_games (
    game_id INT NOT NULL,
    club_id INT NOT NULL,
    own_goals INT DEFAULT 0 CHECK (own_goals >= 0),
    own_position INT,
    own_manager_name VARCHAR(255),
    opponent_id INT NOT NULL,
    opponent_goals INT DEFAULT 0 CHECK (opponent_goals >= 0),
    opponent_position INT,
    opponent_manager_name VARCHAR(255),
    hosting VARCHAR(50),
    is_win INT CHECK (is_win IN (0, 1))
);

CREATE TABLE football_players.game_events(
    game_id INT NOT NULL,
    minute INT,
    type VARCHAR(50),
    club_id INT,
    player_id INT NOT NULL,
    description VARCHAR(255),
    player_in_id INT
);

CREATE TABLE football_players.player_market_values (
    player_id INT NOT NULL,
    last_season INT,
    datetime TIMESTAMP,
    date DATE,
    dateweek DATE,
    market_value_in_eur INT,
    n INT,
    current_club_id INT,
    player_club_domestic_competition_id VARCHAR(50),
    PRIMARY KEY (player_id, datetime)
);

-- Copying data from CSV files
COPY football_players.appearances FROM 'C:/Desktop/football_players_db/data/appearances.csv' WITH (FORMAT csv, HEADER true);
COPY football_players.club_games FROM 'C:/Desktop/football_players_db/data/club_games.csv' WITH (FORMAT csv, HEADER true);
COPY football_players.clubs FROM 'C:/Desktop/football_players_db/data/clubs.csv' WITH (FORMAT csv, HEADER true);
COPY football_players.competitions FROM 'C:/Desktop/football_players_db/data/competitions.csv' WITH (FORMAT csv, HEADER true);
COPY football_players.game_events FROM 'C:/Desktop/football_players_db/data/game_events.csv' WITH (FORMAT csv, HEADER true);
COPY football_players.games FROM 'C:/Desktop/football_players_db/data/games.csv' WITH (FORMAT csv, HEADER true);
COPY football_players.player_market_values FROM 'C:/Desktop/football_players_db/data/player_valuations.csv' WITH (FORMAT csv, HEADER true);
COPY football_players.players FROM 'C:/Desktop/football_players_db/data/players.csv' WITH (FORMAT csv, HEADER true);