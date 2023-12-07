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
-- 			SQL08: Subconsultări (necorelate) în WHERE și HAVING.
--					 Diviziune relațională (1)
-- 		SQL08: (Non-correlated) subqueries included in WHERE and HAVING.
--					Relational division (1)
-- ############################################################################
-- ultima actualizare / last update: 2022-03-15


--
-- ############################################################################
--               Subconsultări (necorelate) în clauza WHERE
-- ############################################################################
--                    Uncorrelated subqueries in WHERE
-- ############################################################################



-- ############################################################################
--        Care sunt celelalte albume ale artistului sau formației care a
--                   lansat albumul `Houses of the Holy`
-- ############################################################################
--        List the other albums of the artist/band that released
--                     the album `Houses of the Holy`
-- ############################################################################


-- solutie bazata pe auto-jonctiune, care include albumul 'Houses Of The Holy'
SELECT album2.*, artist.name AS artist_name
FROM album album1
	INNER JOIN  artist ON album1.artistid = artist.artistid
		AND album1.title = 'Houses Of The Holy'
	INNER JOIN  album album2 ON album1.artistid = album2.artistid
ORDER BY 2


-- solutie bazata pe auto-jonctiune, care exclude albumul 'Houses Of The Holy'
SELECT album2.*, artist.name AS artist_name
FROM album album1
	INNER JOIN  artist ON album1.artistid = artist.artistid
		AND album1.title = 'Houses Of The Holy'
	INNER JOIN  album album2 ON album1.artistid = album2.artistid
WHERE album2.title <> 'Houses Of The Holy'
ORDER BY 2


-- solutie bazata pe o subconsultare in clauza WHERE, care include albumul
-- 'Houses Of The Holy', dar nu si numele artistului
SELECT *
FROM album
WHERE artistid IN  (SELECT artistid FROM album WHERE title = 'Houses Of The Holy')


-- solutie bazata pe o subconsultare in clauza WHERE, care include albumul
-- 'Houses Of The Holy' si numele artistului
SELECT *
FROM album NATURAL JOIN artist
WHERE artistid IN  (SELECT artistid FROM album WHERE title = 'Houses Of The Holy')


-- solutie bazata pe o subconsultare in clauza WHERE, care nu include albumul
-- 'Houses Of The Holy', insa include numele artistului
SELECT *
FROM album NATURAL JOIN artist
WHERE artistid IN  (SELECT artistid FROM album WHERE title = 'Houses Of The Holy')
	AND title <> 'Houses Of The Holy'
ORDER BY 2



-- ############################################################################
--      Care sunt piesele de pe albumul `Achtung Baby` al formației U2?
-- ############################################################################
--      List all tracks on the album `Achtung Baby` released by U2?
-- ############################################################################


-- solutie anterioara - folosind INNER JOINs
SELECT track.*
FROM album
	NATURAL JOIN artist
	INNER JOIN  track ON album.albumid = track.albumid
WHERE artist.name = 'U2' AND title = 'Achtung Baby'


-- solutie noua - folosind un lant de subconsultari in clauza WHERE
SELECT *
FROM track
WHERE albumid IN  (SELECT albumid
				  FROM album
				  WHERE title = 'Achtung Baby' AND
						artistid IN  (SELECT artistid
								    FROM artist
								    WHERE name = 'U2'))


-- solutie care foloseste doar o subconsultare in clauza WHERE
SELECT *
FROM track
WHERE albumid IN  (SELECT albumid
				FROM album NATURAL JOIN artist
				WHERE title = 'Achtung Baby' AND name = 'U2')


-- ############################################################################
-- 			Care sunt piesele comune (cu acelasi titlu) de pe
-- 			albumele `Fear Of The Dark` si `A Real Live One`
-- 					ale formatiei 'Iron Maiden' (reluare)
-- ############################################################################
-- 			Extract the tracks (track name) included on both `Fear Of The Dark` and
--  `A Real Live One` albums released by 'Iron Maiden' (the common tracks of
--      both albums) (reprise)
-- ############################################################################


-- solutie bazata pe subconsultare in clauza WHERE
SELECT track.name
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark'
	AND track.name IN (
		SELECT track.name
		FROM track
			INNER JOIN album ON track.albumid = album.albumid
			INNER JOIN artist ON album.artistid = artist.artistid
        WHERE artist.name = 'Iron Maiden' AND title = 'A Real Live One')



-- ############################################################################
--               Care sunt facturile din prima zi de vânzări?
-- ############################################################################
--               Extract invoices issued in the first day with sales
-- ############################################################################

-- solutie bazata pe o subconsultare ce foloseste functia MIN
SELECT *
FROM invoice
WHERE invoicedate = (
		SELECT MIN(invoicedate)
		FROM invoice)


-- solutie ce evita functia MIN (prin operatorul ALL)
SELECT *
FROM invoice
WHERE invoicedate <= ALL (
		SELECT DISTINCT invoicedate
		FROM invoice
		ORDER BY invoicedate
					       )

-- alta solutie ce evita functia MIN (prin operatorul LIMIT)
SELECT *
FROM invoice
WHERE invoicedate = (
		SELECT DISTINCT invoicedate
		FROM invoice
		ORDER BY invoicedate
		LIMIT 1		)



-- ############################################################################
--           Care sunt facturile din prima săptămână de vânzări?
-- ############################################################################
--        List invoices issued in the first week since the sales begun
-- ############################################################################

SELECT *
FROM invoice
WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND
	(SELECT MIN(invoicedate) + INTERVAL '6 DAYS' FROM invoice)


-- ############################################################################
--            Care sunt facturile din prima lună de vânzări?
-- ############################################################################
--        List invoices issued in the first month since the sales begun
-- ############################################################################

SELECT *
FROM invoice
WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND
	(SELECT MIN(invoicedate) + INTERVAL '1 MONTH' - INTERVAL '1 DAYS' FROM invoice)



-- ############################################################################
--        Câte facturi s-au emis în anul și luna primei facturi?
-- ############################################################################
--    How many invoices were issued in the whole month when the sales begun?
-- ############################################################################

-- solutie bazata pe o singura subconsultare
SELECT *
FROM invoice
WHERE EXTRACT (YEAR FROM invoicedate) || '-' || EXTRACT (MONTH FROM invoicedate) + 100 IN
	(SELECT MIN(EXTRACT (YEAR FROM invoicedate) || '-' || 100 + EXTRACT (MONTH FROM invoicedate))
	  FROM invoice)

-- solutie bazata pe trei subconsultari
SELECT *
FROM invoice
WHERE EXTRACT (YEAR FROM invoicedate) =
				(SELECT MIN (EXTRACT (YEAR FROM invoicedate)) FROM invoice)
	AND EXTRACT (MONTH FROM invoicedate) =
			(SELECT MIN(EXTRACT (MONTH FROM invoicedate))
			 FROM invoice
		     WHERE EXTRACT (YEAR FROM invoicedate) IN
					(SELECT MIN(EXTRACT (YEAR FROM invoicedate) )
	  				 FROM invoice)
			 )


-- ############################################################################
--            Câte facturi s-au emis în primele 10 zile cu vânzări ?
-- ############################################################################
--    How many invoices were issued in the first 10 days with sales ?
-- ############################################################################


-- solutie bazata pe o subconsultare in clauza WHERE care prezinta LIMIT si
--    SELECT DISTINCT (atentie, DISTINCT este obligatorie!);
-- conectorul dintre interogarea principale si subconsultare este in
SELECT *
FROM invoice
WHERE invoicedate IN (
	SELECT distinct invoicedate
	FROM invoice
	ORDER BY invoicedate
	LIMIT 10
	)

-- aceeasi solutie, insa cu FETCH
SELECT *
FROM invoice
WHERE invoicedate IN (SELECT distinct invoicedate
					  FROM invoice
					  ORDER BY invoicedate
					  FETCH FIRST 10 ROWS ONLY
					   )


-- o solutie ce foloseste ANY
SELECT *
FROM invoice
WHERE invoicedate <= ANY (
					   SELECT distinct invoicedate
					   FROM invoice
					   ORDER BY invoicedate
					   LIMIT 10
					   )

-- o solutie ce foloseste OFFSET si LIMIT pentru a determina a 10-a valoare a `invoicedate`
SELECT *
FROM invoice
WHERE invoicedate <=  (SELECT distinct invoicedate
					   FROM invoice
					   ORDER BY invoicedate
					   OFFSET 9
					   LIMIT 1
					   )



-- ############################################################################
--        Care sunt cei mai vechi cinci angajați ai companiei?
-- ############################################################################
--                     Extract the first five employed people
-- ############################################################################

-- solutia bazata pe LIMIT extrage un rezultat incomplet!!!!
SELECT *
FROM employee
ORDER BY hiredate
LIMIT 5

-- solutie corecta - subconsultare & LIMIT
SELECT *
FROM employee
WHERE hiredate IN (
					SELECT hiredate
					FROM employee
					ORDER BY hiredate
					LIMIT 5
					)
ORDER BY hiredate


-- solutie corecta - subconsultare, OFFSET & LIMIT
SELECT *
FROM employee
WHERE hiredate <= (
					SELECT hiredate
					FROM employee
					ORDER BY hiredate
	        		OFFSET 4
					LIMIT 1
					)
ORDER BY hiredate


--
-- ############################################################################
--                       Subconsultări în clauza HAVING
-- ############################################################################
--                       Subqueries included in HAVING
-- ############################################################################



-- ############################################################################
--      Care sunt albumele formației Led Zeppelin care au mai multe piese
--                            decât albumul `IV`
-- ############################################################################
--      List the albums released by Led Zeppelin with more tracks than
--                            the album `IV`
-- ############################################################################

-- solutie bazata pe o subconsultare in clauza HAVING
SELECT title, COUNT(*) AS n_of_tracks
FROM album
	NATURAL JOIN artist
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Led Zeppelin'
GROUP BY title
HAVING COUNT(*) > (SELECT COUNT(*)
                   FROM album
					  	            NATURAL JOIN artist
						              INNER JOIN track ON album.albumid = track.albumid
					         WHERE artist.name = 'Led Zeppelin' AND title = 'IV')
ORDER BY 1



-- ############################################################################
--            Care este albumul (sau albumele) formației Queen
--                      cu cele mai multe piese?
-- ############################################################################
--            List the album (or albums) released by `Queen`
--                      having the largest number of tracks
-- ############################################################################

-- solutie bazata pe `>= ALL`
SELECT title, COUNT(*) AS n_of_tracks
FROM album
	NATURAL JOIN artist
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Queen'
GROUP BY title
HAVING COUNT(*) >= ALL (
					SELECT COUNT(*)
					FROM album
					  	NATURAL JOIN artist
							INNER JOIN track ON album.albumid = track.albumid
					WHERE artist.name = 'Queen'
					GROUP BY title  )
ORDER BY 1


-- solutie bazata pe LIMIT
SELECT title, COUNT(*) AS n_of_tracks
FROM album
	NATURAL JOIN artist
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Queen'
GROUP BY title
HAVING COUNT(*) =  (
					SELECT COUNT(*)
					FROM album
					  	NATURAL JOIN artist
							INNER JOIN track ON album.albumid = track.albumid
					WHERE artist.name = 'Queen'
					GROUP BY title
					ORDER BY 1 DESC
					LIMIT 1)
ORDER BY 1




-- ############################################################################
-- 		Extrageți TOP 7 albume ale formației `U2`, după numărul de piese?
-- ############################################################################
-- 		    Get TOP 7 albums released by `U2`, by their number of tracks?
-- ############################################################################


-- solutia urmatoare genereaza un rezultat incomplet
SELECT title, COUNT(*) AS n_of_tracks
FROM album
		NATURAL JOIN artist
		INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'U2'
GROUP BY title
ORDER BY 2 DESC
LIMIT 7

-- solutie corecta
SELECT title, COUNT(*) AS n_of_tracks
FROM album
		NATURAL JOIN artist
		INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'U2'
GROUP BY title
HAVING COUNT(*) IN (
		SELECT COUNT(*) AS n_of_tracks
		FROM album
			NATURAL JOIN artist
			INNER JOIN track ON album.albumid = track.albumid
		WHERE artist.name = 'U2'
		GROUP BY title
		ORDER BY 1 DESC
		LIMIT 7)
ORDER BY 2 DESC




--
-- ############################################################################
--                       Diviziune relațională (1)
-- ############################################################################
--                         Relational division (1)
-- ############################################################################
--

-- ############################################################################
--     Extrageți artiștii și albumele de pe care s-au vândut toate piesele.
-- Notă: se iau în calcul numai albumele cu cel puțin două piese
-- ############################################################################
--     List the artist and their albums for which all album tracks were
--      sold
-- Important notice: only albums with at least two tracks are considered
-- ############################################################################


-- enuntul sugereaza diviziunea relationala, insa solutia e una non-diviziune
SELECT artist.name, title, COUNT(DISTINCT track.trackid) AS n_of_sold_tracks_from_the_album
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
GROUP BY artist.name, title
HAVING artist.name || ' - ' || title || ' - ' || COUNT(DISTINCT track.trackid) IN (
	SELECT artist.name || ' - ' || title || ' - ' || COUNT(track.trackid)
	FROM artist
		NATURAL JOIN album
		INNER JOIN track ON album.albumid = track.albumid
	GROUP BY artist.name, title
	HAVING COUNT(track.trackid) >= 2)
ORDER BY 1


-- solutia urmatoare se apropie de logica diviziunii
-- pentru a intelege logica functiei `string_agg`, vezi:
-- `https://www.postgresqltutorial.com/postgresql-aggregate-functions/postgresql-string_agg-function/`
SELECT artist.name, title,
	string_agg(DISTINCT CAST(track.trackid AS VARCHAR),
							 '|' ORDER BY CAST(track.trackid AS VARCHAR))
							 AS all_tracks_from_this_album,
	string_agg(DISTINCT CAST(invoiceline.trackid AS VARCHAR),
							 '|' ORDER BY CAST(invoiceline.trackid AS VARCHAR))
							 AS sold_tracks_from_the_album
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
	LEFT JOIN invoiceline ON track.trackid = invoiceline.trackid
GROUP BY artist.name, title
HAVING
	string_agg(DISTINCT CAST(track.trackid AS VARCHAR),
							 '|' ORDER BY CAST(track.trackid AS VARCHAR)) =
	COALESCE(string_agg(DISTINCT CAST(invoiceline.trackid AS VARCHAR),
							 '|' ORDER BY CAST(invoiceline.trackid AS VARCHAR)), '')
			AND string_agg(DISTINCT CAST(track.trackid AS VARCHAR),
							 '|' ORDER BY CAST(track.trackid AS VARCHAR)) LIKE '%|%'
ORDER BY 1



-- ############################################################################
-- 	 Care sunt artiștii `vânduți` în toate țările din care provin clienții?
-- ############################################################################
-- 	     Find the artists with sales in all of the countries with customers
-- ############################################################################

-- enuntul sugereaza diviziunea relationala, insa solutia e una non-diviziune
SELECT artist.name, COUNT(DISTINCT country) AS n_of_countries
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	NATURAL JOIN customer
GROUP BY artist.name
HAVING COUNT(DISTINCT country) = (SELECT COUNT(DISTINCT country) FROM customer)



-- ############################################################################
-- 	 Care sunt artiștii cu vânzări în toate țările din urmatorul set:
--  ('USA', 'France', 'United Kingdom', 'Spain')
-- ############################################################################
-- 	 Find the artists with sales in ALL of the countries from the following set:
--  ('USA', 'France', 'United Kingdom', 'Spain')
-- ############################################################################

-- enuntul sugereaza diviziunea relationala, insa solutia e una non-diviziune
SELECT artist.name, COUNT(DISTINCT country) AS n_of_countries
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	NATURAL JOIN customer
WHERE country IN ('USA', 'France', 'United Kingdom', 'Spain')
GROUP BY artist.name
HAVING COUNT(DISTINCT country) = 4


-- solutie apropiata de logica diviziunii relationale
SELECT artist.name,
	string_agg(DISTINCT country, '|' ORDER BY country)
							 AS countries
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	NATURAL JOIN customer
WHERE country IN ('USA', 'France', 'United Kingdom', 'Spain')
GROUP BY artist.name
HAVING string_agg(DISTINCT country, '|' ORDER BY country)  IN (
	SELECT string_agg(DISTINCT country, '|' ORDER BY country)
	FROM customer
	WHERE country IN ('USA', 'France', 'United Kingdom', 'Spain')
	ORDER BY 1
)



-- ############################################################################
--    Care sunt artiștii cu vânzări în toate orașele din 'United Kingdom' din
--                          care provin clienții
-- ############################################################################
--    Find the artist with sales in all the 'United Kingdom' cities where is
--                          at least one customer
-- ############################################################################

--
SELECT artist.name, COUNT(DISTINCT city) AS n_of_cities
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	NATURAL JOIN customer
WHERE country IN ('United Kingdom')
GROUP BY artist.name
HAVING COUNT(DISTINCT city) = (
	SELECT COUNT(DISTINCT city)
	FROM customer
	WHERE country IN ('United Kingdom')
	)


-- solutie mai apropiata de logica diviziunii
SELECT artist.name, string_agg(DISTINCT city, '|' ORDER BY city) AS cities_uk
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	NATURAL JOIN customer
WHERE country IN ('United Kingdom')
GROUP BY artist.name
HAVING string_agg(DISTINCT city, '|' ORDER BY city) = (
	SELECT string_agg(DISTINCT city, '|' ORDER BY city)
	FROM customer
	WHERE country IN ('United Kingdom')
	)



-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
-- ############################################################################

-- Care primul (sau primii) angajat(i) in companie?

-- Care sunt artistii care au in baza de date mai multe albume decat formatia `Queen`?




-- ############################################################################
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
-- ############################################################################


SELECT *
FROM employee
WHERE birthdate =
	(SELECT min(birthdate) FROM employee)  ;


SELECT e.lastname, e.firstname, birthdate, age(current_date, birthdate) as age
FROM employee e
WHERE age(current_date, birthdate) =
	(SELECT max(age(current_date, birthdate)) FROM employee)  ;


SELECT name AS artist_name
FROM artist
WHERE name IN  (
	SELECT title
	FROM album)
  ORDER BY 1 ;


SELECT title, name
FROM album INNER JOIN  artist ON artist.artistid = album.artistid
WHERE albumid IN  (
	SELECT albumid
	FROM track
	WHERE name = 'Amazing') ;


SELECT artist.name AS artist_name, title, track.name AS track_name
FROM album
	INNER JOIN  artist ON artist.artistid = album.artistid
	INNER JOIN  track ON album.albumid = track.albumid
WHERE album.albumid IN  (
	SELECT albumid
	FROM track
	WHERE name = 'Amazing')
ORDER BY 1, 2, 3 ;


SELECT artist.name AS artist_name, title, track.name AS track_name, milliseconds
FROM album
	INNER JOIN  artist ON artist.artistid = album.artistid
	INNER JOIN  track ON album.albumid = track.albumid
WHERE   milliseconds IN  (
		SELECT max(milliseconds)
		FROM track) ;


SELECT title, artist.name, sum(milliseconds)/60000 AS duration_minutes
FROM album
	INNER JOIN  artist ON artist.artistid = album.artistid
	INNER JOIN  track ON album.albumid = track.albumid
GROUP BY title, artist.name
HAVING sum(milliseconds)/60000 = (
	SELECT sum(milliseconds)/60000 AS duration_minutes
	FROM album
		INNER JOIN  artist ON artist.artistid = album.artistid
		INNER JOIN  track ON album.albumid = track.albumid
	GROUP BY title, artist.name
	ORDER BY 1 desc LIMIT 1) ;



SELECT title AS album_title, artist.name AS artist_name,
	count(*) as n_of_tracks
FROM track
	INNER JOIN  album ON track.albumid = album.albumid
	INNER JOIN  artist ON album.artistid = artist.artistid
WHERE artist.name = 'U2'
GROUP BY title, artist.name
HAVING count(*) >=
	(SELECT count(*)
	 FROM track
		INNER JOIN  album ON track.albumid = album.albumid
		INNER JOIN  artist ON album.artistid = artist.artistid
	 WHERE artist.name = 'U2' AND title = 'Pop')
