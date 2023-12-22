# Portfolio-SQL
## Netflix Data Analysis
### Hello, and thanks for stopping by! This repository contains examples of SQL I've written for Netflix  project and while working through SQL . Feel free to take a look around and reach out if you have any feedback or questions
## Dataset:
Download Here:[https://docs.google.com/spreadsheets/d/1txPFMHAdkoFacDhFfIyCFqRSBKPF4Amn/edit#gid=1690928944]

### SQL Queries:

## List the top10 movies with highest average rating

select  TITLE , avg(IMDB_SCORE) as Avg_rating from netflix 
group by TITLE 
order by Avg_rating desc limit 10 ;

## calculate the percentage of movie that belongs to each genre in the database

SELECT
    genre,
    COUNT(*) AS total_movies,
    (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM netflix) AS percentage
FROM
    netflix
GROUP BY
    genre;

## Rank the movie and TV Series on the basis of IMDB Score

select TITLE,IMDB_SCORE, rank() over (order by IMDB_SCORE desc) as Ranking from netflix;

