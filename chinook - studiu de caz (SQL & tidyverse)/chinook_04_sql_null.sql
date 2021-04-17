-- ############################################################################
--                Interogari BD Chinook - IE, CIG si SPE:
-- ############################################################################
--
-- SQL 04: Tratamentul (meta)valorilor NULL
--
-- ultima actualizare: 2021-03-26


-- ############################################################################
--                                     IS NULL
-- ############################################################################

-- ############################################################################
--             Care sunt clientii individuali (non-companii)
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
--       Care sunt piesele de pe albumele formatiei `Black Sabbath`
--                   carora nu li se cunoaste compozitorul
-- ############################################################################

SELECT *
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Black Sabbath' AND composer is null



-- ############################################################################
-- Sa se afiseze, sub forma de sir de caractere, orasele din care provin
-- clientii (pentru a elimina confuziile, numele orasului trebuie concatenat
-- cu statul si tara din care face parte orasul respectiv)
-- ############################################################################

-- solutie eronata !!!! De ce?
SELECT DISTINCT city || ' - ' || state || ' - ' || country
FROM customer

-- comparati cu...
SELECT DISTINCT city, state, country
FROM customer



-- ############################################################################
--                                COALESCE
-- ############################################################################

-- ############################################################################
-- Afisati clientii in ordinea tarilor; pentru cei din tari non-federative,
--   la atributul `state`, in locul valorii NULL afisati `-`
-- ############################################################################

SELECT customerid, firstname, lastname, state, COALESCE(state, '-') as state2
FROM customer


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
--               Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################


-- ############################################################################
-- Sa se afiseze, sub forma de sir de caractere, orasele din care provin
-- clientii (pentru a elimina confuziile, numele orasului trebuie concatenat
-- cu statul si tara din care face parte orasul respectiv)



-- ############################################################################
-- Afisati toate facturile (tabela `invoice), completand eventualele valori NULL
--   ale atributului `billingstate` cu valoarea tributului `billing city` de pe
--   aceeasi linie




-- ############################################################################
--        Care sunt cerintele la care raspund urmatoarele interogari ?
-- ############################################################################


-- A.
SELECT firstname, lastname, city,
	COALESCE(state, country) AS state,
	country
FROM customer



-- B.
SELECT COUNT(city || ' - ' || state || ' - ' || country) AS n_of_cities
FROM customer


-- C.
SELECT COUNT(city || ' - ' || coalesce(state, '-') || ' - ' || country) AS n_of_cities
FROM customer
ORDER BY 1




-- ############################################################################
--          Explicati diferenta numarului de linii din rezultat pentru
--                 urmatoarele doua perechi de interogari
-- ############################################################################

-- A.

SELECT city || ' - ' || state || ' - ' || country AS city_string
FROM customer
ORDER BY 1
-- 59 randuri

SELECT city || ' - ' || coalesce(state, '-') || ' - ' || country AS city_string2
FROM customer
ORDER BY 1
-- 59 randuri


-- B.

SELECT DISTINCT city || ' - ' || state || ' - ' || country AS city_string
FROM customer
ORDER BY 1
-- 29 randuri

SELECT DISTINCT city || ' - ' || coalesce(state, '-') || ' - ' || country AS city_string2
FROM customer
-- 53 randuri
