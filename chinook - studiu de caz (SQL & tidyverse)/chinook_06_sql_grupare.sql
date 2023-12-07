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
-- 					SQL06: Grupare, subtotaluri, filtrare grupuri (HAVING)
-- 					SQL06: GROUP BY, subtotals, group filters (HAVING)
-- ############################################################################
-- ultima actualizare / last update: 2023-12-01


-- ############################################################################
--              Extrageți numărul albumelor lansate de fiecare artist
-- ############################################################################
--              Display the number of albums released by each artist
-- ############################################################################
SELECT name AS artist_name, COUNT(*) as n_of_albums
FROM artist NATURAL JOIN album
GROUP BY name
ORDER BY 1


-- ############################################################################
--           Care este artistul cu cel mai mare numar de albume?
-- ############################################################################
--           Find the artist that released the largest number of albums
-- ############################################################################
SELECT name AS artist_name, COUNT(*) as n_of_albums
FROM artist NATURAL JOIN album
GROUP BY name
ORDER BY 2 DESC
LIMIT 1


-- ############################################################################
--     Extrageți durata totală a pieselor (în minute) pentru fiecare artist
-- ############################################################################
-- Compute the total duration (in minutes) of the tracks released by each artist
-- ############################################################################
SELECT artist.name AS artist_name,
	ROUND(SUM(milliseconds / 60000)) AS duration_minutes
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
GROUP BY artist.name
ORDER BY artist.name


-- ############################################################################
--       Extrageți durata totală a pieselor (în minute) pentru fiecare
--            album al fiecărui artist, cu afișare de tipul HH:MI:SS
--                    (durata în minute și secunde)
-- ############################################################################
--   Display the total duration (in the HH:MI:SS format) of each album
--    released by each artist
-- ############################################################################
SELECT artist.name AS artist_name, title AS album_title,
	SUM(milliseconds / 1000) * interval '1 sec' AS duration
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
GROUP BY artist.name, title
ORDER BY artist.name, title



-- ############################################################################
--      Afișati toate piesele de pe toate albumele tuturor artiștilor;
-- Calculați subtotaluri cu durata în minute și secunde la nivel de album
--   și la nivel de artist, precum si un total general
-- ############################################################################
--      Display a report with the tracks on each album of every artist;
-- include a sub-total with the duration (in minutes and seconds) of each album,
--    another subtotal on artist level, and a grand total
-- ############################################################################

-- solutie bazata pe grupare si pe UNION
SELECT artist.name AS artist_name, title AS album_title, track.name as track_name,
	milliseconds / 1000 * interval '1 sec' AS duration
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
		UNION
SELECT artist.name AS artist_name, title AS album_title, '~ SUBTOTAL ON ALBUM',
	SUM(milliseconds / 1000) * interval '1 sec' AS duration_minutes
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
GROUP BY artist.name, title
		UNION
SELECT artist.name AS artist_name, '~~ SUBTOTAL ON ARTIST', '~~~~',
	SUM(milliseconds / 1000) * interval '1 sec' AS duration_minutes
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
GROUP BY artist.name
		UNION
SELECT '~~ GRAND TOTAL ~~', '~~~~~', '~~~~~',
	SUM(milliseconds / 1000) * interval '1 sec' AS duration_minutes
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
ORDER BY 1, 2, 3


-- solutie bazata pe ROLLUP, cu valori NULL care indica subtotalurile si totalul general
SELECT artist.name AS artist_name,
	title as album_title,
	track.name as track_name,
	SUM(milliseconds / 1000 * interval '1 sec') AS duration
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
GROUP BY ROLLUP (1, 2, 3 )
ORDER BY 1, 2, 3



-- ############################################################################
--             Afișati, pentru fiecare client, pe trei linii separate,
--                     vânzările pe anii 2010, 2011 și 2012
-- ############################################################################
--             Display, for each customer, on three different rows,
--                     the total sales on 2010, 2011 și 2012
-- ############################################################################

-- solutie incompleta (nu se afiseaza anii in care clientul respectiv nu
--  are nicio factura
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	EXTRACT (YEAR FROM invoicedate) AS year,
	SUM(total) AS sales
FROM customer
	NATURAL JOIN invoice
WHERE EXTRACT (YEAR FROM invoicedate) IN (2010, 2011, 2012)
GROUP BY lastname || ' ' || firstname, city, state, country,
	EXTRACT (YEAR FROM invoicedate)
ORDER BY 1, 2, 3, 4, 5


-- solutie corecta & completa
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	2010 as year,
	sum(case when extract (year from invoicedate) = 2010 then total else 0 end) as sales
FROM customer
	NATURAL JOIN invoice
GROUP BY lastname || ' ' || firstname, city, state, country

	UNION

SELECT lastname || ' ' || firstname, city, state, country,
	2011,
	sum(case when extract (year from invoicedate) = 2011 then total else 0 end)
FROM customer
	NATURAL JOIN invoice
GROUP BY lastname || ' ' || firstname, city, state, country

	UNION

SELECT lastname || ' ' || firstname, city, state, country,
	2012,
	sum(case when extract (year from invoicedate) = 2012 then total else 0 end)
FROM customer
	NATURAL JOIN invoice
GROUP BY lastname || ' ' || firstname, city, state, country
ORDER BY 1, 2, 3, 4, 5



-- ############################################################################
--                 Afișați, pentru fiecare client, pe coloane separate,
--                       vânzările pe anii 2010, 2011 și 2012
-- ############################################################################
--             Display, for each customer, on three different columns,
--                     the total sales on 2010, 2011 și 2012
-- ############################################################################

-- solutie bazata pe jonctiune interna, grupare si CASE
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2010 THEN total ELSE 0 END ) AS sales2010,
	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2011 THEN total ELSE 0 END ) AS sales2011,
	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2012 THEN total ELSE 0 END ) AS sales2012
FROM customer
	NATURAL JOIN invoice
GROUP BY lastname || ' ' || firstname, city, state, country
ORDER BY 1



-- ############################################################################
--                 Afișați, pentru fiecare client, pe coloane separate,
--                       vânzările pentru toți anii!
-- ############################################################################
--             Display, for each customer, on  different columns,
--                     the total sales on each year
-- ############################################################################

-- in SQL solutia nu poate fi generalizata, asa ca:

-- in pasul 1, extragem anii...
SELECT DISTINCT EXTRACT (YEAR FROM invoicedate )
FROM invoice
ORDER BY 1

-- ...  iar in pasul 2...
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2009 THEN total ELSE 0 END ) AS sales2009,
	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2010 THEN total ELSE 0 END ) AS sales2010,
	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2011 THEN total ELSE 0 END ) AS sales2011,
	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2012 THEN total ELSE 0 END ) AS sales2012,
	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2013 THEN total ELSE 0 END ) AS sales2013
FROM customer
	NATURAL JOIN invoice
GROUP BY lastname || ' ' || firstname, city, state, country
ORDER BY 1



-- ############################################################################
--             Extrageți artiștii cu o durată totală a pieselor
--                         mai mare de 100 de minute
-- ############################################################################
--      Find the artists with a total duration of their tracks larger
--                              than 100 minutes
-- ############################################################################

-- solutie bazata pe HAVING
SELECT artist.name AS artist_name,
	ROUND(SUM(milliseconds / 60000)) AS duration_minutes
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
GROUP BY artist.name
HAVING ROUND(SUM(milliseconds / 60000)) >= 100
ORDER BY artist.name




-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
-- ############################################################################

-- ############################################################################
--                   Extrageti numărul de clienți, pe țări
-- ############################################################################
--                   Extrageti numărul de clienți, pe țări
-- ############################################################################


-- Afisati numarul de piese din fiecare tracklist

-- Care este cel mai vandut gen muzical?

-- Care este angajatul cu cei mai multi subordonati directi ? (de ordinul 1)




-- ############################################################################
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
-- ############################################################################

select country, count(*) as n_of_cust
from customer
group by country
order by 2 desc
limit 7 ;


select c.lastname || ' ' || c.firstname as customer,
	sum(total) as sales2009
from customer c
	inner join invoice i on c.customerid =  i.customerid
where extract(year from invoicedate) = 2009
group by c.customerid
order by 1 ;


select title as titlu_album, album.albumid, count(*) as nr_piese
from artist
	inner join album on artist.artistid = album.artistid
	inner join track on track.albumid = album.albumid
where artist.name = 'U2'
group by title, album.albumid
having count(*) >= 12


select title as titlu_album, album.albumid, count(*) as nr_piese
from artist
	inner join album on artist.artistid = album.artistid
	inner join track on track.albumid = album.albumid
where artist.name = 'U2'
group by title, album.albumid
order by 3 desc
limit 5
