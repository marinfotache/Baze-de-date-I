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
-- 					SQL02: Joncțiuni interne
-- 					SQL02: INNER JOINs
-- ############################################################################
-- ultima actualizare / last update: 2023-12-01


-- ############################################################################
--                   Care sunt albumele formației `U2`
-- ############################################################################
--                   Extract the albums released by the band `U2`
-- ############################################################################

-------------------------------------------------------------------------------
-- sol. 1 - NATURAL JOIN
-------------------------------------------------------------------------------
select *
from album natural join artist
where name = 'U2'

-------------------------------------------------------------------------------
-- sol. 2 - ECHI-JOIN
-------------------------------------------------------------------------------

select *
from album inner join artist on album.artistid = artist.artistid
where name = 'U2'

--
select album.*, artist.name
from album inner join artist on album.artistid = artist.artistid
where name = 'U2'



-- ############################################################################
-- 		Care sunt piesele de pe albumul `Achtung Baby` al formatiei U2?
-- ############################################################################
-- 	 Extract the tracks included on the album `Achtung Baby` released by `U2`
-- ############################################################################

-------------------------------------------------------------------------------
-- sol. eronata care foloseste NATURAL JOIN
-------------------------------------------------------------------------------
-- WRONG solution based on NATURAL JOIN
-------------------------------------------------------------------------------
select *
from album
	natural join artist
	natural join track
where name = 'U2'


-------------------------------------------------------------------------------
-- sol. corecta - folosind INNER JOIN
-------------------------------------------------------------------------------
-- correct solution is based on INNER JOIN
-------------------------------------------------------------------------------
select track.*
from album
	natural join artist
	inner join track on album.albumid = track.albumid
where artist.name = 'U2' and title = 'Achtung Baby'



-- ############################################################################
-- Care sunt piesele formației `Led Zeppelin` compuse de cel puțin 3 muzicieni?
-- ############################################################################
-- Extract the tracks released by the band `Led Zeppelin` authored by at least
--   3 musicians
-- ############################################################################

SELECT track.*
FROM track
	INNER JOIN album ON track.albumid = album.albumid
	INNER JOIN artist ON album.artistid = artist.artistid
WHERE artist.name = 'Led Zeppelin'	AND
	(UPPER(composer) LIKE '%LED ZEPPELIN%'
	OR
	regexp_match(composer, '.*(/|,).*(/|,).*') IS NOT NULL  )


-- ############################################################################
--          Care sunt piesele formației `U2` vândute în anul 2013?
-- ############################################################################
--          Which of the tracks released by `U2` were sold during 2013?
-- ############################################################################

SELECT track.name as track_name, title as album_title
FROM track
	INNER JOIN album ON track.albumid = album.albumid
	INNER JOIN artist ON album.artistid = artist.artistid
	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
	INNER JOIN invoice ON invoiceline.invoiceid = invoice.invoiceid
WHERE artist.name = 'U2' AND EXTRACT (YEAR FROM invoicedate) = 2013
ORDER BY 1 ;



-- ############################################################################
-- 						AUTOJONCTIUNE / SELF-JOIN
-- ############################################################################


-- ############################################################################
-- 			Care sunt celelalte albume ale formatiei care a lansat
--                    albumul 'Achtung Baby'?
-- ############################################################################
--   Extract all the albums of the band who released the album 'Achtung Baby'?
-- ############################################################################

-- solutie care utilizeaza AUTO JOIN
SELECT a2.*
FROM album NATURAL JOIN artist
	INNER JOIN album a2 ON album.artistid = a2.artistid
WHERE album.title = 'Achtung Baby'


-- ############################################################################
-- 			Care sunt celelalte piese de pe albumul pe care apare piesa
--              'For Those About To Rock (We Salute You)'?
-- ############################################################################
-- 			Which are the other tracks on the same album as the track
--               'For Those About To Rock (We Salute You)'?
-- ############################################################################

-- auto-jonctiune / SELF-JOIN 
SELECT track1.*
FROM track track1
	INNER JOIN track track2 ON track1.albumid = track2.albumid
WHERE track2.name = 'For Those About To Rock (We Salute You)'



-- ############################################################################
-- 	   Care sunt clientii din aceeasi tara ca si clientul `Robert Brown`
-- ############################################################################
-- 	   Extract customers from the same country as customer `Robert Brown`
-- ############################################################################

-------------------------------------------------------------------------------
-- sol. 1
-------------------------------------------------------------------------------
select customer1.*
from customer customer1
	inner join customer customer2 on customer1.country = customer2.country
where customer2.firstname = 'Robert' and customer2.lastname = 'Brown'


-------------------------------------------------------------------------------
-- sol.2
-------------------------------------------------------------------------------
select customer2.*
from customer customer1
	inner join customer customer2 on customer1.country = customer2.country
where customer1.firstname = 'Robert' and customer1.lastname = 'Brown'



-- ############################################################################
-- 	Care este șeful angajatului cu numele (lastname) 'Johnson'
--      și prenumele (firstname) 'Steve'
-- ############################################################################
-- 	Display the boss of the employee whose lastname is 'Johnson' and
--      the firstname is 'Steve'
-- ############################################################################

SELECT sefi.*
FROM employee subordonati
	INNER JOIN employee sefi ON subordonati.reportsto = sefi.employeeid
WHERE subordonati.lastname = 'Johnson' AND subordonati.firstname = 'Steve'




-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
-- ############################################################################


--############################################################################
--###          În ce țări s-a vândut muzica formației `Led Zeppelin`?
--############################################################################
--###          Find the countries where `Led Zeppelin` tracks were sold
--############################################################################


/*
############################################################################
##   Care sunt piesele formatiei `Led Zeppelin` la care, printre autori,
##               se numara bateristul `John Bonham`
############################################################################
##   List the tracks released by `Led Zeppelin` having `John Bonham`
##               as one of the composers
############################################################################
*/


--############################################################################
--###       Afisare piese si artisti din playlistul `Heavy Metal Classic`
--############################################################################
--###       Display tracks and artist in `Heavy Metal Classic` playlist
--############################################################################


--############################################################################
--### Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, 
--###  NU apare `Robert Plant`
--############################################################################
--###   Display `Led Zeppelin`'s tracks not (co-)written by `Robert Plant` 
--############################################################################


--############################################################################
--### Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, 
--###  NU apar nici `Robert Plant`, nici `Jimmy Page`
--############################################################################
--###   Display `Led Zeppelin`'s tracks whose (co)composer(s) are 
--###      neither `Robert Plant` nor `Jimmy Page`
--############################################################################

--##############################################################################
--##	   Care sunt clientii din aceeasi tara ca si clientul `Robert Brown`
--##############################################################################
--##	   Extract customers from the same country as customer `Robert Brown`
--##############################################################################



-- ############################################################################
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
-- ############################################################################

--
SELECT track.*
FROM track
	INNER JOIN album ON track.albumid = album.albumid
	INNER JOIN artist ON album.artistid = artist.artistid
WHERE artist.name = 'Led Zeppelin'	AND
	(UPPER(composer) LIKE '%BONHAM%' OR 	UPPER(composer) LIKE '%LED ZEPPELIN%')


--
select name as artist_name, title as album_title
from artist inner join album on artist.artistid = album.artistid
where name = title
order by 1 ;


--
select track.name as track_name,
	title as album_title, artist.name as artist_name,
    milliseconds / 1000 as duration_seconds
from track
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid
where artist.name = 'U2'
order by milliseconds desc
limit 9
