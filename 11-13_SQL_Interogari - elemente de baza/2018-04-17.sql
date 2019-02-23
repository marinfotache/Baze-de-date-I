-- care sunt albumele formatiei Beatles
select * 
from artist 
	inner join album on artist.artistid = album.artistid
where upper(name) = 'BEATLES'

select * 
from artist 
	inner join album on artist.artistid = album.artistid
where upper(name) = 'U2'



select * 
from artist 
	inner join album on artist.artistid = album.artistid
where name = 'Creedence Clearwater Revival'


-- care sunt discurile formatiei care a lansat discul 'Rattle And Hum'?
select *
from artist 
	inner join album a1 on artist.artistid = a1.artistid
	inner join album a2 on a1.artistid = a2.artistid	
where a1.title = 'Rattle And Hum'

select * from track where name like 'Custard%'

-- care sunt piesele de pe acelasi album cu piesa `Custard Pie` 
-- a formatiei Led Zeppelin
select track2.name
from artist 
	inner join album on artist.artistid = album.artistid
	inner join track track1 on track1.albumid = album.albumid
	inner join track track2 on track1.albumid = track2.albumid
where artist.name = 'Led Zeppelin' and track1.name = 'Custard Pie' 


-- cate piese are albumul War al formatiei U2
select count(*) as nr_piese
from artist 
	inner join album on artist.artistid = album.artistid
	inner join track on track.albumid = album.albumid
where artist.name = 'U2' and album.title = 'War' 

-- cat dureaza (in minute) toate discurile formatiei U2
select sum(milliseconds / 60000) as durata_min
from artist 
	inner join album on artist.artistid = album.artistid
	inner join track on track.albumid = album.albumid
where artist.name = 'U2'

-- care este durata medie a unei piese a forumatiei U2
select avg(milliseconds / 1000) as durata_medie_sec
from artist 
	inner join album on artist.artistid = album.artistid
	inner join track on track.albumid = album.albumid
where artist.name = 'U2'

-- care este numarul de piese de pe fiecare album al formatiei U2
select title as titlu_album, album.albumid, count(*) as nr_piese
from artist 
	inner join album on artist.artistid = album.artistid
	inner join track on track.albumid = album.albumid
where artist.name = 'U2'
group by title, album.albumid
order by 2


-- care sunt albumele formatiei U2 cu cel putin 12 piese?
select title as titlu_album, album.albumid, count(*) as nr_piese
from artist 
	inner join album on artist.artistid = album.artistid
	inner join track on track.albumid = album.albumid
where artist.name = 'U2'
group by title, album.albumid
having count(*) >= 12

-- sa se afiseze top 5 albume U2, dupa numarul de piese
select title as titlu_album, album.albumid, count(*) as nr_piese
from artist 
	inner join album on artist.artistid = album.artistid
	inner join track on track.albumid = album.albumid
where artist.name = 'U2'
group by title, album.albumid
order by 3 desc
limit 5

















