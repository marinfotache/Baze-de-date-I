-- ############################################################################
--                Interogari BD Chinook - IE, CIG si SPE:
-- ############################################################################
--
-- 08: Subconsultari IN clauzele WHERE si HAVING. Diviziune relationala (1)
--
-- ultima actualizare: 2021-04-12


--
-- ############################################################################
--                         Subconsultari IN clauza WHERE
-- ############################################################################
--

-- ############################################################################
--        Care sunt celelalte albume ale artistului sau formatiei care a
--                   lansat albumul `Houses of the Holy`
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
--      Care sunt piesele de pe albumul `Achtung Baby` al formatiei U2?
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
--               Care sunt piesele comune (cu acelasi titlu) de pe
--                albumele `Fear Of The Dark` si `A Real Live One`
--                  ale formatiei 'Iron Maiden' (reluare)
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
--               Care sunt facturile din prima zi de vanzari?
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
WHERE invoicedate <= ALL (SELECT DISTINCT invoicedate
					      FROM invoice
					      ORDER BY invoicedate
					       )



-- ############################################################################
--           Care sunt facturile din prima saptamana de vanzari?
-- ############################################################################
SELECT *
FROM invoice
WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND
	(SELECT MIN(invoicedate) + INTERVAL '6 DAYS' FROM invoice)


-- ############################################################################
--            Care sunt facturile din prima luna de vanzari?
-- ############################################################################
SELECT *
FROM invoice
WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND
	(SELECT MIN(invoicedate) + INTERVAL '1 MONTH' - INTERVAL '1 DAYS' FROM invoice)


-- ############################################################################
--     Cate facturi s-au emis in prima luna calendaristica a vanzarilor ?
--              (adica prima luna IANUARIE sau APRILIE ...)
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
--            Cate facturi s-au emis in primele 10 zile cu vanzari ?
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
--        Care sunt cei mai vechi cinci angajati ai companiei?
-- ############################################################################

-- solutia bazata pe LIMIT extrage un rezultat incomplet
SELECT *
FROM employee
ORDER BY hiredate
LIMIT 5

-- solutia pentru rezultatul complet e bazata pe LIMIT si o subconsultare
SELECT *
FROM employee
WHERE hiredate IN (
					SELECT hiredate
					FROM employee
					ORDER BY hiredate
					LIMIT 5
					)
ORDER BY hiredate




--
-- ############################################################################
--                       Subconsultari IN clauza HAVING
-- ############################################################################
--

-- ############################################################################
--      Care sunt albumele formatiei Led Zeppelin care au mai multe piese
--                            decat albumul `IV`
-- ############################################################################

-- solutie bazata pe o subsonsultare in clauza HAVING
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
--            Care este albumul (sau albumele) formatiei Queen
--                      cu cele mai multe piese?
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
-- 		Extrageti TOP 7 albume ale formatiei `U2`, cu cele mai multe piese?
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
-- 				             Diviziune relationala (1)
-- ############################################################################
--

-- ############################################################################
--     Extrageti artistii si albumele de pe care s-au vandut toate piesele.
-- Nota: se iau in calcul numai albumele cu cel putin doua piese
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
-- 	 Care sunt artistii `vanduti` in toate tarile din care provin clientii?
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
-- 	 Care sunt artistii `vanduti` in toate tarile din urmatorul set:
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
-- 	 Care sunt artistii `vanduti` in toate orasele din 'United Kingdom' din
--  					care provin clientii
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
--               Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################

-- Care primul (sau primii) angajat(i) in companie?

-- Care sunt artistii care au in baza de date mai multe albume decat formatia `Queen`?




-- ############################################################################
--          La ce intrebari raspund urmatoarele interogari ?
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
