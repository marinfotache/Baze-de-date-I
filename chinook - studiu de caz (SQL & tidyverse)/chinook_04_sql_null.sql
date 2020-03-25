-- 						Interogari BD Chinook - IE si SPE:
--
-- SQL 04: Tratamentul (meta)valorilor NULL
--
-- ultima actualizare: 2020-03-25


-- ############################################################################
-- 									IS NULL
-- ############################################################################

-- ############################################################################
-- Care sunt clientii individuali (non-companii)
-- ############################################################################

SELECT *
FROM customer
WHERE company IS NULL


--############################################################################
--##               Care sunt clientii care reprezinta companii
-- ############################################################################
SELECT *
FROM customer
WHERE company IS NOT NULL



-- ############################################################################
-- Care sunt piesele de pe albumele formatiei `Black Sabbath`
-- carora nu li se cunoaste compozitorul
-- ############################################################################

SELECT *
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Black Sabbath' AND composer is null



-- ############################################################################
-- 								COALESCE
-- ############################################################################

-- ############################################################################
-- Sa se afiseze, in ordine alfabetica, toate titlurile pieselor de pe
-- albumele formatiei `Black Sabbath`, impreuna cu autorul (compozitor) lor;
-- acolo unde compozitorul nu este specificat (NULL), sa se afiseze
-- `COMPOZITOR NECUNOSCUT`
-- ############################################################################

SELECT track.name, COALESCE(composer, 'COMPOZITOR NECUNOSCUT') AS compozitor
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Black Sabbath'
ORDER BY 1




-- ############################################################################
-- 						Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################

-- Afisati clientii in ordinea tarilor; pentru cei din tari non-federative,
--   la atributul `state`, in locul valorii NULL afisati `-`
SELECT customerid, firstname, lastname, state, coalesce(state, '-') as state2
FROM customer

-- Afisati toate facturile (tabela `invoice), completand eventualele valori NULL
--   ale atributului `billingstate` cu valoarea tributului `billing city` de pe
--   aceeasi linie





-- ############################################################################
-- 						La ce intrebari raspund urmatoarele interogari ?
-- ############################################################################



-- Care este diferenta (in privinta numarului de linii din rezultat) intre
-- urmatoarele doua interogari

SELECT DISTINCT city, state, country
FROM customer
-- ... si
SELECT DISTINCT city || ' - ' || state || ' - ' || country
FROM customer
