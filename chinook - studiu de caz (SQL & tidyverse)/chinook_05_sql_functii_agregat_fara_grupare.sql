-- ############################################################################
--                Interogari BD Chinook - IE, CIG si SPE:
-- ############################################################################
--
-- 05: Functii agregat (count, count distinct, sum, avg, min, max) fara grupare
--
-- ultima actualizare: 2021-03-15



-- ############################################################################
--                    Cati artisti sunt in baza de date?
-- ############################################################################

SELECT COUNT(*) AS nr_artisti
FROM artist

-- sau
SELECT COUNT(artistid) AS nr_artisti
FROM artist


-- ############################################################################
--                 Cate piese sunt in baza de date?
-- ############################################################################

-- solutie corecta
SELECT COUNT(*) AS nr_piese
FROM track

-- alta solutie corecta
SELECT COUNT(trackid) AS nr_piese
FROM track

-- solutie incorecta
SELECT COUNT(composer) AS nr_piese
FROM track


-- ############################################################################
-- 				Cati clienti au fax?
-- ############################################################################

-- sol. 1 (cu filtrarea inregistrarilor)
SELECT COUNT(*)
FROM customer
WHERE fax IS NOT NULL

-- sol. 2 (bazata pe COUNT valori nenule)
SELECT COUNT(fax)
FROM customer



-- ############################################################################
-- 				Pentru cati artisti exista macar un album in BD?
-- ############################################################################

-- solutie eronata!!!
SELECT COUNT(artistid)
FROM album

-- solutie corecta - COUNT DISTINCT
SELECT COUNT(DISTINCT artistid)
FROM album


-- ############################################################################
--                Din cate tari sunt clientii companiei?
-- ############################################################################

SELECT COUNT(DISTINCT country)
FROM customer



-- ############################################################################
--        Cate secunde are albumul `Achtung Baby` al formatiei `U2`
-- ############################################################################

SELECT SUM(milliseconds) / 1000 AS duration_seconds
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'U2' AND title = 'Achtung Baby'



-- ############################################################################
--               Care este durata medie (in secunde) a pieselor
--               de pe albumul `Achtung Baby` al formatiei `U2`
-- ############################################################################

SELECT ROUND(AVG(milliseconds / 1000)) AS duration_seconds
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'U2' AND title = 'Achtung Baby'


-- ############################################################################
--           Care este durata medie a pieselor formatiei `U2`
-- ############################################################################

SELECT ROUND(AVG(milliseconds / 1000)) AS duration_seconds
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'U2'


-- ############################################################################
-- 			Care este durata medie a pieselor formatiei `Pink Floyd`,
--                     exprimata in minute si secunde
-- ############################################################################

SELECT ROUND(AVG(milliseconds / 1000)) * interval '1 sec' AS duration_mins_secs
FROM artist
	NATURAL JOIN album
	INNER JOIN track ON album.albumid = track.albumid
WHERE artist.name = 'Pink Floyd'



-- ############################################################################
--                      In ce zi a fost prima vanzare?
-- ############################################################################

SELECT MIN(invoicedate) AS prima_zi
FROM invoice


-- solutie fara MIN
SELECT invoicedate AS prima_zi
FROM invoice
ORDER BY invoicedate
LIMIT 1




-- ############################################################################
--                       In ce zi a fost ultima vanzare?
-- ############################################################################

SELECT MAX(invoicedate) AS prima_zi
FROM invoice

-- solutie fara MAX
SELECT invoicedate AS prima_zi
FROM invoice
ORDER BY invoicedate DESC
LIMIT 1





-- ############################################################################
--               Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################


-- Care este data primei angajari in companie

-- Cate piese sunt pe playlistul `Grunge`?

-- Cati subordonati are, in total (pe toate nivelurile), angajatul xxxxxx?




-- ############################################################################
--          La ce intrebari raspund urmatoarele interogari ?
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
