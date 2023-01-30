CREATE TABLE actor (
    act_id NUMBER(3) PRIMARY KEY,
    act_name VARCHAR2(20),
    act_gender CHAR(1)
);

CREATE TABLE director (
    dir_id NUMBER(3) PRIMARY KEY,
    dir_name VARCHAR2(20),
    dir_phone NUMBER (10)
);

CREATE TABLE movies (
    mov_id NUMBER(4) PRIMARY KEY,
    mov_title VARCHAR2(25),
    mov_year NUMBER(4),
    mov_lang VARCHAR2(12),
    dir_id REFERENCES director(dir_id)
);

CREATE TABLE movie_cast (
    act_id REFERENCES actor(act_id),
    mov_id REFERENCES movies(mov_id),
    role VARCHAR2(10)
);

CREATE TABLE rating (
    mov_id REFERENCES movies(mov_id),
    rev_stars VARCHAR2(25)
);

-- List the titles of all movies directed by 'Hitchcock'.

SELECT mov_title
  FROM movies
 WHERE dir_id
    IN (
        SELECT dir_id
          FROM director
         WHERE dir_name = 'hitchcock'
);

-- Find the movie names where one or more actors acted in two or more movies

SELECT mov_title
  FROM movies m, movie_cast c
 WHERE m.mov_id = c.mov_id
   AND act_id
    IN (
        SELECT act_id
          FROM movie_cast
      GROUP BY act_id
        HAVING COUNT(act_id) > 1
)
GROUP BY mov_title
  HAVING COUNT(*) > 1;

-- List all actors who acted in a movie before 2000 and also in a movie
-- after 2015 (use JOIN operation).

SELECT act_name, mov_title, mov_year
  FROM actor a
  JOIN movie_cast c
    ON a.act_id = c.act_id
  JOIN movies m
    ON c.mov_id = m.mov_id
 WHERE m.mov_year
 NOT BETWEEN 2000 AND 2015;

-- Find the title of movies and number of stars for each movie that has
-- at least one rating and find the highest number of stars that movie
-- received. Sort the result by movie title.

SELECT mov_title, MAX(rev_stars)
  FROM movies m, rating r
 WHERE m.mov_id = r.mov_id
   AND r.rev_stars
    IS NOT NULL
GROUP BY mov_title
ORDER BY mov_title;

-- Update rating of all movies directed by 'Steven Spielberg' to 5

UPDATE rating
   SET rev_stars = 5
 WHERE mov_id IN (
        SELECT mov_id FROM movies
         WHERE dir_id IN (
                SELECT dir_id FROM director
                 WHERE dir_name = 'steven spielberg'
        )
);