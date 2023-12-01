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
-- 					SQL05: Funcții agregat (count, count distinct, ...) fără grupare
-- 					SQL05: Aggregate functions without gruping
-- ############################################################################
-- ultima actualizare / last update: 2023-12-01


-- ############################################################################
--                    Câți artiști sunt în baza de date?
-- ############################################################################
--                How many artists are stored in the database?
-- ############################################################################

-- sol. 1
SELECT COUNT(*) AS nr_artisti
FROM artist

-- sol. 2 
SELECT COUNT(artistid) AS nr_artisti
FROM artist


-- ############################################################################
--                 Cate piese sunt stocate în baza de date?
-- ############################################################################
--                 How many tracks are stored in the database?
-- ############################################################################

-- ok
SELECT COUNT(*) AS nr_piese
FROM track

-- ok
SELECT COUNT(trackid) AS nr_piese
FROM track

-- NOT OK!
SELECT COUNT(composer) AS nr_piese
FROM track


-- ############################################################################
-- 				                     Câți clienți au fax?
-- ############################################################################
-- 				                  How many customers have fax?
-- ############################################################################

-- sol. 1 (cu filtrarea inregistrarilor)
SELECT COUNT(*)
FROM customer
WHERE fax IS NOT NULL

-- sol. 2 (bazata pe COUNT valori nenule)
SELECT COUNT(fax)
FROM customer



-- ############################################################################
-- 				Pentru câți artiști există măcar un album în baza de date?
-- ############################################################################
-- 				         How many artist released at least an album?
-- ############################################################################

-- solutie eronata! / error!
SELECT COUNT(artistid)
FROM album

-- COUNT DISTINCT
SELECT COUNT(DISTINCT artistid)
FROM album


-- ############################################################################
--                Din câte țări sunt clienții companiei?
-- ############################################################################
--                In how many contries originate the customers?
-- ############################################################################

SELECT COUNT(DISTINCT country)
FROM customer



-- ############################################################################
--        Câte secunde are albumul `Achtung Baby` al formației `U2`?
-- ############################################################################
--     Compute the total duration (in seconds) of the album `Achtung Baby`
--  released by `U2`
-- ############################################################################

SELECT SUM(milliseconds) / 1000 AS duration_seconds
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'U2' AND title = 'Achtung Baby'



-- ############################################################################
--               Care este durata medie (în secunde) a pieselor
--               de pe albumul `Achtung Baby` al formației `U2`
-- ############################################################################
--    Compute the average duration (in seconds) of the tracks included
--               on the album `Achtung Baby` released by `U2`
-- ############################################################################

SELECT ROUND(AVG(milliseconds / 1000)) AS duration_seconds
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'U2' AND title = 'Achtung Baby'


-- ############################################################################
--           Care este durata medie a pieselor formației `U2`
-- ############################################################################
--    Compute the average duration (in seconds) of the tracks
--               released by `U2`
-- ############################################################################

SELECT ROUND(AVG(milliseconds / 1000)) AS duration_seconds
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'U2'


-- ############################################################################
-- 			Care este durata medie a pieselor formației `Pink Floyd`,
--                     exprimată în minute și secunde
-- ############################################################################
--    Compute the average duration (in minutes and seconds) of the tracks
--               released by `Pink Floyd`
-- ############################################################################

SELECT ROUND(AVG(milliseconds / 1000)) * interval '1 sec' AS duration_mins_secs
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Pink Floyd'



-- ############################################################################
--                      În ce zi a fost prima vânzare?
-- ############################################################################
--                      Find the date of the first sale.
-- ############################################################################

SELECT MIN(invoicedate) AS prima_zi
FROM invoice


-- solutie fara MIN
SELECT invoicedate AS prima_zi
FROM invoice
ORDER BY invoicedate
LIMIT 1



-- ############################################################################
--                       În ce dată a fost ultima vanzare?
-- ############################################################################
--                          Find the last sales date
-- ############################################################################

SELECT MAX(invoicedate) AS prima_zi
FROM invoice

-- solutie fara MAX / sol. without MAX
SELECT invoicedate AS prima_zi
FROM invoice
ORDER BY invoicedate DESC
LIMIT 1





-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
-- ############################################################################


--############################################################################
--##               Din cate orașe sunt clienții companiei?
--############################################################################
--##             In how many cities originate the customers?
--############################################################################

-- Care este data primei angajari in companie

-- Cate piese sunt pe playlistul `Grunge`?

-- Cati subordonati are, in total (pe toate nivelurile), angajatul xxxxxx?




-- ############################################################################
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
-- ############################################################################

select min(birthdate)
from employee ;


SELECT MAX(milliseconds / 60000) AS durata_max_lz
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Led Zeppelin'


SELECT *
FROM artist
	INNER JOIN album ON artist.artistid = album.artistid
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Led Zeppelin' and milliseconds / 60000 = 26
