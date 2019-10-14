-- 						Interogari SQL BD Chinook - IE si SPE:
--
-- 08: Subconsultari in clauzele WHERE si HAVING. Diviziune relationala (1)
--
-- ultima actualizare: 2019-04-16


--
-- ############################################################################ 
-- 							Subconsultari in clauza WHERE 
-- ############################################################################ 
--

-- ############################################################################ 
-- 		Care sunt celelalte albume ale artistului sau formatiei care a 
--     				lansat albumul `Houses of the Holy`
-- ############################################################################ 


-- solutie bazata pe auto-jonctiune, care include albumul 'Houses Of The Holy'
select album2.*, artist.name as artist_name
from album album1 
	inner join artist on album1.artistid = artist.artistid
		and album1.title = 'Houses Of The Holy'
	inner join album album2 on album1.artistid = album2.artistid
order by 2

-- solutie bazata pe auto-jonctiune, care exclude albumul 'Houses Of The Holy'
select album2.*, artist.name as artist_name
from album album1 
	inner join artist on album1.artistid = artist.artistid
		and album1.title = 'Houses Of The Holy'
	inner join album album2 on album1.artistid = album2.artistid
where album2.title <> 'Houses Of The Holy'
order by 2


-- solutie bazata pe o subconsultare in clauza WHERE, care include albumul 
-- 'Houses Of The Holy', dar nu si numele artistului
select *
from album 
where artistid in (select artistid from album where title = 'Houses Of The Holy')


-- solutie bazata pe o subconsultare in clauza WHERE, care include albumul 
-- 'Houses Of The Holy' si numele artistului
select *
from album natural join artist
where artistid in (select artistid from album where title = 'Houses Of The Holy')


-- solutie bazata pe o subconsultare in clauza WHERE, care nu include albumul 
-- 'Houses Of The Holy', insa include numele artistului
select *
from album natural join artist
where artistid in (select artistid from album where title = 'Houses Of The Holy')
	and title <> 'Houses Of The Holy'
order by 2



-- ############################################################################ 
-- 		Care sunt piesele de pe albumul `Achtung Baby` al formatiei U2?
-- ############################################################################ 


-- solutie anterioara - folosind INNER JOINs 
select track.*
from album 
	natural join artist
	inner join track on album.albumid = track.albumid
where artist.name = 'U2' and title = 'Achtung Baby'


-- solutie noua - folosind un lant de subconsultari in clauza WHERE
select *
from track
where albumid in (select albumid
				  from album
				  where title = 'Achtung Baby' and 
						artistid in (select artistid
								    from artist
								    where name = 'U2'))


-- solutie care foloseste doar o subconsultare in clauza WHERE
select *
from track
where albumid in (select albumid
				from album natural join artist
				where title = 'Achtung Baby' and name = 'U2')



-- ############################################################################ 
-- 			Care sunt piesele comune (cu acelasi titlu) de pe 
-- 			albumele `Fear Of The Dark` si `A Real Live One`
-- 					ale formatiei 'Iron Maiden' (reluare)
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
-- 				  Care sunt facturile din prima zi de vanzari?
-- ############################################################################ 

-- solutie bazata pe o subconsultare ce foloseste functia MIN
SELECT *
FROM invoice 
WHERE invoicedate = (SELECT MIN(invoicedate) 
					FROM invoice)

-- solutie ce evita functia MIN (prin operatorul ALL)
SELECT *
FROM invoice 
WHERE invoicedate <= ALL (SELECT DISTINCT invoicedate
					      FROM invoice
					      ORDER BY invoicedate
					       )



-- ############################################################################ 
-- 				Care sunt facturile din prima saptamana de vanzari?
-- ############################################################################ 
SELECT *
FROM invoice 
WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND 
	(SELECT MIN(invoicedate) + INTERVAL '6 DAYS' FROM invoice) 		


-- ############################################################################ 
-- 				Care sunt facturile din prima luna de vanzari?
-- ############################################################################ 
SELECT *
FROM invoice 
WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND 
	(SELECT MIN(invoicedate) + INTERVAL '1 MONTH' - INTERVAL '1 DAYS' FROM invoice) 		


-- ############################################################################ 
-- 		   Cate facturi s-au emis in prima luna calendaristica a vanzarilor ?
--    (adica prima luna IANUARIE sau APRILIE ...)
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
-- 		   Cate facturi s-au emis in primele 10 zile cu vanzari ?
-- ############################################################################ 

-- solutie bazata pe o subconsultare in clauza WHERE care prezinta LIMIT si 
--    SELECT DISTINCT (atentie, DISTINCT este obligatorie!);
-- conectorul dintre interogarea principale si subconsultare este IN
SELECT *
FROM invoice 
WHERE invoicedate IN (select distinct invoicedate
					   from invoice
					   order by invoicedate
					   limit 10
					   )

-- aceeasi solutie, insa cu FETCH
SELECT *
FROM invoice 
WHERE invoicedate IN (select distinct invoicedate
					  from invoice
					  order by invoicedate
					  fetch first 10 rows only
					   )


-- o solutie ce foloseste ANY
SELECT *
FROM invoice 
WHERE invoicedate <= ANY (
					   select distinct invoicedate
					   from invoice
					   order by invoicedate
					   limit 10
					   )

-- o solutie ce foloseste OFFSET si LIMIT pentru a determina a 10-a valoare a `invoicedate`
SELECT *
FROM invoice 
WHERE invoicedate <=  (select distinct invoicedate
					   from invoice
					   order by invoicedate
					   offset 9
					   limit 1
					   )



-- ############################################################################ 
-- 		      Care sunt cei mai vechi cinci angajati ai companiei?  
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
-- 							Subconsultari in clauza HAVING 
-- ############################################################################ 
--

-- ############################################################################ 
-- 		Care sunt albumele formatiei Led Zeppelin care au mai multe piese
--                  decat albumul `IV`  
-- ############################################################################ 

-- solutie bazata pe o subsonsultare in clauza HAVING
SELECT title, COUNT(*) AS n_of_tracks
FROM album
	NATURAL JOIN artist
	INNER JOIN track on album.albumid = track.albumid	
WHERE artist.name = 'Led Zeppelin'
GROUP BY title
HAVING COUNT(*) > (SELECT COUNT(*)
					 FROM album
					  	NATURAL JOIN artist
						INNER JOIN track on album.albumid = track.albumid	
					 WHERE artist.name = 'Led Zeppelin' AND title = 'IV')
ORDER BY 1



-- ############################################################################ 
-- 		Care este albumul (sau albumele) formatiei Queen 
--   					cu cele mai multe piese? 
-- ############################################################################ 


-- solutie bazata pe `>= ALL`
SELECT title, COUNT(*) AS n_of_tracks
FROM album
	NATURAL JOIN artist
	INNER JOIN track on album.albumid = track.albumid	
WHERE artist.name = 'Queen'
GROUP BY title
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
					 FROM album
					  	NATURAL JOIN artist
						INNER JOIN track on album.albumid = track.albumid	
					 WHERE artist.name = 'Queen'
					 GROUP BY title  )
ORDER BY 1


-- solutie bazata pe LIMIT
SELECT title, COUNT(*) AS n_of_tracks
FROM album
	NATURAL JOIN artist
	INNER JOIN track on album.albumid = track.albumid	
WHERE artist.name = 'Queen'
GROUP BY title
HAVING COUNT(*) =  (SELECT COUNT(*)
					 FROM album
					  	NATURAL JOIN artist
						INNER JOIN track on album.albumid = track.albumid	
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
	INNER JOIN track on album.albumid = track.albumid	
WHERE artist.name = 'U2'
GROUP BY title
ORDER BY 2 DESC
LIMIT 7

-- solutie corecta
SELECT title, COUNT(*) AS n_of_tracks
FROM album
	NATURAL JOIN artist
	INNER JOIN track on album.albumid = track.albumid	
WHERE artist.name = 'U2'
GROUP BY title
HAVING COUNT(*) IN (
		SELECT COUNT(*) AS n_of_tracks
		FROM album
			NATURAL JOIN artist
			INNER JOIN track on album.albumid = track.albumid	
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
	INNER JOIN track on album.albumid = track.albumid	
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
GROUP BY artist.name, title
HAVING artist.name || ' - ' || title || ' - ' || COUNT(DISTINCT track.trackid) IN (
	SELECT artist.name || ' - ' || title || ' - ' || COUNT(track.trackid) 
	FROM artist
		NATURAL JOIN album
		INNER JOIN track on album.albumid = track.albumid	
	GROUP BY artist.name, title
	HAVING COUNT(track.trackid) >= 2)
ORDER BY 1


-- solutia urmatoare se apropie de logica diviziunii
SELECT artist.name, title, 
	string_agg(DISTINCT CAST(track.trackid AS VARCHAR), 
							 '|' ORDER BY CAST(track.trackid AS VARCHAR)) 
							 AS all_tracks_from_this_album,
	string_agg(DISTINCT CAST(invoiceline.trackid AS VARCHAR), 
							 '|' ORDER BY CAST(invoiceline.trackid AS VARCHAR)) 
							 AS sold_tracks_from_the_album
FROM artist
	NATURAL JOIN album
	INNER JOIN track on album.albumid = track.albumid
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
	INNER JOIN track on album.albumid = track.albumid	
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
	INNER JOIN track on album.albumid = track.albumid	
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
	INNER JOIN track on album.albumid = track.albumid	
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
	INNER JOIN track on album.albumid = track.albumid	
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
	INNER JOIN track on album.albumid = track.albumid	
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
-- 						Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################ 

-- Care primul (sau primii) angajat(i) in companie?

-- Care sunt artistii care au in baza de date mai multe albume decat formatia `Queen`?




-- ############################################################################ 
-- 						La ce intrebari raspund urmatoarele interogari ?
-- ############################################################################ 


select *
from employee
where birthdate = 
	(select min(birthdate) from employee)  ;


select e.lastname, e.firstname, birthdate, age(current_date, birthdate) as age 
from employee e
where age(current_date, birthdate) = 
	(select max(age(current_date, birthdate)) from employee)  ;
	
	
select name as artist_name
from artist 
where name in (
	select title
	from album) 
order by 1 ;
	

select title, name
from album inner join artist on artist.artistid = album.artistid
where albumid in (
	select albumid
	from track
	where name = 'Amazing') ;


select artist.name as artist_name, title, track.name as track_name
from album 
	inner join artist on artist.artistid = album.artistid
	inner join track on album.albumid = track.albumid
where album.albumid in (
	select albumid
	from track
	where name = 'Amazing')
order by 1, 2, 3 ;


select artist.name as artist_name, title, track.name as track_name, milliseconds
from album 
	inner join artist on artist.artistid = album.artistid
	inner join track on album.albumid = track.albumid
where   milliseconds in (
		select max(milliseconds)
		from track) ; 


select title, artist.name, sum(milliseconds)/60000 as duration_minutes
from album 
	inner join artist on artist.artistid = album.artistid
	inner join track on album.albumid = track.albumid
group by title, artist.name
having sum(milliseconds)/60000 = (
	select sum(milliseconds)/60000 as duration_minutes
	from album 
		inner join artist on artist.artistid = album.artistid
		inner join track on album.albumid = track.albumid
	group by title, artist.name
	order by 1 desc limit 1) ;



select title as album_title, artist.name as artist_name, 
	count(*) as n_of_tracks
from track 
	inner join album on track.albumid = album.albumid
	inner join artist on album.artistid = artist.artistid  
where artist.name = 'U2'
group by title, artist.name
having count(*) >= 
	(select count(*)
	 from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
	 where artist.name = 'U2' and title = 'Pop')     

