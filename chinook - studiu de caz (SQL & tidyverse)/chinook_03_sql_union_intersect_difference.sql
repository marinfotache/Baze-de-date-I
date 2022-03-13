-- ############################################################################
-- Universitatea Al.I.Cuza Iași / Al.I.Cuza University of Iasi (Romania)
-- Facultatea de Economie si Administrarea Afacerilor / Faculty of
--          Economics and Business Administration
-- Colectivul de Informatică Economică / Dept. of Business Information Systems
-- ############################################################################

-- ############################################################################
--        Studiu de caz: Interogări SQL pentru baza de date `chinook`
--        Case study: SQL Queries for `chinook` database
-- ############################################################################
-- 					SQL03: Operatori ansamblisti (UNION, INTERSECT, EXCEPT)
-- 					SQL03: Ansemble operators: (UNION, INTERSECT, EXCEPT)
-- ############################################################################
-- ultima actualizare / last update: 2022-03-12



-- ############################################################################
--                                      UNION
-- ############################################################################

-- ############################################################################
-- 			Care sunt piesele care apar pe două discuri ale formației
-- 				'Iron Maiden', `Fear Of The Dark` și `A Real Live One`
-- ############################################################################
-- 			Extract the tracks included on two of the albums releases by
-- 				'Iron Maiden' - `Fear Of The Dark` and `A Real Live One`
-- ############################################################################


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


-- solutie bazata pe UNION ALL (dubluri ne-eliminate)
SELECT track.name
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark'
UNION ALL
SELECT track.name
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'A Real Live One'
ORDER BY 1



-- ############################################################################
-- Care sunt subordonatii de ordinul 1 (directi) si 2 (subordonatii directi ai
-- subordonatilor de ordinul 1) ai lui `Adams` (lastname) `Andrew` (firstname)
-- ############################################################################
-- Extract first-order and second-order subordinates of
--    `Adams` (lastname) `Andrew` (firstname)
-- ############################################################################

-- subordonatii de ordinul 1
SELECT subordonati1.*
FROM employee sefi
	INNER JOIN employee subordonati1 ON sefi.employeeid = subordonati1.reportsto
WHERE sefi.lastname = 'Adams' AND sefi.firstname = 'Andrew'
UNION
-- subordonatii de ordinul 2
SELECT subordonati2.*
FROM employee sefi
	INNER JOIN employee subordonati1 ON sefi.employeeid = subordonati1.reportsto
	INNER JOIN employee subordonati2 ON subordonati1.employeeid = subordonati2.reportsto
WHERE sefi.lastname = 'Adams' AND sefi.firstname = 'Andrew'



-- ############################################################################
--                                 INTERSECT
-- ############################################################################

-- ############################################################################
-- 			Care sunt piesele comune (cu acelasi titlu) de pe
-- 			albumele `Fear Of The Dark` si `A Real Live One`
-- 					ale formatiei 'Iron Maiden'
-- ############################################################################
-- 			Extract the tracks (track name) included on both `Fear Of The Dark` and
--  `A Real Live One` albums released by 'Iron Maiden' (the common tracks of
--      both albums)
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
--                                  EXCEPT
-- ############################################################################

-- ############################################################################
-- Care sunt piesele formatiei 'Iron Maiden' de pe albumul `Fear Of The Dark`
-- 				care NU apar si pe albumul `A Real Live One`
-- ############################################################################
-- Extract the tracks released by 'Iron Maiden' which were inluded on the
-- album `Fear Of The Dark` but not included on the album `A Real Live One`
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
-- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori,
--           nu apare nici `Robert Plant`, nici `Jimmy Page`
-- ############################################################################
-- Extract the tracks released by `Led Zeppelin` whose composers are neither
--           `Robert Plant` nor `Jimmy Page`
-- ############################################################################

-- sol 1
SELECT track.*
FROM track
	INNER JOIN album ON track.albumid = album.albumid
	INNER JOIN artist ON album.artistid = artist.artistid
WHERE artist.name = 'Led Zeppelin'
EXCEPT
SELECT track.*
FROM track
	INNER JOIN album ON track.albumid = album.albumid
	INNER JOIN artist ON album.artistid = artist.artistid
WHERE artist.name = 'Led Zeppelin' AND
	composer LIKE '%Page%'
EXCEPT
SELECT track.*
FROM track
	INNER JOIN album ON track.albumid = album.albumid
	INNER JOIN artist ON album.artistid = artist.artistid
WHERE artist.name = 'Led Zeppelin' AND
	composer LIKE '%Plant%'

	-- sol. 2
	SELECT track.*
	FROM track
		INNER JOIN album ON track.albumid = album.albumid
		INNER JOIN artist ON album.artistid = artist.artistid
	WHERE artist.name = 'Led Zeppelin'
	EXCEPT
	(SELECT track.*
	FROM track
		INNER JOIN album ON track.albumid = album.albumid
		INNER JOIN artist ON album.artistid = artist.artistid
	WHERE artist.name = 'Led Zeppelin' AND
		composer LIKE '%Page%'
	UNION
	SELECT track.*
	FROM track
		INNER JOIN album ON track.albumid = album.albumid
		INNER JOIN artist ON album.artistid = artist.artistid
	WHERE artist.name = 'Led Zeppelin' AND
		composer LIKE '%Plant%'
	)





-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
-- ############################################################################


-- Afisare piesele (si artistii) comune playlisturilor `Heavy Metal Classic` si `Music`
SELECT track.name AS track_name, artist.name AS artist_name
FROM track
	INNER JOIN album ON track.albumid = album.albumid
	INNER JOIN artist ON album.artistid = artist.artistid
	INNER JOIN playlisttrack ON track.trackid = playlisttrack.trackid
	INNER JOIN playlist ON playlisttrack.playlistid = playlist.playlistid
WHERE playlist.name = 'Heavy Metal Classic'
INTERSECT
SELECT track.name AS track_name, artist.name AS artist_name
FROM track
	INNER JOIN album ON track.albumid = album.albumid
	INNER JOIN artist ON album.artistid = artist.artistid
	INNER JOIN playlisttrack ON track.trackid = playlisttrack.trackid
	INNER JOIN playlist ON playlisttrack.playlistid = playlist.playlistid
WHERE playlist.name = 'Music'



-- Care sunt piesele formatiei `Led Zeppelin` compuse numai de `Robert Plant`

-- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
--  `Jimmy Page`, cu sau fara alti colegi/muzicieni?

-- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
--  `Jimmy Page`, fara alti colegi/muzicieni?

-- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
--	`Robert Plant`



-- ############################################################################
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
-- ############################################################################

-- (interogarile vor scrise "in direct", in timpul cursului)
