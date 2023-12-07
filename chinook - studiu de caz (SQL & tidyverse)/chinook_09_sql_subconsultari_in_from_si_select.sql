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
-- 					SQL09: Subconsultări în clauzele FROM și SELECT.
--								Diviziune relațională (2)
-- 					SQL09: Subqueries included in FROM and SELECT.
--								Relational division (2)
-- ############################################################################
-- ultima actualizare / last update: 2022-03-15


--
-- ############################################################################
--                      Subconsultări în clauza FROM
-- ############################################################################
--                  Subqueries included on clause FROM
-- ############################################################################
--

-- ############################################################################
--        Care sunt celelalte albume ale artistului sau formației care a
--                   lansat albumul `Houses of the Holy` (reluare)
-- ############################################################################
--        List the other albums of the artist/band that released
--                     the album `Houses of the Holy`  (reprise)
-- ############################################################################

-- solutie bazata pe o subconsultare in clauza FROM, care include albumul
-- 'Houses Of The Holy' si numele artistului
SELECT *
FROM (
		SELECT artistid
	  FROM album
	  WHERE title = 'Houses Of The Holy'
	  ) artist_anchor
	  		NATURAL JOIN album
				NATURAL JOIN artist


-- ############################################################################
-- 			Care sunt piesele comune (cu acelasi titlu) de pe
-- 			albumele `Fear Of The Dark` si `A Real Live One`
-- 					ale formatiei 'Iron Maiden' (reluare)
-- ############################################################################
-- 			Extract the tracks (track name) included on both `Fear Of The Dark` and
--  `A Real Live One` albums released by 'Iron Maiden' (the common tracks of
--      both albums) (reprise)
-- ############################################################################

-- solutie noua, bazata pe subconsultare in clauza FROM
SELECT *
FROM
	(SELECT track.name
	 FROM artist
			INNER JOIN album ON artist.artistid = album.artistid
			INNER JOIN track ON album.albumid = track.albumid
	 WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark'
 ) tracks_album_1
					NATURAL JOIN
	(SELECT track.name
	 FROM artist
			INNER JOIN album ON artist.artistid = album.artistid
				INNER JOIN track ON album.albumid = track.albumid
	WHERE artist.name = 'Iron Maiden' AND title = 'A Real Live One'
	) tracks_album_2



-- ############################################################################
--             Care sunt facturile din prima zi de vânzări? (reluare)
-- ############################################################################
--          Extract invoices issued in the first day with sales (reprise)
-- ############################################################################

-- solutie bazata pe o subconsultare in clauza FROM
SELECT *
FROM invoice NATURAL JOIN
	(SELECT MIN(invoicedate) AS invoicedate
	 FROM invoice) X



-- ############################################################################
--        Care sunt facturile din prima săptămână de vânzări? (reluare)
-- ############################################################################
--     List invoices issued in the first week since the sales begun (reprise)
-- ############################################################################

-- o solutie  bazata pe o subconsultare in clauza FROM care, la randul sau,
--   include doua subconsultari in clauza WHERE
SELECT *
FROM invoice
		NATURAL JOIN
			(
				SELECT DISTINCT invoicedate
	 			FROM invoice
	 			WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND
							(SELECT MIN(invoicedate) + INTERVAL '7 DAYS' FROM invoice)
			)  X




-- ############################################################################
--      Care sunt albumele formației Led Zeppelin care au mai multe piese
--                            decât albumul `IV`? (reluare)
-- ############################################################################
--      List the albums released by Led Zeppelin with more tracks than
--                            the album `IV` (reprise)
-- ############################################################################

-- solutie care transforma grupurile in tupluri (inregistrari) si
--   apoi le (theta-)jonctioneaza
SELECT *
FROM (SELECT title AS album_title, COUNT(*) AS n_of_tracks
	  FROM album
		NATURAL JOIN artist
		INNER JOIN track on album.albumid = track.albumid
	  WHERE artist.name = 'Led Zeppelin'
	  GROUP BY title
	 	) albums_lz
			INNER JOIN   -- HERE IS A THETA-JOIN (in case you missed it !!!)
	(SELECT COUNT(*) AS n_of_tracks_lz_4
	 FROM album
		NATURAL JOIN artist
		INNER JOIN track on album.albumid = track.albumid
	WHERE artist.name = 'Led Zeppelin' AND title = 'IV') lz_4
			ON albums_lz.n_of_tracks > lz_4.n_of_tracks_lz_4
ORDER BY 1




-- ############################################################################
--               Afișați, pentru fiecare client, pe coloane separate,
--                     vânzările pe anii 2010, 2011 și 2012 (3)
-- ############################################################################
--             Display, for each customer, on three different columns,
--                     the total sales on 2010, 2011 și 2012  (3)
-- ############################################################################

-- solutie bazata pe subconsultari in clauza FROM
SELECT lastname || ' ' || firstname AS customer_name,
	city, state, country,
	COALESCE(sales2011.sales, 0) AS sales2010,
	COALESCE(sales2011.sales, 0) AS sales2011,
	COALESCE(sales2012.sales, 0) AS sales2012
FROM customer
	LEFT JOIN
			(SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2010
		 	 GROUP BY customerid) sales2010
		ON customer.customerid = sales2010.customerid
	LEFT JOIN
			(SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2011
		 	 GROUP BY customerid) sales2011
		ON customer.customerid = sales2011.customerid
	LEFT JOIN
			(SELECT customerid, SUM(total) AS sales
		 	 FROM invoice
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2012
		 	 GROUP BY customerid) sales2012
		ON customer.customerid = sales2012.customerid
ORDER BY 1



-- ############################################################################
--   Calculați ponderea fiecărei luni calendaristice în vânzările anului 2010
-- ############################################################################
--         Find the share (percentage) of each month for the 2010 sales
-- ############################################################################

-- solutia afiseaza toate lunile anului, chiar si cele fara vanzari
SELECT months.month, monthly_sales, sales_2010,
	ROUND (monthly_sales / sales_2010, 2) AS month_share
FROM
	(
		SELECT CAST (month AS NUMERIC) AS month FROM generate_series (1, 12, 1) months (month)
	) months
						LEFT JOIN
		(
			SELECT CAST (EXTRACT (MONTH FROM invoicedate) AS NUMERIC) AS month, SUM(total) AS monthly_sales
	 	  FROM invoice
	 	  WHERE EXTRACT (YEAR FROM invoicedate) = 2010
		  GROUP BY EXTRACT (MONTH FROM invoicedate)
		)  monthly_sales
						ON months.month = monthly_sales.month
	CROSS JOIN
		(SELECT SUM(total) AS sales_2010 FROM invoice WHERE EXTRACT (YEAR FROM invoicedate) = 2010) sales2010



-- ############################################################################
--              Care este albumul (sau albumele) formației Queen
--                       cu cele mai multe piese? (reluare)
-- ############################################################################
--                List the album (or albums) released by `Queen`
--                  having the largest number of tracks (reprise)
-- ############################################################################


-- solutie bazata subconsultari pe mai multe niveluri in clauza FROM

SELECT *
FROM    -- first FROM subquery
		(SELECT title, COUNT(*) AS n_of_tracks
	 	 FROM album
			NATURAL JOIN artist
			INNER JOIN track on album.albumid = track.albumid
	 	 WHERE artist.name = 'Queen'
	 	 GROUP BY title) queen_albums_and_n_of_tracks
	NATURAL JOIN
		-- second FROM subquery
		(SELECT MAX(n_of_tracks) AS n_of_tracks
		 FROM
			-- here is a FROM sub-sub query
			(SELECT COUNT(*) AS n_of_tracks
	 		 FROM album
			 	NATURAL JOIN
			 		-- here is FROM sub-sub-sub query
	 				(SELECT artistid FROM artist WHERE name = 'Queen') queen_id
			 	NATURAL JOIN track
	 		 GROUP BY title) n_of_tracks_on_queen_albums
	 	) queen_max_n_of_tracks
ORDER BY 1



-- ############################################################################
--                       Diviziune relațională (2)
-- ############################################################################
--                         Relational division (2)
-- ############################################################################


-- ############################################################################
--    Care sunt artiștii cu vânzări în toate orașele din 'United Kingdom' din
--                          care provin clienții (reluare)
-- ############################################################################
--    Find the artist with sales in all the 'United Kingdom' cities where is
--                          at least one customer (reprise)
-- ############################################################################


-- solutie `pur divizionala` (fara nicio grupare):
-- idee dintre toti artistii ii eliminat pe cei care nu apar in toate
--   combinatiile posibile (obtinute prin CROSS-JOIN) `artist`-`oras`
SELECT  artist.name AS artist_name
FROM artist
EXCEPT
SELECT DISTINCT artist_name
FROM
	(SELECT artist.name AS artist_name, city
	FROM artist CROSS JOIN
	 	(SELECT DISTINCT city FROM customer WHERE country IN ('United Kingdom') ) cities
	) cross_join_artists_cities
WHERE artist_name || ' - ' || city NOT IN (
	SELECT DISTINCT artist.name || ' - ' || city
	FROM artist
		NATURAL JOIN album
		INNER JOIN track on album.albumid = track.albumid
		INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
		INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
		NATURAL JOIN customer
	WHERE country IN ('United Kingdom')	)
ORDER BY 1




-- ############################################################################
-- 	 Care sunt artiștii cu vânzări în toate țările din urmatorul set:
--  ('USA', 'France', 'United Kingdom', 'Spain') (reluare)
-- ############################################################################
-- 	 Find the artists with sales in ALL of the countries from the following set:
--  ('USA', 'France', 'United Kingdom', 'Spain') (reprise)
-- ############################################################################

-- o alta solutie `non-divizionala`
SELECT artist.name, COUNT(DISTINCT country) AS n_of_countries
FROM artist
	NATURAL JOIN album
	INNER JOIN track on album.albumid = track.albumid
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	NATURAL JOIN customer
	NATURAL JOIN
		(VALUES ('USA'), ('France'), ('United Kingdom'), ('Spain')) selected_coutries (country)
GROUP BY artist.name
HAVING COUNT(DISTINCT country) = 4


-- o solutie ce foloseste diviziunea
SELECT artist.name
FROM artist
EXCEPT
SELECT artist_name
FROM
	(SELECT name AS artist_name
	FROM artist) artist_name
		CROSS JOIN
	(SELECT CAST (country AS VARCHAR(40)) AS country
	 FROM
		(VALUES ('USA'), ('France'), ('United Kingdom'), ('Spain')) selected_coutries (country)) sel_countries
WHERE artist_name || ' - ' || country NOT IN (
	SELECT artist.name || ' - ' || country
	FROM artist
		NATURAL JOIN album
		INNER JOIN track on album.albumid = track.albumid
		INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
		INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
		NATURAL JOIN customer)



-- ############################################################################
-- 	 Care sunt artiștii cu vânzări în toți anii (adică, în fiecare an) din
--                        intervalul 2009-2012
-- ############################################################################
-- 	 Find the artists with sales all ALL years in 2009-2012 range
-- ############################################################################


-- solutie `pur divizionala` :
SELECT artist.name AS artist
FROM artist
EXCEPT
SELECT artist_name
FROM
	(SELECT name AS artist_name FROM artist) artists
		CROSS JOIN
	(SELECT *
	 FROM generate_series (2009, 2012, 1)) years (year)
WHERE artist_name || ' - ' || year NOT IN (
	SELECT DISTINCT artist.name || ' - ' || EXTRACT (YEAR FROM invoicedate)
	FROM artist
		NATURAL JOIN album
		INNER JOIN track on album.albumid = track.albumid
		INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
		INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	)




-- ############################################################################
-- 	 Care sunt artiștii pentru care au fost vânzări măcar (cel puțin)
--          în toți anii în care s-au vândut piese ale formației `Queen`
-- ############################################################################
-- 	 Find the artists with sales in at least all the sales years of `Queen`
-- ############################################################################

-- solutie `non-divizionala` :
SELECT name
FROM
	(SELECT DISTINCT EXTRACT (YEAR FROM invoicedate) AS year
	 FROM
		artist
		 	INNER JOIN album ON artist.artistid = album.artistid
			INNER JOIN track ON album.albumid = track.albumid
			INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
			INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	 WHERE artist.name = 'Queen') years_queen
			INNER JOIN
	(SELECT DISTINCT artist.name, EXTRACT (YEAR FROM invoicedate) AS year
	 FROM
		artist
		 	INNER JOIN album ON artist.artistid = album.artistid
			INNER JOIN track ON album.albumid = track.albumid
			INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
			INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	 ) years_queen__artists ON years_queen.year = years_queen__artists.year
GROUP BY name
HAVING COUNT(years_queen__artists.year) = (
	SELECT COUNT(*)
	FROM
		(SELECT DISTINCT EXTRACT (YEAR FROM invoicedate) AS year
		 FROM
			artist
		 		INNER JOIN album ON artist.artistid = album.artistid
				INNER JOIN track ON album.albumid = track.albumid
				INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
				INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	 	WHERE artist.name = 'Queen') years_queen
	)




-- solutie `pur divizionala` :
SELECT artist.name AS artist
FROM artist
EXCEPT
SELECT artist_name
FROM
	(SELECT name AS artist_name FROM artist) artists
		CROSS JOIN
	(SELECT DISTINCT EXTRACT (YEAR FROM invoicedate) AS year
	 FROM invoice
	 	NATURAL JOIN invoiceline
	 	NATURAL JOIN track
	 WHERE albumid IN (SELECT albumid
					   FROM album NATURAL JOIN artist
					    WHERE name = 'Queen')) years_u2
WHERE artist_name || ' - ' || year NOT IN (
	SELECT DISTINCT artist.name || ' - ' || EXTRACT (YEAR FROM invoicedate)
	FROM artist
		INNER JOIN album ON artist.artistid = album.artistid
		INNER JOIN track ON album.albumid = track.albumid
		INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
		INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
	)





-- ############################################################################
--                      Subconsultări incluse în clauza SELECT
-- ############################################################################
--                      Subqueries included in SELECT clause
-- ############################################################################


-- ############################################################################
--   Calculați ponderea fiecărei luni calendaristice în vânzările anului 2010
-- ############################################################################
--         Find the share (percentage) of each month for the 2010 sales
-- ############################################################################

SELECT month, monthly_sales,
	(SELECT SUM(total) FROM invoice WHERE EXTRACT (YEAR FROM invoicedate) = 2010) AS sales_2010,
	ROUND(monthly_sales / (SELECT SUM(total) FROM invoice WHERE EXTRACT (YEAR FROM invoicedate) = 2010),2)
FROM
	(SELECT EXTRACT (MONTH FROM invoicedate) AS month, SUM(total) AS monthly_sales
 	 FROM invoice
	 WHERE EXTRACT (YEAR FROM invoicedate) = 2010
	 GROUP BY EXTRACT (MONTH FROM invoicedate)) x




--
-- ############################################################################
--                Subconsultări CORELATE în clauza SELECT
-- ############################################################################
--                Correlated subqueries included in SELECT clase
-- ############################################################################


-- ############################################################################
--        Extrageți numărul albumelor lansate de fiecare artist (reluare)
-- ############################################################################
--        Display the number of albums released by each artist (reprise)
-- ############################################################################

-- solutie fara jonctiune si fara grupare
SELECT name AS artist_name,
	(SELECT COUNT(*) FROM album WHERE artistid = artist.artistid) AS n_of_albums
FROM artist
ORDER BY 1


-- ############################################################################
--               Afișați, pentru fiecare client, pe coloane separate,
--                     vânzările pe anii 2010, 2011 și 2012 (4)
-- ############################################################################
--             Display, for each customer, on three different columns,
--                     the total sales on 2010, 2011 și 2012  (4)
-- ############################################################################

-- solutie fara jonctiune si fara grupare
SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
	(SELECT SUM(total) FROM invoice WHERE customerid = customer.customerid
	 	AND EXTRACT (YEAR FROM invoicedate) = 2010) AS sales2010,
	(SELECT SUM(total) FROM invoice WHERE customerid = customer.customerid
	 	AND EXTRACT (YEAR FROM invoicedate) = 2011) AS sales2011,
	(SELECT SUM(total) FROM invoice WHERE customerid = customer.customerid
	 	AND EXTRACT (YEAR FROM invoicedate) = 2012) AS sales2012
FROM customer
ORDER BY 1, 2, 3, 4




-- ############################################################################
--   Calculați ponderea fiecărei luni calendaristice în vânzările anului său
-- ############################################################################
--  Find the share (percentage) of each month for the total sales of its year
-- ############################################################################


SELECT year, month, monthly_sales,
	(SELECT SUM(total) FROM invoice
	 WHERE EXTRACT (YEAR FROM invoicedate) = x.year ) AS sales_year,
	ROUND(monthly_sales /
		  (SELECT SUM(total) FROM invoice
		   WHERE EXTRACT (YEAR FROM invoicedate) = x.year),2)
FROM
	(SELECT
	 	EXTRACT (YEAR FROM invoicedate) AS year,
	 	EXTRACT (MONTH FROM invoicedate) AS month,
	 SUM(total) AS monthly_sales
 	 FROM invoice
	 GROUP BY EXTRACT (YEAR FROM invoicedate), EXTRACT (MONTH FROM invoicedate)) x
ORDER BY 1, 2




-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
-- ############################################################################

-- ...

-- ############################################################################
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
-- ############################################################################

select *
from (select e.lastname, e.firstname, birthdate, age(current_date, birthdate) as age
	from employee e) x ;


select *
from employee inner join
	(select min(birthdate) as min_bd from employee) x
		on employee.birthdate = x.min_bd ;


select *
from
	(select i.invoiceid, total, sum(quantity * unitprice) as lines_total
	from invoice i inner join invoiceline il on i.invoiceid = il.invoiceid
	group by i.invoiceid) x
where total <> lines_total
order by 1 ;


select country, count(*) as n_of_cust
from customer
group by country
having count(*) >=
	(select min (n_of_cust)
	from
		(select distinct count(*) as n_of_cust
		from customer
		group by country
		order by 1 desc
		limit 5) x
	)
order by 2 desc ;


select *
from (
    select title as album_title, artist.name as artist_name,
		count(*) as n_of_tracks
	from track
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid
	where artist.name = 'U2'
	group by title, artist.name) n_of_tracks_u2
where n_of_tracks_u2.n_of_tracks >= 12 ;


select *
from (select title as album_title, artist.name as artist_name,
		count(*) as n_of_tracks
	from track
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid
	where artist.name = 'U2'
	group by title, artist.name) n_of_tracks_u2
    	INNER JOIN
        (select count(*) AS n_of_tracks
	 	 from track
			inner join album on track.albumid = album.albumid
			inner join artist on album.artistid = artist.artistid
	 	 where artist.name = 'U2' and title = 'Pop') n_of_tracks_pop
        ON  n_of_tracks_u2.n_of_tracks >= n_of_tracks_pop.n_of_tracks ;
