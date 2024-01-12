# Football Analytics
## Analytics of Football Data (SQL)

Hi! This project was created with three main goals in mind: firstly, to compile a dataset of football data suitable for potential machine learning projects; secondly, to reacquaint myself with football, a sport I've neglected in favor of watching the NBA for several years; and lastly, to practice and refine my SQL skills

## Source and Acknowledgment
This dataset was sourced from the work of David Cereijo. His comprehensive collection and organization of football data have been instrumental in the creation of this project. If you use this dataset in your research or projects, please credit him.
For more information and to explore the dataset, visit: [David Cereijo's Football Data on Data World](https://data.world/dcereijo).

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
