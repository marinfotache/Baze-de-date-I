-- 						Interogari SQL BD Chinook - IE si SPE:
--
-- 10: Expresii tabele
--
-- ultima actualizare: 2019-04-23




-- ############################################################################ 
-- 		Care sunt celelalte albume ale artistului sau formatiei care a 
--     				lansat albumul `Houses of the Holy` (reluare)
-- ############################################################################ 

-- solutie cu o expresie-tabela
WITH artist_anchor AS (
	SELECT artistid
	FROM album 
	WHERE album.title = 'Houses Of The Holy')
SELECT *
FROM album NATURAL JOIN artist_anchor



-- ############################################################################ 
-- 			Care sunt piesele comune (cu acelasi titlu) de pe 
-- 			albumele `Fear Of The Dark` si `A Real Live One`
-- 					ale formatiei 'Iron Maiden' (reluare)
-- ############################################################################ 


-- solutie cu doua expresii-tabela si jonctiune naturala
WITH tracks_1 AS (
	SELECT track.name 
	FROM artist 
		INNER JOIN album ON artist.artistid = album.artistid AND artist.name = 'Iron Maiden'
		INNER JOIN track ON album.albumid = track.albumid AND title = 'Fear Of The Dark'
				), 
	tracks_2 AS (
	SELECT track.name 
	FROM artist 
		INNER JOIN album ON artist.artistid = album.artistid AND artist.name = 'Iron Maiden'
		INNER JOIN track ON album.albumid = track.albumid AND title = 'A Real Live One'
				)
SELECT * FROM tracks_1 NATURAL JOIN tracks_2				



-- solutie cu aceleasi doua expresii-tabela si intersectie
WITH tracks_1 AS (
	SELECT track.name 
	FROM artist 
		INNER JOIN album ON artist.artistid = album.artistid AND artist.name = 'Iron Maiden'
		INNER JOIN track ON album.albumid = track.albumid AND title = 'Fear Of The Dark'
				), 
	tracks_2 AS (
	SELECT track.name 
	FROM artist 
		INNER JOIN album ON artist.artistid = album.artistid AND artist.name = 'Iron Maiden'
		INNER JOIN track ON album.albumid = track.albumid AND title = 'A Real Live One'
				)
SELECT * FROM tracks_1 
INTERSECT
SELECT * FROM tracks_2				


-- solutie cu doua expresii-tabela `inlantuite`
WITH 
	-- prima expresie-tabela extrage piesele de pe albumul `Fear Of The Dark` 
	tracks_album1 AS (
	SELECT track.name 
	FROM artist 
		INNER JOIN album ON artist.artistid = album.artistid AND artist.name = 'Iron Maiden'
		INNER JOIN track ON album.albumid = track.albumid AND title = 'Fear Of The Dark'
				),
	-- a doua expresie tabela o foloseste pe prima
	common_tracks AS (
	SELECT track.name 
	FROM artist 
		INNER JOIN album ON artist.artistid = album.artistid AND artist.name = 'Iron Maiden'
		INNER JOIN track ON album.albumid = track.albumid AND title = 'A Real Live One'
	WHERE track.name IN (SELECT name FROM tracks_album1)  -- aici e referinta la prima expresie-tabela	
				)
SELECT * 
FROM common_tracks 




-- ############################################################################ 
-- 		Care sunt albumele formatiei Led Zeppelin care au mai multe piese
--                  decat albumul `IV` (reluare) 
-- ############################################################################ 

-- solutie bazata pe o expresie tabela
WITH nr_piese_IV AS (
	SELECT COUNT(*) AS nr_piese
	FROM album
		NATURAL JOIN artist
		INNER JOIN track on album.albumid = track.albumid	
	WHERE artist.name = 'Led Zeppelin' AND title = 'IV')
SELECT title, COUNT(*) AS n_of_tracks
FROM album
	NATURAL JOIN artist
	INNER JOIN track on album.albumid = track.albumid	
WHERE artist.name = 'Led Zeppelin'
GROUP BY title
HAVING COUNT(*) > (SELECT nr_piese FROM nr_piese_IV)




-- ############################################################################ 
-- 			Afisati, pentru fiecare client, pe coloane separate, 
-- 					vanzarile pe anii 2010, 2011 si 2012 (reluare)
-- ############################################################################ 

-- solutie bazata pe jonctiunea externa a tabelei `customer` cu trei expresii-tabela
WITH 
	sales2010 AS (SELECT customerid, SUM(total) AS sales
		 	 FROM invoice 
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2010
		 	 GROUP BY customerid),
	sales2011 AS (SELECT customerid, SUM(total) AS sales
		 	 FROM invoice 
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2011
		 	 GROUP BY customerid),
	sales2012 AS (SELECT customerid, SUM(total) AS sales
		 	 FROM invoice 
		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2012
		 	 GROUP BY customerid)
SELECT lastname || ' ' || firstname AS customer_name, 
	city, state, country,
	COALESCE(sales2011.sales, 0) AS sales2010, 
	COALESCE(sales2011.sales, 0) AS sales2011, 
	COALESCE(sales2012.sales, 0) AS sales2012 	
FROM customer 
	LEFT JOIN sales2010 ON customer.customerid = sales2010.customerid 
	LEFT JOIN sales2011 ON customer.customerid = sales2011.customerid 
	LEFT JOIN sales2012 ON customer.customerid = sales2012.customerid 
ORDER BY 1



-- ############################################################################ 
--  	Afisati ponderea fiecarei luni in vanzarile anului 2010 (reluare)
-- ############################################################################ 

-- solutie bazata pe trei expresii tabela
WITH 
	all_months AS (SELECT CAST (month AS NUMERIC) AS month
				   FROM generate_series (1, 12, 1) months (month)),
	sales_2010 AS (SELECT SUM(total) AS sales2010 
				   FROM invoice WHERE 
				   EXTRACT (YEAR FROM invoicedate) = 2010),
	monthly_sales_2010 AS (SELECT CAST (EXTRACT (MONTH FROM invoicedate) AS NUMERIC) AS month, 
						   		SUM(total) AS monthly_sales
	 	 				    FROM invoice 
	 	 					WHERE EXTRACT (YEAR FROM invoicedate) = 2010  
						   GROUP BY EXTRACT (MONTH FROM invoicedate) )
SELECT all_months.month, monthly_sales_2010.monthly_sales,
	sales_2010.sales2010, 
	ROUND (monthly_sales_2010.monthly_sales / sales_2010.sales2010, 2) AS month_share
FROM all_months
	LEFT JOIN monthly_sales_2010 ON all_months.month = monthly_sales_2010.month
	INNER JOIN sales_2010 ON 1 = 1   -- here's a sort of a CROSS JOIN 
		 					 		   

	 
	 

-- ############################################################################ 
-- 					Care este albumul (sau albumele) formatiei Queen 
--   					cu cele mai multe piese? (reluare)
-- ############################################################################ 

-- solutie bazata pe doua expresii tabela `inlantuite`
WITH 
	queen_albums_and_n_of_tracks AS 
		(SELECT title, COUNT(*) AS n_of_tracks
	 	 FROM album
			NATURAL JOIN artist
			INNER JOIN track on album.albumid = track.albumid	
	 	 WHERE artist.name = 'Queen'
	 	 GROUP BY title),
	-- the second table expression refers to the first one
	queen_max_n_of_tracks AS 
		(SELECT MAX(n_of_tracks) AS n_of_tracks
		 FROM queen_albums_and_n_of_tracks)
SELECT *
FROM queen_albums_and_n_of_tracks NATURAL JOIN  queen_max_n_of_tracks 
ORDER BY 1




--
-- ############################################################################ 
-- 						Diviziune relationala (3)
-- ############################################################################ 
--


-- ############################################################################ 
-- 	 Care sunt artistii `vanduti` in toate orasele din 'United Kingdom' din
--  					care provin clientii (reluare)
-- ############################################################################ 

-- solutie bazata pe expresii-tabela
WITH 
	cities_uk AS (SELECT DISTINCT city FROM customer WHERE country IN ('United Kingdom')),
	cross_join__artists__cities_uk AS (
		SELECT artist.name AS artist_name, city
		FROM artist CROSS JOIN cities_uk),
	artists__cities_uk AS (
		SELECT DISTINCT artist.name AS artist_name, city
		FROM artist
			NATURAL JOIN album
			INNER JOIN track on album.albumid = track.albumid	
			INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
			INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
			NATURAL JOIN customer 
		WHERE city IN (SELECT city FROM cities_uk)
			)	
SELECT artist.name AS artist_name
FROM artist
EXCEPT
SELECT DISTINCT artist_name
FROM cross_join__artists__cities_uk
WHERE artist_name || ' - ' || city NOT IN (
	SELECT artist_name || ' - ' || city
	FROM artists__cities_uk )
ORDER BY 1




-- ############################################################################ 
-- 						La ce intrebari raspund urmatoarele interogari ?
-- ############################################################################ 


with n_of_tracks_u2 as
	(select title as album_title, artist.name as artist_name, 
		count(*) as n_of_tracks
	from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
	where artist.name = 'U2'
	group by title, artist.name)
select *
from n_of_tracks_u2
where n_of_tracks >= 
	(select n_of_tracks
     from n_of_tracks_u2
     where album_title = 'Pop') ;



with sales_artists_years as (
select artist.name as artist_name, 
		extract (year from invoicedate) as year,
    	sum(quantity * invoiceline.unitprice) as sales
	from invoice
		inner join invoiceline on invoice.invoiceid = invoiceline.invoiceid
		inner join track on invoiceline.trackid = track.trackid
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid
	where extract (year from invoicedate) between 2011 and 2013
	group by artist.name, extract (year from invoicedate) )
select artist.name as artist_name, 
	coalesce(say2011.sales, 0) as sales_2011,
	coalesce(say2012.sales, 0) as sales_2012,
	coalesce(say2013.sales, 0) as sales_2013, 
    coalesce(say2011.sales, 0) + coalesce(say2012.sales, 0) +
    coalesce(say2013.sales, 0) as total
from artist
	left outer join sales_artists_years say2011 
    	on artist.name = say2011.artist_name and say2011.year = 2011
	left outer join sales_artists_years say2012 
    	on artist.name = say2012.artist_name and say2012.year = 2012
	left outer join sales_artists_years say2013 
    	on artist.name = say2013.artist_name and say2013.year = 2013
	union 
select 'total', 
	(select sum(sales) from sales_artists_years where year = 2011),
	(select sum(sales) from sales_artists_years where year = 2012),
	(select sum(sales) from sales_artists_years where year = 2013),
	0
order by 1 ;
    


with top_5 as
	(select  sum(quantity) as quantity_sold
	from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
		inner join invoiceLine on invoiceLine.trackid = track.trackid  
	group by track.name, title, artist.name
	order by quantity_sold desc
	limit 5) 
select track.name as track_name, 
	title as album_title, artist.name as artist_name, 
    sum(quantity) as quantity_sold
from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
		inner join invoiceLine on invoiceLine.trackid = track.trackid  
group by track.name, title, artist.name
having sum(quantity) >= 
	(select min(quantity_sold)
     from top_5)
order by quantity_sold desc





with top_9_u2 as
	(select milliseconds / 1000 as duration_seconds
	from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
	where artist.name = 'U2'
	order by milliseconds desc
	limit 9)
select track.name as track_name, 
	title as album_title, artist.name as artist_name,
    milliseconds / 1000 as duration_seconds
from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
where artist.name = 'U2' and milliseconds / 1000 >=
	(select min(duration_seconds)
     from top_9_u2)          
order by milliseconds desc


    


