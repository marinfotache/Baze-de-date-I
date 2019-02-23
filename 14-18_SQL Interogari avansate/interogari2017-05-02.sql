with top_5 as
	(select  sum(quantity) as quantity_sold
	from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
		inner join invoiceLine on invoiceLine.trackid = track.trackid  
	group by track.name, title, artist.name
	order by quantity_sold desc
	limit 5) 
select track.name as track_name, 
	title as album_title, artist.name as artist_name, 
    sum(quantity) as quantity_sold
from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
		inner join invoiceLine on invoiceLine.trackid = track.trackid  
group by track.name, title, artist.name
having sum(quantity) >= 
	(select min(quantity_sold)
     from top_5)
order by quantity_sold desc







with top_9_u2 as
	(select milliseconds / 1000 as duration_seconds
	from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
	where artist.name = 'U2'
	order by milliseconds desc
	limit 9)
select track.name as track_name, 
	title as album_title, artist.name as artist_name,
    milliseconds / 1000 as duration_seconds
from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
where artist.name = 'U2' and milliseconds / 1000 >=
	(select min(duration_seconds)
     from top_9_u2)          
order by milliseconds desc


select track.name as track_name, 
	title as album_title, artist.name as artist_name,
    milliseconds / 1000 as duration_seconds
from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
where artist.name = 'U2'
order by milliseconds desc
limit 9






with n_of_tracks_u2 as
	(select title as album_title, artist.name as artist_name, 
		count(*) as n_of_tracks
	from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
	where artist.name = 'U2'
	group by title, artist.name)
select *
from n_of_tracks_u2
where n_of_tracks >= 
	(select n_of_tracks
     from n_of_tracks_u2
     where album_title = 'Pop')
    
    
    


select *
from (select title as album_title, artist.name as artist_name, 
		count(*) as n_of_tracks
	from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
	where artist.name = 'U2'
	group by title, artist.name) n_of_tracks_u2
    	INNER JOIN 
        (select count(*) AS n_of_tracks
	 	 from track 
			inner join album on track.albumid = album.albumid
			inner join artist on album.artistid = artist.artistid  
	 	 where artist.name = 'U2' and title = 'Pop') n_of_tracks_pop
        ON  n_of_tracks_u2.n_of_tracks >= n_of_tracks_pop.n_of_tracks 
        
        
        
        
        
where n_of_tracks_u2.n_of_tracks >= n_of_tracks_pop.n_of_tracks
	(select n_of_tracks
     from n_of_tracks_u2
     where album_title = 'Pop')




select *
from (
    select title as album_title, artist.name as artist_name, 
		count(*) as n_of_tracks
	from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
	where artist.name = 'U2'
	group by title, artist.name) n_of_tracks_u2
where n_of_tracks_u2.n_of_tracks >= 12
      
      
      
      having count(*) >= 
	(select count(*)
	 from track 
		inner join album on track.albumid = album.albumid
		inner join artist on album.artistid = artist.artistid  
	 where artist.name = 'U2' and title = 'Pop')     






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

