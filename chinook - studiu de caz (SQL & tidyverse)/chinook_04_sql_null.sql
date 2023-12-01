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
-- 					SQL04: Tratamentul (meta)valorilor NULL
-- 					SQL04: NULL values treatment
-- ############################################################################
-- ultima actualizare / last update: 2023-12-01


-- ############################################################################
--                                     IS NULL
-- ############################################################################

-- ############################################################################
--             Care sunt clienții individuali (non-companii)
-- ############################################################################
--             Extract the individual (non-companies) customers
-- ############################################################################
SELECT *
FROM customer
WHERE company IS NULL


--############################################################################
--##               Care sunt clienții care reprezintă companii
-- ############################################################################
--##               Which are the customers representing companies?
--############################################################################
SELECT *
FROM customer
WHERE company IS NOT NULL


-- ############################################################################
--       Care sunt piesele de pe albumele formației `Black Sabbath`
--                   cărora nu li se cunoaște compozitorul
-- ############################################################################
--  Extract the tracks released by `Black Sabbath` whose composers are unknown
-- ############################################################################
SELECT *
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Black Sabbath' AND composer is null


-- ############################################################################
-- Să se afișeze, sub formă de șir de caractere, orașele din care provin
-- clienții (pentru a elimina confuziile, numele orașului trebuie concatenat
-- cu statul și tara din care face parte orașul respectiv)
-- ############################################################################
--   Extract, as strings, the cities of the customers (the string will contain
-- the city name concatenated with its state and country)
-- ############################################################################

-- solutie eronata !!!! De ce?  / Where is the error?
SELECT DISTINCT city || ' - ' || state || ' - ' || country
FROM customer

-- comparati cu...
SELECT DISTINCT city, state, country
FROM customer


-- ############################################################################
--                                COALESCE
-- ############################################################################

-- ############################################################################
-- Afișați clienții în ordinea țărilor; pentru cei din țări non-federative,
--   la atributul `state`, în locul valorii NULL, afișati `-`
-- ############################################################################
-- Display customers ordered by their countries. For customers in
-- non-federative countries, the NULL value of attribute `state` will be
--   replaces with hyphen (`-`)
-- ############################################################################

SELECT customerid, firstname, lastname, state, COALESCE(state, '-') as state2
FROM customer


-- ############################################################################
-- Să se afișeze, în ordine alfabetică, toate titlurile pieselor de pe
-- albumele formației `Black Sabbath`, împreuna cu autorii (compozitorii) lor;
-- acolo unde compozitorul nu este specificat (NULL), să se afișeze
-- `COMPOZITOR NECUNOSCUT`
-- ############################################################################
-- Dispay alphabeticaly the names of the names released by `Black Sabbath` and
-- theirs composers; whenever the composes is unknown, replace NULL with
-- `COMPOZITOR NECUNOSCUT`
-- ############################################################################

-- CASE
SELECT track.name,
	CASE WHEN composer IS NULL THEN 'COMPOZITOR NECUNOSCUT'
		ELSE composer END AS compozitor
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Black Sabbath'
ORDER BY 1


-- COALESCE()
SELECT track.name, COALESCE(composer, 'COMPOZITOR NECUNOSCUT') AS compozitor
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Black Sabbath'
ORDER BY 1



-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
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
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
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
