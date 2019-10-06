1. Create a database
CREATE TABLE Director (
Id int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(MAX),
LastName nvarchar(MAX),
Nationality nvarchar(MAX),
BirhDate date
);

--2. Create a table called Director with following columns: FirstName, LastName, Nationality and Birth date. Insert 5 rows into it.
INSERT INTO Director
VALUES
('Director','1','Romania','1990-01-11'),
('Director','2','Spania','1991-02-22'),
('Director','3','Angola','1992-03-05'),
('Director','4','Suedia','1993-04-14'),
('Director','5','mexic','1994-05-10');

--3. Delete the director with id = 3
DELETE FROM Director WHERE Id=3

--4. Create a table called Movie with following columns: DirectorId, Title, ReleaseDate, Rating and Duration. Each movie has a director. Insert some rows into it
CREATE TABLE Movie (
DirectorId int IDENTITY(1,1) PRIMARY KEY,
Title nvarchar(MAX),
ReleaseDate Date,
Rating int,
Duration time
);

INSERT INTO Movie
VALUES
('MovieONE','1990-01-11','5','1:05:50'),
('MovieTwo','1991-02-22','6','5:07:22'),
('MovieThree','1992-03-05','7','4:24:55'),
('MovieFour','1993-04-14', '8','3:23:33'),
('MovieFive','1994-05-10','9','2:55:50');

--5. Update all movies that have a rating lower than 10.
UPDATE Movie SET Title='ArtificiallyUpdated' WHERE Rating<10;

Select * from Movie
--6. Create a table called Actor with following columns: FirstName, LastName, Nationality, Birth date and PopularityRating. Insert some rows into it.
CREATE TABLE Actor (
ActorId int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(MAX),
LastName nvarchar(MAX),
Nationality nvarchar(MAX),
BirhDate date,
PopularityRating int
);

INSERT INTO Actor
VALUES
('Actor','1','Romania','1990-01-11','1'),
('Actor','2','Spania','1991-02-22','2'),
('Actor','3','Angola','1992-03-05','3')

--7. Which is the movie with the lowest rating?
SELECT MIN(Rating) AS SmallestRating FROM Movie;

--8. Which director has the most movies directed?
SELECT MAX(Id) AS MostMovieDirected FROM Director;

--9. Display all movies ordered by director's LastName in ascending order, then by birth date descending.
SELECT * FROM Director ORDER BY LastName ASC;
SELECT * FROM Director ORDER BY BirthDate DESC;

--12. Create a stored procedure that will increment the rating by 1 for a given movie id.
UPDATE Movie SET Rating = Rating + 1 WHERE DirectorId=6;

15. Implement many to many relationship between Movie and Actor
CREATE TABLE MovieActor (
	DirectorId int CONSTRAINT fk_director REFERENCES Director(Id),
	ActorId int CONSTRAINT fk_actor REFERENCES Actor(Id)
);

INSERT INTO MovieActor(MovieId,ActorId) VALUES(1,5);
SELECT * FROM Actor;

--16. Implement many to many relationship between Movie and Genre
CREATE TABLE Genre(
	Id int IDENTITY(1,1) PRIMARY KEY,
	Name VARCHAR(MAX) NOT NULL
);
select * from Genre
CREATE TABLE MovieGenre(
	MovieId int CONSTRAINT fk_movieId REFERENCES Movie(Id),
	GenreId int CONSTRAINT fk_genreId REFERENCES Genre(Id)
);

INSERT INTO Genre(GenreName) VALUES('Horror');
INSERT INTO Genre(GenreName) VALUES('Action');
SELECT * FROM Genre;

INSERT INTO MovieGenre(MovieId,GenreId) VALUES(2,1);
INSERT INTO MovieGenre(MovieId,GenreId) VALUES(5,2);
INSERT INTO MovieGenre(MovieId,GenreId) VALUES(1,2);

.--17. Which actor has worked with the most distinct movie directors?
SELECT A.ActorId, COUNT(d.Id) AS NoOfDirs
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m ON ma.MovieId =m.DirectorId INNER JOIN 
Director d ON m.DirectorId=d.Id GROUP BY A.ActorId
HAVING COUNT(d.Id) >= (SELECT COUNT(d.Id) AS NoOfDirs
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m ON ma.MovieId =m.DirectorId INNER JOIN 
Director d ON m.DirectorId=d.Id GROUP BY A.ActorId)

--18. Which is the preferred genre of each actor?
SELECT A.FirstName, A.LastName,g.GenreName
FROM Actor A INNER JOIN MovieActor ma ON A.ActorId=ma.ActorId INNER JOIN Movie m 
ON ma.MovieId =m.DirectorId INNER JOIN MovieGenre mg ON m.DirectorId=mg.MovieId INNER JOIN Genre g ON mg.GenreId=g.GenreID


