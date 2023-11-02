-- Creating a table for all the lines
CREATE TABLE gilmore_table (
    line_id INT(6) PRIMARY KEY,
    speaker VARCHAR(30),
    line VARCHAR(1500),
    season VARCHAR(1)
);
--

-- Loading the data into the table
LOAD DATA LOCAL INFILE 'C:\\Users\\tanya\\oneDrive\\Desktop\\Datasets\\Gilmore_Girls_Lines.csv' 
    INTO TABLE gilmore_girls.gilmore_table;
--

-- All the characters with lines
SELECT COUNT(DISTINCT speaker) FROM gilmore_table
    ORDER BY line_id;
--

UPDATE gilmore_table
    SET line = replace(line, '\((^))*\)', '');
--

-- Number of lines each character has
SELECT speaker, COUNT(*) AS num_lines FROM gilmore_table
    GROUP BY speaker
    ORDER BY num_lines DESC;
--

-- Number of lines each character has in season 5
SELECT speaker, COUNT(*) AS num_lines FROM gilmore_table
    WHERE season = '5'
    GROUP BY speaker
    ORDER BY num_lines DESC;
--

-- top speakers and coffee count
SELECT speaker, SUM(LENGTH(line) - LENGTH(replace(line, ' ', ''))+1) AS num_words,
    SUM((LENGTH(line) - LENGTH(REPLACE(line, "coffee", "")) ) / LENGTH("coffee")) AS num_coffee,
    SUM((LENGTH(line) - LENGTH(REPLACE(line, "coffee", "")) ) / LENGTH("coffee"))/COUNT(*)*100 AS coffee_coef
    FROM gilmore_table
    GROUP BY speaker
    ORDER BY num_words DESC;
--

-- Longest uninterrupted lines
SELECT speaker, line, LENGTH(line) - LENGTH(replace(line, ' ', ''))+1 AS num_words, season FROM gilmore_table
    ORDER BY num_words DESC
    LIMIT 10;
--

SELECT speaker, COUNT(*) AS num_lines, AVG(LENGTH(line) - LENGTH(replace(line, ' ', ''))+1) AS avg_words_per_line FROM gilmore_table
    GROUP BY speaker
    ORDER BY num_lines DESC
    LIMIT 100;
--

-- average number of words in a line for each character
SELECT speaker, SUM(LENGTH(line) - LENGTH(replace(line, ' ', ''))+1) num_words_all FROM gilmore_table
    GROUP BY speaker
    ORDER BY num_words DESC;
--


-- Data on Gilmore Girls in the IMDb
SELECT title_episode.tconst, title_episode.seasonNumber, title_episode.episodeNumber, title_ratings.averageRating, title_ratings.num_votes FROM title_episode
    JOIN title_ratings ON title_episode.tconst = title_ratings.tconst
    WHERE title_episode.parentTconst = "tt0238784"
    ORDER BY seasonNumber, episodeNumber;
--