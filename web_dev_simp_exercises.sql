/* Completing the SQL/MySQL Exercises from the Web Dev Simplified channel in this repo: https://github.com/WebDevSimplified/Learn-SQL/blob/master/README.md */


/*-------------------- Exercise 1 - Create a 'Songs' Tables --------------------*/
/*
The table should be called "songs" and have the following 4 properties: id, name, 
length, album_id.
*/

-- Executing the previous code from the tutorial in order establish the DB with 
-- the necessary table info.

USE RECORD_COMPANY;
CREATE TABLE bands (
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE albums(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL, 
    release_year INT, 
    band_id INT NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY (band_id) REFERENCES bands(id)
);


/*-------------------- Exercise 1 - Create a 'Songs' Tables --------------------*/
CREATE TABLE songs(
	id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    length FLOAT NOT NULL,
    album_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (album_id) REFERENCES albums(id)
);


/*-------------------- Exercise 2 - Select only Band Names --------------------*/
-- Column name should be returned as 'Band Name'
Select name AS 'BAND NAME'
FROM bands;


/*-------------------- Exercise 3 - Identify the Oldest Album--------------------*/
SELECT 
	id,name,release_year,band_id
FROM albums WHERE release_year = (SELECT MIN(release_year) FROM albums);
    
-- The above query will return ALL row with the min value and also excludes any null. 
-- An alternative is shown below where we sort by ascending and limit the return to 1.
-- -- Doesn't address multiple minimum values
SELECT * FROM albums WHERE release_year IS NOT NULL
ORDER BY release_year
LIMIT 1;


/*-------------------- Exercise 4 - Get All Bands that Have Albums--------------------*/
SELECT DISTINCT bands.name AS 'Band Name'
FROM bands
JOIN albums ON bands.id = albums.band_id;
-- DISTINCT returns only different values for the bands.name path.
-- We indicate it's on the bands table, and join where the albums match
-- on the bands table


/*-------------------- Exercise 5 - Get All Bands that Have NO Albums--------------------*/
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
-- Had to execute above line to address setting that was causing errors

SELECT DISTINCT bands.name AS 'Band Name'
FROM bands
LEFT JOIN albums ON bands.id = albums.band_id
GROUP BY albums.band_id
HAVING COUNT(albums.id) = 0
;

/*-------------------- Exercise 6 - Get the Longest Album--------------------*/
SELECT
	name AS 'name',release_year as 'RELEASE YEAR', length AS 'Duration'
FROM albums Where length = (SELECT MAX(length) FROM albums);


SELECT
	name AS 'name',release_year as 'RELEASE YEAR', length AS 'Duration'
    FROM songs Where length = (SELECT MAX(length) FROM albums);

