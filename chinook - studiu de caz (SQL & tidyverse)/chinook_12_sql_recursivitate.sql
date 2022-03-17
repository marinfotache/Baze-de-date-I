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
-- 					SQL12: Interogări recursive
-- 					SQL12: Recursive queries
-- ############################################################################
-- ultima actualizare / last update: 2022-03-17
--


-- ############################################################################
--   		A. Interogări recursive pentru probleme `pseudo-recursive`
-- ############################################################################
--   		A. Recursive queries for non-recursive problems :-)
-- ############################################################################


-- ############################################################################
-- 		Știind că `trackid` respectă ordinea (poziția) pieselor de pe albume,
--  să se numeroteze toate piesele de pe toate albumele formației
-- `Led Zeppelin`; albumele vor fi ordonate alfabetic, iar piesele după
-- poziția lor în cadrul albumului (reluare)
-- ############################################################################
-- 		As `trackid` incorporated the track order on each album,
--  attach a track number from 1 to N (where N is the number of tracks on
--  the current album) for every track on each album released by `Led Zeppelin`;
--  albums will be ordered alphabetically, and tracks by their album position
-- (reprise)
-- ############################################################################


-- album track list - ver. 1.0
WITH RECURSIVE h (AlbumId, AlbumName, ArtistName, TrackId, TrackNo, Tracks) AS (
	SELECT track.albumid, album.title, artist.name, trackid, 1, CAST ('1:' || track.name AS VARCHAR(1000))
	FROM album
		INNER JOIN artist ON album.artistid = artist.artistid
		INNER JOIN track ON album.albumid = track.albumid
	WHERE (track.albumid, trackid) IN	(
		SELECT albumid, MIN(trackid)
		FROM track
		GROUP BY albumid		)
UNION ALL
	SELECT track.albumid, album.title, artist.name, track.trackid, h.trackno + 1,
		CAST (h.tracks || '; ' || h.trackno + 1 || ':' || track.name AS VARCHAR(1000))
	FROM album
		INNER JOIN artist ON album.artistid = artist.artistid
		INNER JOIN track ON album.albumid = track.albumid
		INNER JOIN h ON track.albumid = h.albumid  AND track.trackid =
			(SELECT MIN(trackid)
			 FROM track
			 WHERE albumid = h.albumid AND trackid > h.trackid  )	)
SELECT albumid, albumname, artistname, trackno AS n_of_tracks, tracks AS track_list
FROM h
WHERE (albumid, albumname, artistname, trackno) IN
	(SELECT albumid, albumname, artistname, max(trackno)
	FROM h
	GROUP BY albumid, albumname, artistname)
ORDER BY 1



-- album track list - ver. 2.0
WITH RECURSIVE h (AlbumId, AlbumName, ArtistName, TrackNo, Tracks) AS (
	SELECT twn.albumid, album.title, artist.name, 1, CAST (twn.name AS VARCHAR(1000))
	FROM album
		INNER JOIN artist ON album.artistid = artist.artistid
		INNER JOIN twn ON album.albumid = twn.albumid
	WHERE trackno = 1
			UNION ALL
	SELECT twn.albumid, album.title, artist.name, h.trackno + 1,
		CAST (h.tracks || '; ' || twn.name AS VARCHAR(1000))
	FROM album
		INNER JOIN artist ON album.artistid = artist.artistid
		INNER JOIN twn ON album.albumid = twn.albumid
		INNER JOIN h ON twn.albumid = h.albumid
			AND twn.trackno = h.trackno + 1),
twn AS (SELECT track.*, row_number() OVER (PARTITION BY albumid ORDER BY trackid) AS trackNo
	FROM track )
SELECT albumid, albumname, artistname, max(trackno) AS n_of_tracks, MAX(tracks) AS track_list
FROM h
GROUP BY albumid, albumname, artistname
ORDER BY 1


-- album track list - ver. 2.1
WITH RECURSIVE h (AlbumId, AlbumName, ArtistName, TrackNo, Tracks) AS (
	SELECT twn.albumid, album.title, artist.name, 1, CAST ('1:' || twn.name AS VARCHAR(1000))
	FROM album
		INNER JOIN artist ON album.artistid = artist.artistid
		INNER JOIN twn ON album.albumid = twn.albumid
	WHERE trackno = 1
			UNION ALL
	SELECT twn.albumid, album.title, artist.name, h.trackno + 1,
		CAST (h.tracks || '; ' || h.trackno + 1 || ':' || twn.name AS VARCHAR(1000))
	FROM album
		INNER JOIN artist ON album.artistid = artist.artistid
		INNER JOIN twn ON album.albumid = twn.albumid
		INNER JOIN h ON twn.albumid = h.albumid
			AND twn.trackno = h.trackno + 1),
twn AS (SELECT track.*, row_number() OVER (PARTITION BY albumid ORDER BY trackid) AS trackNo
	FROM track )
SELECT albumid, albumname, artistname, max(trackno) AS n_of_tracks, MAX(tracks) AS track_list
FROM h
GROUP BY albumid, albumname, artistname
ORDER BY 1


-- album track list - ver. 2.2
WITH RECURSIVE h (albumid, album_title, artist_name, trackno, track_list) AS (
	SELECT albumid, album_title, artist_name, 1, CAST ('1:' || track_name AS VARCHAR(1000))
	FROM track_numbers
	WHERE trackno = 1
			UNION ALL
	SELECT h.albumid, h.album_title, h.artist_name, h.trackno + 1,
		CAST (h.track_list || '; ' || h.trackno + 1 || ':' || track_numbers.track_name AS VARCHAR(1000))
	FROM track_numbers INNER JOIN h ON track_numbers.albumid = h.albumid AND track_numbers.trackno = h.trackno + 1),
track_numbers AS (
	SELECT trackid, track.name as track_name, album.albumid, title as album_title, artist.name as artist_name,
		row_number() OVER (PARTITION BY album.albumid ORDER BY trackid) AS trackNo
	FROM track
		INNER JOIN album ON track.albumid = album.albumid
		INNER JOIN artist ON album.artistid = artist.artistid
	ORDER BY artist_name, album_title, album.albumid, trackid
)
SELECT albumid, album_title, artist_name, max(trackno) AS n_of_tracks, MAX(track_list) AS track_list
FROM h
GROUP BY albumid, album_title, artist_name
ORDER BY 1



-- solutie mai simpla, care, in loc de recursivitate, foloseste gruparea si
--   functia `string_agg`
-- (vezi si scriptul `chinook_08_sql_subconsultari_in_where_si_having.sql`)
WITH track_numbering AS
	(SELECT album.albumid, title as album_title, artist.name as artist_name,
		ROW_NUMBER() OVER (PARTITION BY title ORDER BY trackid) AS track_no,
		track.name AS track_name
	FROM artist
		NATURAL JOIN album
		INNER JOIN track ON album.albumid = track.albumid
	ORDER BY 2, 4
	)
SELECT albumid, album_title, artist_name,
	string_agg(DISTINCT CAST(RIGHT(' ' || track_no,2) || ':' || track_name AS VARCHAR), '; '
							 ORDER BY CAST(RIGHT(' ' || track_no,2) || ':' || track_name AS VARCHAR))
							 AS all_tracks_from_this_album
FROM track_numbering
GROUP BY albumid, album_title, artist_name





-- ############################################################################
--            B. Interogari recursive pentru probleme `recursive`
-- ############################################################################
--            B. Recursive queries for `recursive` problems
-- ############################################################################


-- ############################################################################
--                 Afișați nivelul ierarhic al fiecărui angajat
--                   (începând cu 0 de la `General Manager`)
-- ############################################################################
--              Display the hierarchical level of each employee
--                   (starting with 0 from the `General Manager`)
-- ############################################################################

WITH RECURSIVE hierarchy ( employeeid, lastname, firstname, title,
		reportsto, hierarchical_level) AS (
	SELECT employeeid, lastname, firstname, title,
		reportsto, 0 AS hierarchical_level
	FROM employee
	WHERE reportsto IS NULL
UNION ALL
 	SELECT e.employeeid, e.lastname, e.firstname, e.title,
		e.reportsto, hierarchical_level - 1
 	FROM employee e INNER JOIN hierarchy h
		ON e.reportsto = h.employeeid
)
SELECT *
FROM hierarchy
ORDER BY hierarchical_level DESC


-- ############################################################################
--     Pentru fiecare angajat, afisati subordonarea sa ierarhica, incepand
--                         cu `General Manager`
-- ############################################################################

-- ############################################################################
--                 Afișați nivelul ierarhic al fiecărui angajat
--                   (începând `General Manager`)
-- ############################################################################
--             display, for each employee, the full managerial path
--                   (starting with the `General Manager`)
-- ############################################################################

--
WITH RECURSIVE hierarchy ( employeeid, lastname, firstname, title,
		reportsto, hierarchical_level, full_managerial_path) AS (
	SELECT employeeid, lastname, firstname, title,
		reportsto,
		0 AS hierarchical_level,
		CAST(lastname || ' ' || firstname AS VARCHAR(1000)) AS full_managerial_path
	FROM employee
	WHERE reportsto IS NULL
UNION ALL
 	SELECT e.employeeid, e.lastname, e.firstname, e.title, e.reportsto,
		hierarchical_level - 1,
		CAST (h.full_managerial_path || ' -> ' || e.lastname || ' ' || e.firstname AS VARCHAR(1000))
 	FROM employee e INNER JOIN hierarchy h
		ON e.reportsto = h.employeeid -- atentie la modul de construire a ierarhiei
)
SELECT *
FROM hierarchy
ORDER BY 2




-- ############################################################################
--               Extrageți toți șefii angajatei 'Jane Peacock'
-- ############################################################################
--               List all the bosses (first level, second level, ...)
--                      from the employee  'Jane Peacock'
-- ############################################################################


WITH RECURSIVE hierarchy ( employeeid, lastname, firstname, title,
		reportsto, hierarchical_level, subordination_path) AS (
	SELECT employeeid, lastname, firstname, title,
		reportsto,
		0 AS hierarchical_level,
		CAST(lastname || ' ' || firstname AS VARCHAR(1000)) AS subordination_path
	FROM employee
	WHERE lastname = 'Peacock' AND firstname = 'Jane'
UNION ALL
 	SELECT e.employeeid, e.lastname, e.firstname, e.title, e.reportsto,
		hierarchical_level + 1,
		CAST (h.subordination_path || ' -> ' || e.lastname || ' ' || e.firstname AS VARCHAR(1000))
 	FROM employee e INNER JOIN hierarchy h
		ON e.employeeid = h.reportsto  -- atentie la modul de construire a ierarhiei
)
SELECT *
FROM hierarchy
ORDER BY hierarchical_level




-- ############################################################################
--             Extrageți toți subordonații (direcți și indirecți) ai
--                        angajatei 'Nancy Edwards'
-- ############################################################################
--             Extract all subordinates of  'Nancy Edwards'
-- ############################################################################


WITH RECURSIVE hierarchy ( employeeid, lastname, firstname, title,
		reportsto, hierarchical_level, subordination_path) AS (
	SELECT employeeid, lastname, firstname, title,
		reportsto,
		0 AS hierarchical_level,
		CAST(lastname || ' ' || firstname AS VARCHAR(1000)) AS subordination_path
	FROM employee
	WHERE lastname = 'Edwards' AND firstname = 'Nancy'
UNION ALL
 	SELECT e.employeeid, e.lastname, e.firstname, e.title, e.reportsto,
		hierarchical_level + 1,
		CAST (h.subordination_path || ' -> ' || e.lastname || ' ' || e.firstname AS VARCHAR(1000))
 	FROM employee e INNER JOIN hierarchy h
		ON e.reportsto = h.employeeid  -- atentie la modul de construire a ierarhiei
)
SELECT *
FROM hierarchy
ORDER BY hierarchical_level



-- ############################################################################
--                Probleme de rezolvat la curs/laborator/acasa
-- ############################################################################
--                To be completed during lectures/labs or at home
-- ############################################################################







-- ############################################################################
--              La ce întrebări răspund următoarele interogări ?
-- ############################################################################
--           For what requiremens the following queries provide the result?
-- ############################################################################


-- ...
