select name as artist_name, title as album_title
from artist inner join album on artist.artistid = album.artistid
where name = title
order by 1

select name as artist_name
from artist 
where name in (
	select title
	from album) 
order by 1


select * from track

select title, name
from album inner join artist on artist.artistid = album.artistid
where albumid in (
	select albumid
	from track
	where name = 'Amazing')


select artist.name as artist_name, title, track.name as track_name
from album 
	inner join artist on artist.artistid = album.artistid
	inner join track on album.albumid = track.albumid
where album.albumid in (
	select albumid
	from track
	where name = 'Amazing')
order by 1, 2, 3


select track2.name
from track track1 inner join track track2 on track1.albumid = track2.albumid
where track1.name = 'Amazing'

select *
from genre

select max(milliseconds/ 60000)
from track

select artist.name as artist_name, title, track.name as track_name, milliseconds
from album 
	inner join artist on artist.artistid = album.artistid
	inner join track on album.albumid = track.albumid
where   milliseconds in (
		select max(milliseconds)
		from track)



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
	order by 1 desc limit 1)


