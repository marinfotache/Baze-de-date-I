-- care sunt albumele (din BD) formatiei 'Led Zeppelin'
SELECT *
FROM artist INNER JOIN album ON artist.artistid = album.artistid 
WHERE name = 'Led Zeppelin'

-- cate albume din BD sunt ale formatiei 'Led Zeppelin'
SELECT COUNT(*) AS nr_albume_lz
FROM artist INNER JOIN album ON artist.artistid = album.artistid 
WHERE name = 'Led Zeppelin'

-- cate piese din BD sunt ale formatiei 'Led Zeppelin'
SELECT COUNT(*) AS nr_piese_lz
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid 
	INNER JOIN track ON album.albumid = track.albumid 
WHERE artist.name = 'Led Zeppelin'

-- care este durata maxima a unei piese de-a formatiei 'Led Zeppelin'
SELECT MAX(milliseconds / 60000) AS durata_max_lz
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid 
	INNER JOIN track ON album.albumid = track.albumid 
WHERE artist.name = 'Led Zeppelin'

-- piesa 'Led Zeppelin' cu durata de 26 minute
SELECT *
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid 
	INNER JOIN track ON album.albumid = track.albumid 
WHERE artist.name = 'Led Zeppelin' and milliseconds / 60000 = 26

-- care este durata medie a unei piese de 'Led Zeppelin'
SELECT AVG(milliseconds / 60000) AS durata_medie_lz
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid 
	INNER JOIN track ON album.albumid = track.albumid 
WHERE artist.name = 'Led Zeppelin'

-- care este numarul de piese de pe fiecare album al formatiei 'Led Zeppelin'
SELECT title, album.albumid, COUNT(*) AS nr_piese
FROM artist 
	INNER JOIN album ON artist.artistid = album.artistid 
	INNER JOIN track ON album.albumid = track.albumid 
WHERE artist.name = 'Led Zeppelin'
GROUP BY title, album.albumid
ORDER BY 2 

-- care este numarul de piese de pe fiecare album al formatiei 'Led Zeppelin'
SELECT title, nr_piese
FROM (
	SELECT title, album.albumid, COUNT(*) AS nr_piese
	FROM artist 
		INNER JOIN album ON artist.artistid = album.artistid 
		INNER JOIN track ON album.albumid = track.albumid 
	WHERE artist.name = 'Led Zeppelin'
	GROUP BY title, album.albumid
	ORDER BY 2 ) X






select * from artist where upper(name) like 'AC%'