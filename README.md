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

##  find which country has highest and lowest movie make
SELECT
    PRODUCTION_COUNTRIES,
    COUNT(*) AS movie_count
FROM
    netflix
WHERE
    PRODUCTION_COUNTRIES
 IS NOT NULL
GROUP BY
    PRODUCTION_COUNTRIES

ORDER BY
    movie_count DESC
LIMIT 1; -- for the highest

SELECT
    PRODUCTION_COUNTRIES,
    COUNT(*) AS movie_count
FROM
    netflix
WHERE
    PRODUCTION_COUNTRIES
 IS NOT NULL
GROUP BY
    PRODUCTION_COUNTRIES

ORDER BY
    movie_count ASC
LIMIT 1; -- for the lowest

## Find the average rating for the movie that belongs to multiple genres

select GENRE,avg(IMDB_SCORE)   from netflix   
group  by GENRE order by avg(IMDB_SCORE) desc;


## categorise the genre according to age certification

select  
case 
when AGE_CERTIFICATION <="PG"  then "children"
when AGE_CERTIFICATION <="PG-13"  then "Teen"
when AGE_CERTIFICATION  IN("R","TV-G","TV-Y","TV-PG","TV-14")  then "Adult" 
else "Unknown"
end as age_category ,genre ,count(*) as Genre_count from netflix group by AGE_CERTIFICATION,genre;



