-- 						Interogari BD Chinook - IE si SPE:
--
-- SQL 03: Operatori ansamblisti (UNION, INTERSECT, EXCEPT)
--
-- ultima actualizare: 2019-04-14




-- ############################################################################ 
-- 									UNION
-- ############################################################################ 

-- ############################################################################ 
-- 			Care sunt piesele care apar pe doua discuri ale formatiei 
-- 				'Iron Maiden', `Fear Of The Dark` si `A Real Live One`
-- ############################################################################ 

-- solutie bazata pe OR (dubluri neeliminate)
SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND (title = 'Fear Of The Dark' 
	OR title = 'A Real Live One')
ORDER BY 1

-- solutie bazata pe OR (dubluri eliminate)
SELECT DISTINCT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND (title = 'Fear Of The Dark' 
	OR title = 'A Real Live One')
ORDER BY 1




-- solutie bazata pe UNION (dubluri eliminate)
SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark' 
UNION
SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'A Real Live One'
ORDER BY 1




-- ############################################################################ 
-- 									INTERSECT
-- ############################################################################ 

-- ############################################################################ 
-- 			Care sunt piesele comune (cu acelasi titlu) de pe 
-- 			albumele `Fear Of The Dark` si `A Real Live One`
-- 					ale formatiei 'Iron Maiden'
-- ############################################################################ 

-- solutie ERONATA 1 !!!
SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark' 
	AND title = 'A Real Live One'
-- nicio linie!!!


-- solutie ERONATA 2 !!!
SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND (title = 'Fear Of The Dark' 
	OR title = 'A Real Live One')
-- extrage solutie extrage, de fapt, piesele de pe ambele albume,
-- nu piesele comune!!!



-- solutie corecta bazata pe intersect
SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark'	
INTERSECT
SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'A Real Live One'	


-- solutie bazata de auto-join 
SELECT track1.name
FROM artist artist1
	INNER JOIN album album1 ON artist1.artistid = album1.artistid
	  	AND artist1.name = 'Iron Maiden' AND album1.title = 'Fear Of The Dark'
	INNER JOIN track track1 ON album1.albumid = track1.albumid
	INNER JOIN track track2 ON track1.name = track2.name -- AICI E AUTOJONCTIUNEA
	INNER JOIN album album2 ON track2.albumid = album2.albumid	
		AND album2.title = 'A Real Live One'
	INNER JOIN artist artist2 ON album2.artistid = artist2.artistid 
		AND artist2.name = 'Iron Maiden'


-- ############################################################################ 
-- 									EXCEPT
-- ############################################################################ 

-- ############################################################################ 
-- Care sunt piesele formatiei 'Iron Maiden' de pe albumul `Fear Of The Dark` 
-- 				care NU apar si pe albumul `A Real Live One`
-- ############################################################################ 

SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark'	
EXCEPT
SELECT track.name
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'A Real Live One'	



-- ############################################################################ 
-- 						Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################ 


-- Afisare piesele (si artistii) comune playlisturilor `Heavy Metal Classic` si `Music`

-- Care sunt piesele formatiei `Led Zeppelin` compuse numai de `Robert Plant`

-- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
--  `Jimmy Page`, cu sau fara alti colegi/muzicieni?

-- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
--  `Jimmy Page`, fara alti colegi/muzicieni?

-- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
--	`Robert Plant` 

-- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
--	nici `Robert Plant`, nici `Jimmy Page` 


-- Care sunt subordonatii de ordinul 1 si 2 ai angatului .....?




-- ############################################################################ 
-- 						La ce intrebari raspund urmatoarele interogari ?
-- ############################################################################ 

