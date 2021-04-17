-- ############################################################################
--                Interogari BD Chinook - IE, CIG si SPE:
-- ############################################################################
--
-- 07: Jonctiuni externe
--
-- ultima actualizare: 2020-04-07


-- ############################################################################
--    Care sunt artistii care, momentan, nu au niciun album preluat in BD?
-- ############################################################################

-- solutie bazata pe diferenta
SELECT artist.*
FROM artist
EXCEPT
SELECT artist.*
FROM artist INNER JOIN album ON artist.artistid = album.artistid
ORDER BY name


-- solutie bazata pe jonctiune externa
SELECT *
FROM artist LEFT JOIN album ON artist.artistid = album.artistid
WHERE title IS NULL
ORDER BY name



-- ############################################################################
-- Extrageti numarul albumelor fiecarui artist; pentru artistii (actualmente)
-- 					fara albume, sa se afiseze `0`
-- ############################################################################

-- solutia din scriptul anterior afiseaza numai artistii care au macar
-- un album preluat in BD (rezultatul are 204 linii)
SELECT name AS artist_name, COUNT(*) as n_of_albums
FROM artist NATURAL JOIN album
GROUP BY name
ORDER BY 1

-- solutia corecta necesita optiunea LEFT JOIN (275 de linii in rezultat)
SELECT name AS artist_name, COUNT(albumid) AS nr_albume
FROM artist LEFT JOIN album ON artist.artistid = album.artistid
GROUP BY name
ORDER BY name



-- ############################################################################
--     Care sunt artistii care, momentan, nu au niciun album preluat in BD?
-- ############################################################################

-- solutie bazata pe grupare

SELECT name AS artist_name, COUNT(albumid) AS nr_albume
FROM artist LEFT JOIN album ON artist.artistid = album.artistid
GROUP BY name
HAVING COUNT(albumid) = 0
ORDER BY name


-- ############################################################################
--             Afisati, pentru fiecare client din baza de date,
--        vanzarile pe anul 2010 (in raport trebuie inclusi si clientii
--                 pentru care nu sunt vanzari in 2010)
-- ############################################################################

-- solutie bazata pe LEFT JOIN si CASE
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	CASE WHEN SUM(total) IS NULL THEN 0 ELSE SUM(total) END AS sales_2010
FROM customer
	LEFT JOIN invoice ON customer.customerid = invoice.customerid AND
		EXTRACT (YEAR FROM invoice.invoicedate) = 2010
GROUP BY lastname || ' ' || firstname, city, state, country
ORDER BY 1


-- solutie bazata pe LEFT JOIN si COALESCE
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	COALESCE(SUM(total), 0) AS sales_2010
FROM customer
	LEFT JOIN invoice ON customer.customerid = invoice.customerid AND
		EXTRACT (YEAR FROM invoice.invoicedate) = 2010
GROUP BY lastname || ' ' || firstname, city, state, country



-- ############################################################################
--            Afisati, pentru fiecare client, pe trei linii separate,
--                  vanzarile pe anii 2010, 2011 si 2012
-- ############################################################################


-- o solutie bazata pe jonctiune externe, grupare si UNION
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	2010 AS year, COALESCE(SUM(total), 0) AS sales
FROM customer
	LEFT JOIN invoice ON customer.customerid = invoice.customerid AND
		EXTRACT (YEAR FROM invoice.invoicedate) = 2010
GROUP BY lastname || ' ' || firstname, city, state, country
	UNION
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	2011 AS year, COALESCE(SUM(total), 0) AS sales
FROM customer
	LEFT JOIN invoice ON customer.customerid = invoice.customerid AND
		EXTRACT (YEAR FROM invoice.invoicedate) = 2011
GROUP BY lastname || ' ' || firstname, city, state, country
	UNION
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	2012 AS year, COALESCE(SUM(total), 0) AS sales
FROM customer
	LEFT JOIN invoice ON customer.customerid = invoice.customerid AND
		EXTRACT (YEAR FROM invoice.invoicedate) = 2012
GROUP BY lastname || ' ' || firstname, city, state, country
ORDER BY customer_name, year



-- ############################################################################
--              Afisati, pentru fiecare client, pe coloane separate,
--                 vanzarile pe anii 2010, 2011 si 2012 (reluare)
-- ############################################################################

-- solutia urmatoare este eronata !!!!! (trebuie folosite subconsultari in
-- clauza FROM sau expresii-tabele)

-- explicati de unde provine eroarea!
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	COALESCE(SUM(i2010.total), 0) AS sales2010,
	COALESCE(SUM(i2011.total), 0) AS sales2011,
	COALESCE(SUM(i2012.total), 0) AS sales2012
FROM customer
	LEFT JOIN invoice i2010 ON customer.customerid = i2010.customerid AND
		EXTRACT (YEAR FROM i2010.invoicedate) = 2010
	LEFT JOIN invoice i2011 ON customer.customerid = i2011.customerid AND
		EXTRACT (YEAR FROM i2011.invoicedate) = 2011
	LEFT JOIN invoice i2012 ON customer.customerid = i2012.customerid AND
		EXTRACT (YEAR FROM i2012.invoicedate) = 2012
GROUP BY lastname || ' ' || firstname, city, state, country
ORDER BY 1


-- aceasta e corecta (o sa o discutam in partea a III-a, insa acum o putem executa
--   pentru a vedea care sunt valorile corecte ale vanzarilor)
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	COALESCE(sales2010, 0) AS sales2010,
	COALESCE(sales2011, 0) AS sales2011,
	COALESCE(sales2012, 0) AS sales2012
FROM customer
	LEFT JOIN
		(SELECT customerid, SUM(total) AS sales2010
		 FROM invoice
		 WHERE EXTRACT (YEAR FROM invoicedate) = 2010
		 GROUP BY customerid) s2010
				ON customer.customerid = s2010.customerid
	LEFT JOIN
		(SELECT customerid, SUM(total) AS sales2011
		 FROM invoice
		 WHERE EXTRACT (YEAR FROM invoicedate) = 2011
		 GROUP BY customerid) s2011
				ON customer.customerid = s2011.customerid
	LEFT JOIN
		(SELECT customerid, SUM(total) AS sales2012
		 FROM invoice
		 WHERE EXTRACT (YEAR FROM invoicedate) = 2012
		GROUP BY customerid) s2012
				ON customer.customerid = s2012.customerid
ORDER BY 1




-- ############################################################################
--               Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################


-- Obtineti un raport in care linii sunt asociate fiecarui artist,
--   iar coloanele fiecarui gen muzical (prima coloana va fi numele artistului);
--   calculati numarul de piese ale fiecarui artist pe fiecare gen muzical



-- ############################################################################
--          La ce intrebari raspund urmatoarele interogari ?
-- ############################################################################

--
SELECT track.name AS track_name, title AS album_title,
	COALESCE(SUM(quantity * invoiceline.unitprice),0) AS sales
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
	LEFT JOIN invoiceline ON track.trackid = invoiceline.trackid
WHERE artist.name = 'U2'
GROUP BY track.name, title
ORDER BY 2, 1
