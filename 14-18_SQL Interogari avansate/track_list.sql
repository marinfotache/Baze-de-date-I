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


