-- 						Interogari BD Chinook - IE si SPE:
--
-- SQL 02: Jonctiuni interne
--
-- ultima actualizare: 2019-10-05


-- JOIN

-- ############################################################################ 
-- 						Care sunt albumele formatiei `U2`
-- ############################################################################ 

-- sol. 1 - NATURAL JOIN
select *
from album natural join artist
where name = 'U2'

-- sol. 2 - ECHI-JOIN
select album.*, artist.name
from album inner join artist on album.artistid = artist.artistid
where name = 'U2'


-- ############################################################################ 
-- 		Care sunt piesele de pe albumul `Achtung Baby` al formatiei U2?
-- ############################################################################ 

-- sol. eronata care foloseste NATURAL JOIN
select *
from album 
	natural join artist
	natural join track
where name = 'U2'

-- sol. corecta - folosind INNER JOIN 
select track.*
from album 
	natural join artist
	inner join track on album.albumid = track.albumid
where artist.name = 'U2' and title = 'Achtung Baby'




-- ############################################################################ 
-- 									AUTOJONCTIUNE
-- ############################################################################ 


-- ############################################################################ 
-- 			Care sunt celelalte albume ale formatiei care a lansat 
-- 							albumul 'Achtung Baby'?
-- ############################################################################ 


-- solutie care utilizeaza AUTO JOIN
SELECT a2.*
FROM album NATURAL JOIN artist
	INNER JOIN album a2 ON album.artistid = a2.artistid
WHERE album.title = 'Achtung Baby'



-- ############################################################################ 
-- 						Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################ 


-- Afisare piesele si artistii din playlistul `Heavy Metal Classic`


-- jonctiune pe EMPLOYEE (luand in calcul subordonarea!!!!)




-- ############################################################################ 
-- 						La ce intrebari raspund urmatoarele interogari ?
-- ############################################################################ 

select name as artist_name, title as album_title
from artist inner join album on artist.artistid = album.artistid
where name = title
order by 1 ;


select track.name as track_name, 
	title as album_title, artist.name as artist_name,
    milliseconds / 1000 as duration_seconds
from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
where artist.name = 'U2'
order by milliseconds desc
limit 9






