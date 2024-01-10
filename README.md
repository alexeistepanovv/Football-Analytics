# Football Analytics
## Analytics of Football Data (SQL)

**Table of Contents**
- [Dataset Overview](#dataset-overview)
- [Content Details](#content-details)
- [Data Structure and Relationships](#data-structure-and-relationships)

## Dataset Overview
- **Name**: Football Data: Competitions, Clubs, Players Statistics
- **Source**: Transfermarkt and other reliable football statistics sources
- **Update Frequency**: Weekly
- **Data Collection Method**: Python-based web scraper, SQL database management, GitHub for version control and collaboration
- **User Interaction**: Open discussions for improvements and bug fixes encouraged via the GitHub issues section

## Content Details
### Games Data:
- Over 60,000 games from multiple seasons across major global competitions.
- Detailed performance metrics and benchmarks for over 400 clubs.

### Clubs Data:
- High-profile competition participation.
- Club-specific performance data.

### Players Data:
- Statistics for more than 30,000 players from top-notch clubs.
- Attributes include physical characteristics, team affiliations, and contract statuses.
- Performance metrics such as goals scored, and assists provided.
- Historical and current market valuations, with over 400k records.

### Appearances Data:
- Approximately 1.2 million records detailing competition-level performance.
- Information on games played (linked to game_id), cards received (yellow_card), and more.

## Data Structure and Relationships
- **Files**: Structured CSV files with unique IDs allowing comprehensive relational data analysis.
  - `appearances`
  - `club_games`
  - `clubs`
  - `competitions`
  - `game_events`
  - `games`
  - `player_valuations`
  - `players`
