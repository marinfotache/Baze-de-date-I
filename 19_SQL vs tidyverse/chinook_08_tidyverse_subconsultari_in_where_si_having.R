# # -- 			 Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
# # --
# # -- 08: Subconsultari in clauzele WHERE si HAVING. Diviziune relationala (1)
# # --
# # -- ultima actualizare: 2019-04-24
# # 
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2019/Studii de caz/chinook')
load("chinook.RData")

# # 
# # --
# # -- ############################################################################ 
# # -- 					Subconsultari in clauza WHERE 
# # -- ############################################################################ 
# # --
# # 
# # -- ############################################################################ 
# # -- 		Care sunt celelalte albume ale artistului sau formatiei care a 
# # --     				lansat albumul `Houses of the Holy`
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe o subconsultare in clauza WHERE, care include albumul 
# # -- 'Houses Of The Holy', dar nu si numele artistului
# # select *
# # from album 
# # where artistid in (select artistid from album where title = 'Houses Of The Holy')
# # 
# # 
# # -- solutie bazata pe o subconsultare in clauza WHERE, care include albumul 
# # -- 'Houses Of The Holy' si numele artistului
# # select *
# # from album natural join artist
# # where artistid in (select artistid from album where title = 'Houses Of The Holy')
# # 
# # 
# # -- solutie bazata pe o subconsultare in clauza WHERE, care nu include albumul 
# # -- 'Houses Of The Holy', insa include numele artistului
# # select *
# # from album natural join artist
# # where artistid in (select artistid from album where title = 'Houses Of The Holy')
# # 	and title <> 'Houses Of The Holy'
# # order by 2
# # 
# # 



###
### tidyverse
### 

# solutie echivalenta auto-jonctiunii, fara afisarea aristului, 
# cu includerea albumului-ancora ('Houses Of The Holy')
temp <- album %>%
     filter (title == 'Houses Of The Holy') %>%
     select (artistid) %>%
     inner_join(album)


# solutie echivalenta auto-jonctiunii, cu afisarea aristului, 
# si includerea albumului-ancora ('Houses Of The Holy')
temp <- album %>%
     filter (title == 'Houses Of The Holy') %>%
     select (artistid) %>%
     inner_join(album) %>%
     inner_join(artist)



# solutie echivalenta (oarecum) sub-consultarii
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid == (album %>%
                              filter (title == 'Houses Of The Holy') %>%
                              pull(artistid))             
                  )
     

# in locul operatorului `==` se poate folosi `%in%`
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid %in% (album %>%
                              filter (title == 'Houses Of The Holy') %>%
                              pull(artistid))             
                  )


# o alta solutie echivalenta (oarecum) sub-consultarii (clauzei IN)
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid %in% (album %>%
                              filter (title == 'Houses Of The Holy')) [['artistid']] )
                  


# ... si inca una....
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid %in% (album %>%
                              filter (title == 'Houses Of The Holy') %>%
                              .$artistid)             
                  )



# # 
# # -- ############################################################################ 
# # -- 		Care sunt piesele de pe albumul `Achtung Baby` al formatiei U2?
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# # -- solutie noua - folosind un lant de subconsultari in clauza WHERE
# # select *
# # from track
# # where albumid in (select albumid
# # 				  from album
# # 				  where title = 'Achtung Baby' and 
# # 						artistid in (select artistid
# # 								    from artist
# # 								    where name = 'U2'))
# # 


###
### tidyverse
### 

temp <- track %>%
     filter (albumid == album %>%
                              filter (title == 'Achtung Baby' & 
                                   artistid %in% 
                                             (artist %>%
                                                  filter (name == 'U2') %>%
                                                  pull(artistid)
                                             )) %>%
                              pull(albumid)
                  )
     
     
# # 
# # -- SQL
# # 
# # -- solutie care foloseste doar o subconsultare in clauza WHERE
# # select *
# # from track
# # where albumid in (select albumid
# # 				from album natural join artist
# # 				where title = 'Achtung Baby' and name = 'U2')
# # 

###
### tidyverse
### 

temp <- track %>%
     filter (albumid == album %>%
                              inner_join(artist) %>%
                              filter (title == 'Achtung Baby' & name == 'U2') %>%
                              pull(albumid)
                  )
     


# # 
# # -- ############################################################################ 
# # -- 			Care sunt piesele comune (cu acelasi titlu) de pe 
# # -- 			albumele `Fear Of The Dark` si `A Real Live One`
# # -- 					ale formatiei 'Iron Maiden' (reluare)
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe subconsultare in clauza WHERE
# # SELECT track.name
# # FROM artist 
# # 	INNER JOIN album ON artist.artistid = album.artistid
# # 	INNER JOIN track ON album.albumid = track.albumid
# # WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark'	
# # 	AND track.name IN (
# # 		SELECT track.name
# # 		FROM track
# # 			INNER JOIN album ON track.albumid = album.albumid
# # 			INNER JOIN artist ON album.artistid = artist.artistid
# #         WHERE artist.name = 'Iron Maiden' AND title = 'A Real Live One')	
# # 


###
### tidyverse
### 

temp <- artist %>%
     filter (name == 'Iron Maiden') %>%
     select (artistid) %>%
     inner_join(album) %>%
     filter (title == 'Fear Of The Dark') %>%
     select (albumid) %>%
     inner_join(track) %>%
     filter (name %in% 
                    (artist %>%
                         filter (name == 'Iron Maiden') %>%
                         select (artistid) %>%
                         inner_join(album) %>%
                         filter (title == 'A Real Live One') %>%
                         select (albumid) %>%
                         inner_join(track) %>%
                         pull(name))
                  )
     
     
# # 
# # -- ############################################################################ 
# # -- 				  Care sunt facturile din prima zi de vanzari?
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe o subconsultare ce foloseste functia MIN
# # SELECT *
# # FROM invoice 
# # WHERE invoicedate = (SELECT MIN(invoicedate) 
# # 					FROM invoice)
# # 
# # -- solutie ce evita functia MIN (prin operatorul ALL)
# # SELECT *
# # FROM invoice 
# # WHERE invoicedate <= all (select distinct invoicedate
# # 					      from invoice
# # 					       order by invoicedate
# # 					       )
# # 

###
### tidyverse
### 

# solutie care foloseste jonctiunea interna si `top_n`
temp <- invoice %>%
     inner_join(
          invoice %>%
               top_n(-1, invoicedate) %>%
               select (invoicedate)
     )

# solutie care foloseste jonctiunea interna si `row_number()`
temp <- invoice %>%
     inner_join(
          invoice %>%
               arrange(invoicedate) %>%
               filter (row_number() == 1) %>%
               select (invoicedate)
     )

# solutie care foloseste jonctiunea interna si `head`
temp <- invoice %>%
     inner_join(
          invoice %>%
               arrange(invoicedate) %>%
               head (1) %>%
               select (invoicedate)
     )


# solutie care foloseste jonctiunea interna si `min`
temp <- invoice %>%
     inner_join(
          invoice %>%
               filter(invoicedate == min(invoicedate)) %>%
               select (invoicedate)
     )


# solutie care foloseste `min` fara jonctiune 
temp <- invoice %>%
     filter(invoicedate == min(invoicedate)) 


# solutie care foloseste `%in%` 
temp <- invoice %>%
     filter(invoicedate %in% (invoice %>%
                              top_n(-1, invoicedate) %>%
                              pull(invoicedate))          
                 ) 


# solutie care foloseste doar `top_n`
temp <- invoice %>%
     top_n(-1, invoicedate)




# # 
# # -- ############################################################################ 
# # -- 			Care sunt facturile din prima saptamana de vanzari?
# # -- ############################################################################ 
# 
# # 
# # -- SQL
# # 
# # SELECT *
# # FROM invoice 
# # WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND 
# # 	(SELECT MIN(invoicedate) + INTERVAL '7 DAYS' FROM invoice) 		
# # 

###
### tidyverse
### 


# prima solutie bazata pe un predicat similar `between`
temp <- invoice %>%
     filter (invoicedate >= min(invoicedate) &
                  invoicedate <=  min(invoicedate) + lubridate::days(7)
                  )

# a doua solutie bazata pe un predicat similar `between`
temp <- invoice %>%
     mutate (first_day = min(invoicedate),
           last_day = first_day + lubridate::days(7)) %>%
     filter (invoicedate >= first_day & invoicedate <= last_day)


# solutie bazata pe operatorul `%in%`
temp <- invoice %>%
     filter (invoicedate %in% (
          invoice %>%
               mutate (first_day = min(invoicedate),
                       last_day = min(invoicedate) + lubridate::days(7)) %>%
               filter (invoicedate >= first_day & invoicedate <= last_day) %>%
               pull(invoicedate))
     )
                  
             

# # -- ############################################################################ 
# # -- 				Care sunt facturile din prima luna de vanzari?
# # -- ############################################################################ 
# 
# # 
# # -- SQL
# # 
# # SELECT *
# # FROM invoice 
# # WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND 
# # 	(SELECT MIN(invoicedate) + INTERVAL '1 MONTH' FROM invoice) 		
# # 
# # 

###
### tidyverse
### 

# prima solutie bazata pe un predicat similar `between`
temp <- invoice %>%
     filter (invoicedate >= min(invoicedate) &
                  invoicedate <=  min(invoicedate) + lubridate::period(months = 1)
                  )

# a doua solutie bazata pe un predicat similar `between`
temp <- invoice %>%
     mutate (first_day = min(invoicedate),
           last_day = first_day + lubridate::period(months = 1)) %>%
     filter (invoicedate >= first_day & invoicedate <= last_day)


# solutie bazata pe operatorul `%in%`
temp <- invoice %>%
     filter (invoicedate %in% (
          invoice %>%
               mutate (first_day = min(invoicedate),
                       last_day = min(invoicedate) + lubridate::period(months = 1)) %>%
               filter (invoicedate >= first_day & invoicedate <= last_day) %>%
               pull(invoicedate))
     )
                  



# # -- ############################################################################ 
# # -- 		   Cate facturi s-au emis in prima luna calendaristica a vanzarilor ?
# # --    (adica prima luna IANUARIE sau APRILIE ...)
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# 
# # # -- solutie bazata pe o singura subconsulare
# # SELECT *
# # FROM invoice 
# # WHERE EXTRACT (YEAR FROM invoicedate) || '-' || EXTRACT (MONTH FROM invoicedate) + 100 IN
# # 	(SELECT MIN(EXTRACT (YEAR FROM invoicedate) || '-' || 100 + EXTRACT (MONTH FROM invoicedate))
# # 	  FROM invoice)	
# # 
# 
# # 

###
### tidyverse
### 

temp <- invoice %>%
     filter ( paste(lubridate::year(invoicedate), 
                    lubridate::month(invoicedate) + 100, sep = '-') ==
          (invoice %>%
               transmute( year_month_plus_100 = paste(lubridate::year(invoicedate), 
                    lubridate::month(invoicedate) + 100, sep = '-')) %>%
               summarise ( year_month_plus_100 = min(year_month_plus_100)  ) %>%
               pull())
     )         


# # # 
# # # -- SQL
# # # 
# # 
# 
# # -- solutie bazata pe trei subconsultari
# # SELECT *
# # FROM invoice 
# # WHERE EXTRACT (YEAR FROM invoicedate) = 
# # 				(SELECT MIN (EXTRACT (YEAR FROM invoicedate)) FROM invoice)
# # 	AND EXTRACT (MONTH FROM invoicedate) = 
# # 			(SELECT MIN(EXTRACT (MONTH FROM invoicedate)) 
# # 			 FROM invoice 
# # 		     WHERE EXTRACT (YEAR FROM invoicedate) IN
# # 					(SELECT MIN(EXTRACT (YEAR FROM invoicedate) )
# # 	  				 FROM invoice)	
# # 			 )
# 



###
### tidyverse
### 

temp <- invoice %>%
     filter (lubridate::year(invoicedate) == 
          (invoice %>%
               summarise( min = min(lubridate::year(invoicedate))) %>%
               pull()) ) %>%
     filter (lubridate::month(invoicedate) == lubridate::month(min(invoicedate)))
     



# # 
# # -- ############################################################################ 
# # -- 		   Cate facturi s-au emis in primele 10 zile cu vanzari ?
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe o subconsultare in clauza WHERE care prezinta LIMIT si 
# # --    SELECT DISTINCT (atentie, DISTINCT este obligatorie!);
# # -- conectorul dintre interogarea principale si subconsultare este IN
# # SELECT *
# # FROM invoice 
# # WHERE invoicedate IN (select distinct invoicedate
# # 					   from invoice
# # 					   order by invoicedate
# # 					   limit 10
# # 					   )
# # 
# # -- aceeasi solutie, insa cu FETCH
# # SELECT *
# # FROM invoice 
# # WHERE invoicedate IN (select distinct invoicedate
# # 					  from invoice
# # 					  order by invoicedate
# # 					  fetch first 10 rows only
# # 					   )
# # 
# # -- o solutie ce foloseste ANY
# # SELECT *
# # FROM invoice 
# # WHERE invoicedate <= ANY (
# # 					   select distinct invoicedate
# # 					   from invoice
# # 					   order by invoicedate
# # 					   limit 10
# # 					   )
# # 
# # -- o solutie ce foloseste OFFSET si LIMIT pentru a determina a 10-a valoare a `invoicedate`
# # SELECT *
# # FROM invoice 
# # WHERE invoicedate <=  (select distinct invoicedate
# # 					   from invoice
# # 					   order by invoicedate
# # 					   offset 9
# # 					   limit 1
# # 					   )
# # 
# #


###
### tidyverse
### 


# prima solutie bazata pe `top_n`
temp <- invoice %>%
     inner_join(
          invoice %>%
               distinct(invoicedate) %>%
               top_n(-10)
     )
     

# solutie bazata pe operatorul `%in%`
temp <- invoice %>%
     filter (invoicedate %in% 
          (invoice %>%
               distinct(invoicedate) %>%
               head(10) %>%
               pull()
          )
     )
                  


# # -- ############################################################################ 
# # -- 		      Care sunt cei mai vechi cinci angajati ai companiei?  
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutie incompleta bazata pe LIMIT
# # SELECT *
# # FROM employee
# # ORDER BY hiredate
# # LIMIT 5
# # 
# # -- solutie completa bazata pe LIMIT si o subconsultare
# # SELECT *
# # FROM employee
# # WHERE hiredate IN (
# # 					SELECT hiredate
# # 					FROM employee
# # 					ORDER BY hiredate
# # 					LIMIT 5
# # 					)
# # ORDER BY hiredate
#             

###
### tidyverse
### 

# solutia bazata pe `top_n` ia in calcul si valorile egale
temp <- employee %>%
     top_n(-5, hiredate)



# # --
# # -- ############################################################################ 
# # -- 					Subconsultari in clauza HAVING 
# # -- ############################################################################ 
# # --
# # 
# # -- ############################################################################ 
# # -- 		Care sunt albumele formatiei Led Zeppelin care au mai multe piese
# # --                  decat albumul `IV`  
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe o subsonsultare in clauza HAVING
# # SELECT title, COUNT(*) AS n_of_tracks
# # FROM album
# # 	NATURAL JOIN artist
# # 	INNER JOIN track on album.albumid = track.albumid	
# # WHERE artist.name = 'Led Zeppelin'
# # GROUP BY title
# # HAVING COUNT(*) > (SELECT COUNT(*)
# # 					 FROM album
# # 					  	NATURAL JOIN artist
# # 						INNER JOIN track on album.albumid = track.albumid	
# # 					 WHERE artist.name = 'Led Zeppelin' AND title = 'IV')
# # ORDER BY 1
# # 
# # 


###
### tidyverse
### 

# solution that emulates a subquery containing the number of tracks on album `IV`
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'Led Zeppelin') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     filter (n_of_tracks >       ## here comes the "subquery"
          (artist %>%
               inner_join(album) %>%
               filter (name == 'Led Zeppelin' & title == 'IV') %>%
          select (-name) %>%
          inner_join(track)  %>%
          tally() %>%
          pull()
          ))


# solution based on adding a separate column containing the number of tracks on album `IV`
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'Led Zeppelin') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     ungroup() %>%
     mutate (n_of_tracks_IV = if_else(title == 'IV', n_of_tracks, 0L)) %>%  # `0L` is compulsory!!!
     mutate (n_of_tracks_IV = max(n_of_tracks_IV)) %>%
     filter (n_of_tracks > n_of_tracks_IV)



# # 
# # -- ############################################################################ 
# # -- 		Care este albumul (sau albumele) formatiei Queen 
# # --   					cu cele mai multe piese? 
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe `>= ALL`
# # SELECT title, COUNT(*) AS n_of_tracks
# # FROM album
# # 	NATURAL JOIN artist
# # 	INNER JOIN track on album.albumid = track.albumid	
# # WHERE artist.name = 'Queen'
# # GROUP BY title
# # HAVING COUNT(*) >= ALL (SELECT COUNT(*)
# # 					 FROM album
# # 					  	NATURAL JOIN artist
# # 						INNER JOIN track on album.albumid = track.albumid	
# # 					 WHERE artist.name = 'Queen'
# # 					 GROUP BY title  )
# # ORDER BY 1
# # 
# # 
# # -- solutie bazata pe LIMIT
# # SELECT title, COUNT(*) AS n_of_tracks
# # FROM album
# # 	NATURAL JOIN artist
# # 	INNER JOIN track on album.albumid = track.albumid	
# # WHERE artist.name = 'Queen'
# # GROUP BY title
# # HAVING COUNT(*) =  (SELECT COUNT(*)
# # 					 FROM album
# # 					  	NATURAL JOIN artist
# # 						INNER JOIN track on album.albumid = track.albumid	
# # 					 WHERE artist.name = 'Queen'
# # 					 GROUP BY title  
# # 					 ORDER BY 1 DESC
# # 					 LIMIT 1)
# # ORDER BY 1
# # 


###
### tidyverse
### 

# solutie bazata pe `top_n`
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'Queen') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     ungroup() %>%
     top_n(1, n_of_tracks)


# solutie bazata pe `filter` si `max`
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'Queen') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     ungroup() %>%
     filter (n_of_tracks == max(n_of_tracks))



# # 
# # -- ############################################################################ 
# # -- 	  Extrageti TOP 7 albume ale formatiei `U2`, cu cele mai multe piese? 
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutia urmatoare genereaza un rezultat incomplet
# # SELECT title, COUNT(*) AS n_of_tracks
# # FROM album
# # 	NATURAL JOIN artist
# # 	INNER JOIN track on album.albumid = track.albumid	
# # WHERE artist.name = 'U2'
# # GROUP BY title
# # ORDER BY 2 DESC
# # LIMIT 7
# # 
# # -- solutie corecta
# # SELECT title, COUNT(*) AS n_of_tracks
# # FROM album
# # 	NATURAL JOIN artist
# # 	INNER JOIN track on album.albumid = track.albumid	
# # WHERE artist.name = 'U2'
# # GROUP BY title
# # HAVING COUNT(*) IN (
# # 		SELECT COUNT(*) AS n_of_tracks
# # 		FROM album
# # 			NATURAL JOIN artist
# # 			INNER JOIN track on album.albumid = track.albumid	
# # 		WHERE artist.name = 'U2'
# # 		GROUP BY title
# # 		ORDER BY 1 DESC
# # 		LIMIT 7)
# # ORDER BY 2 DESC
# 

###
### tidyverse
### 

temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'U2') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     ungroup() %>%
     arrange(desc(n_of_tracks))  %>%
     top_n(7, n_of_tracks)



# # -- ############################################################################ 
# # -- 				      Diviziune relationala (1)
# # -- ############################################################################ 
# # --
# # 
# # -- ############################################################################ 
# # --     Extrageti artistii si albumele de pe care s-au vandut toate piesele.
# # -- Nota: se iau in calcul numai albumele cu cel putin doua piese
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- enuntul sugereaza diviziunea relationala, insa solutia e una non-diviziune
# # SELECT artist.name, title, COUNT(DISTINCT track.trackid) AS n_of_sold_tracks_from_the_album
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track on album.albumid = track.albumid	
# # 	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # GROUP BY artist.name, title
# # HAVING artist.name || ' - ' || title || ' - ' || COUNT(DISTINCT track.trackid) IN (
# # 	SELECT artist.name || ' - ' || title || ' - ' || COUNT(track.trackid) 
# # 	FROM artist
# # 		NATURAL JOIN album
# # 		INNER JOIN track on album.albumid = track.albumid	
# # 	GROUP BY artist.name, title
# # 	HAVING COUNT(track.trackid) >= 2)
# # ORDER BY 1
# # 
# # 

# # -- solutia urmatoare se apropie de logica diviziunii
# # SELECT artist.name, title, 
# # 	string_agg(DISTINCT CAST(track.trackid AS VARCHAR), 
# # 							 '|' ORDER BY CAST(track.trackid AS VARCHAR)) 
# # 							 AS all_tracks_from_this_album,
# # 	string_agg(DISTINCT CAST(invoiceline.trackid AS VARCHAR), 
# # 							 '|' ORDER BY CAST(invoiceline.trackid AS VARCHAR)) 
# # 							 AS sold_tracks_from_the_album
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track on album.albumid = track.albumid
# # 	LEFT JOIN invoiceline ON track.trackid = invoiceline.trackid
# # GROUP BY artist.name, title
# # HAVING 
# # 	string_agg(DISTINCT CAST(track.trackid AS VARCHAR), 
# # 							 '|' ORDER BY CAST(track.trackid AS VARCHAR)) =
# # 	COALESCE(string_agg(DISTINCT CAST(invoiceline.trackid AS VARCHAR), 
# # 							 '|' ORDER BY CAST(invoiceline.trackid AS VARCHAR)), '') 	
# # 			AND string_agg(DISTINCT CAST(track.trackid AS VARCHAR), 
# # 							 '|' ORDER BY CAST(track.trackid AS VARCHAR)) LIKE '%|%'
# # ORDER BY 1
# 


###
### tidyverse
### 

# solutie care compara, pentru fiecare album, numarul de piese de pe album cu numarul
# de piese vandute
temp <- artist %>%                      # se extrage numarul de piese de pe fiecare album
     rename(artist_name = name ) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     group_by(artist_name, title) %>%
     summarise(n_of_tracks = n()) %>%
     filter (n_of_tracks > 1) %>%
          inner_join(
               # artistii, albumele si numarul de piese de pe album se vor
               #   jonctiona cu artistii, albumele si numarul de piese (de pe acel album)
               #   vandute     
     artist %>%                      # se extrage numarul de piese vandute de pe fiecare album
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          group_by(artist_name, title) %>%
          summarise(n_of_tracks = n_distinct(trackid)) 
          ) %>%
     arrange(artist_name)
     


# solutie bazata pe logica diviziunii
temp <- artist %>%                      # se extrage numarul de piese vandute de pe fiecare album
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          arrange(artist_name, title, albumid, name) %>%
          group_by(artist_name, title, albumid) %>%
          summarise (all_tracks_from_this_album = paste(name, collapse = '|'))  %>%
          ungroup() %>%
          inner_join(track) %>%     
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          distinct(artist_name, title, albumid, all_tracks_from_this_album, name) %>%
          arrange(artist_name, title, albumid, name) %>%
          group_by(artist_name, title, all_tracks_from_this_album) %>%
          summarise (sold_tracks_from_the_album = paste(name, collapse = '|'))  %>%
          ungroup() %>%
          filter (all_tracks_from_this_album == sold_tracks_from_the_album &
                    str_detect(all_tracks_from_this_album, '\\|')) %>%
          arrange(artist_name)
          



# # -- ############################################################################ 
# # -- 	 Care sunt artistii `vanduti` in toate tarile din urmatorul set:
# # --  ('USA', 'France', 'United Kingdom', 'Spain')
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# # -- enuntul sugereaza diviziunea relationala, insa solutia e una non-diviziune
# # SELECT artist.name, COUNT(DISTINCT country) AS n_of_countries
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track on album.albumid = track.albumid	
# # 	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	NATURAL JOIN customer 
# # WHERE country IN ('USA', 'France', 'United Kingdom', 'Spain')	
# # GROUP BY artist.name
# # HAVING COUNT(DISTINCT country) = 4
# # 
# # 

# # -- solutie apropiata de logica diviziunii relationale
# # SELECT artist.name, 
# # 	string_agg(DISTINCT country, '|' ORDER BY country) 
# # 							 AS countries
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track on album.albumid = track.albumid	
# # 	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	NATURAL JOIN customer 
# # WHERE country IN ('USA', 'France', 'United Kingdom', 'Spain')	
# # GROUP BY artist.name
# # HAVING string_agg(DISTINCT country, '|' ORDER BY country)  IN (
# # 	SELECT string_agg(DISTINCT country, '|' ORDER BY country) 
# # 	FROM customer
# # 	WHERE country IN ('USA', 'France', 'United Kingdom', 'Spain')	
# # 	ORDER BY 1
# # )
# 


###
### tidyverse
### 

# echivalenta primei solutii SQL
temp <- artist %>%                      
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country %in%  c('USA', 'France', 'United Kingdom', 'Spain')) %>%
          group_by(artist_name) %>%
          summarise(n_of_countries = n_distinct(country)) %>%
          filter (n_of_countries == 4)
     

# echivalenta celei de-a doua solutii SQL
temp <- artist %>%                      
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country %in%  c('USA', 'France', 'United Kingdom', 'Spain')) %>%
          distinct(artist_name, country) %>%
          arrange(artist_name, country) %>%
          group_by(artist_name) %>%
          summarise(countries = paste(country, collapse = '|')) %>%
          ungroup() %>%
          inner_join(
               customer %>%
                    filter (country %in%  c('USA', 'France', 'United Kingdom', 'Spain')) %>%
                    distinct(country) %>%
                    arrange(country) %>%
                    summarise(countries = paste(country, collapse = '|'))
          )
     

# o alta solutie echivalenta a celei de-a doua solutii SQL
temp <- artist %>%                      
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country %in%  c('USA', 'France', 'United Kingdom', 'Spain')) %>%
          distinct(artist_name, country) %>%
          arrange(artist_name, country) %>%
          group_by(artist_name) %>%
          summarise(countries = paste(country, collapse = '|')) %>%
          ungroup() %>%
          inner_join(
               c('USA', 'France', 'United Kingdom', 'Spain') %>%
               enframe() %>%
               transmute(country = value) %>%
               arrange (country) %>%     
               summarise(countries = paste(country, collapse = '|'))     
          )
     


 
# # -- ############################################################################ 
# # -- 	 Care sunt artistii `vanduti` in toate orasele din 'United Kingdom' din
# # --  					care provin clientii
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# # -- 
# # SELECT artist.name, COUNT(DISTINCT city) AS n_of_cities
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track on album.albumid = track.albumid	
# # 	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	NATURAL JOIN customer 
# # WHERE country IN ('United Kingdom')	
# # GROUP BY artist.name
# # HAVING COUNT(DISTINCT city) = (
# # 	SELECT COUNT(DISTINCT city) 
# # 	FROM customer
# # 	WHERE country IN ('United Kingdom')	
# # 	) 
# # 
# # -- solutie mai apropiata de logica diviziunii
# # SELECT artist.name, string_agg(DISTINCT city, '|' ORDER BY city) AS cities_uk
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track on album.albumid = track.albumid	
# # 	INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 	INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	NATURAL JOIN customer 
# # WHERE country IN ('United Kingdom')	
# # GROUP BY artist.name
# # HAVING string_agg(DISTINCT city, '|' ORDER BY city) = (
# # 	SELECT string_agg(DISTINCT city, '|' ORDER BY city) 
# # 	FROM customer
# # 	WHERE country IN ('United Kingdom')	
# # 	) 
# 


###
### tidyverse
### 

temp <- artist %>%                      
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country ==  'United Kingdom') %>%
          group_by(artist_name) %>%
          summarise(n_of_cities_uk = n_distinct(city)) %>%
     inner_join(
          customer %>%
               filter (country ==  'United Kingdom') %>%
               summarise(n_of_cities_uk = n_distinct(city)) 
     )

     
# solutie mai apropiata de logica diviziunii
temp <- artist %>%                      
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country ==  'United Kingdom') %>%
          distinct(artist_name, city) %>%
          arrange(artist_name, city) %>%
          group_by(artist_name) %>%
          summarise(cities_uk = paste(city, collapse = '|')) %>%
     inner_join(
          customer %>%
               filter (country ==  'United Kingdom') %>%
               distinct(city) %>%
               arrange(city) %>%
               summarise(cities_uk = paste(city, collapse = '|')) 
     )





# # -- ############################################################################ 
# # -- 				Probleme de rezolvat la curs/laborator/acasa
# # -- ############################################################################ 
# # 
# # -- Care primul (sau primii) angajat(i) in companie?
# # 
# # -- Care sunt artistii care au in baza de date mai multe albume decat formatia `Queen`?
# # 
# # 
# # 
# # 
# # 
