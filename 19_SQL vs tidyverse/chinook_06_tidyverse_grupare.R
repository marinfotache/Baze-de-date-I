# -- 		Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
# --
# -- 06: Grupare - group by, subtotaluri, having
# --
# -- ultima actualizare: 2019-04-16
# 
# 
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2019/Studii de caz/chinook')
load("chinook.RData")

# 
# # -- ############################################################################
# # -- 				 Extrageti numarul albumelor fiecarui artist
# # -- ############################################################################
# # 
# # -- SQL
# # SELECT name AS artist_name, COUNT(*) as n_of_albums
# # FROM artist NATURAL JOIN album
# # GROUP BY name
# # ORDER BY 1


###
### tidyverse
### 

# solutie bazata pe `group_by` si `summarise`  (este recomandabil sa "de-grupam"
# inregistratile dupa `summarise`)
temp <- artist %>%
     inner_join(album) %>%
     group_by(artist_name = name) %>%
     summarise(n_of_albums = n()) %>%
     ungroup() %>%
     arrange(artist_name)


# solutie bazata pe functia `count`  (nu mai necesara functia `ungroup`)
temp <- artist %>%
     inner_join(album) %>%
     count(artist_name = name) 

     
# solutie bazata pe grupare si `tally`  
temp <- artist %>%
     inner_join(album) %>%
     group_by(artist_name = name) %>%
     tally() %>%
     ungroup()



# # -- ############################################################################
# # -- 	  Extrageti durata totala a pieselor (in minute) pentru fiecare artist
# # -- ############################################################################
# # 
# # -- SQL
# # SELECT artist.name AS artist_name,
# # 	ROUND(SUM(milliseconds / 60000)) AS duration_minutes
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track ON album.albumid = track.albumid
# # GROUP BY artist.name
# # ORDER BY artist.name
# # 
# # 
###
### tidyverse
### 

# solutie bazata pe `group_by` si `summarise`  (este recomandabil sa "de-grupam"
# inregistratile dupa `summarise`)
temp <- artist %>%
     rename(artist_name = name) %>%
     inner_join(album) %>%
     inner_join(track)  %>%
     group_by(artist_name) %>%
     summarise(duration_minutes = trunc(sum(milliseconds /60000 ))) %>%
     ungroup() %>%
     arrange(artist_name)




# # -- ############################################################################
# # --       Extrageti durata totala a pieselor (in minute) pentru fiecare
# # --            album al fiecarui artist, cu afisare de tipul HH:MI:SS
# # --                    (durata in minute si secunde)
# # -- ############################################################################
# # 
# # -- SQL
# # SELECT artist.name AS artist_name, title AS album_title,
# # 	SUM(milliseconds / 1000) * interval '1 sec' AS duration
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track ON album.albumid = track.albumid
# # GROUP BY artist.name, title
# # ORDER BY artist.name, title
# # 

###
### tidyverse
### 

temp <- artist %>%
     rename(artist_name = name) %>%
     inner_join(album) %>%
     inner_join(track)  %>%
     group_by(artist_name, title) %>%
     summarise(duration = trunc(sum(milliseconds / 1000)))  %>%
     ungroup() %>%
     mutate(duration = lubridate::seconds_to_period(duration)) %>%
     arrange(artist_name, title)




# # -- ############################################################################
# # --      Afisati toate piesele de pe toate albumele tuturor artistilor;
# # -- Calculati durata in minute si secunde la nivel de album si la nivel de artist,
# # --                    precum si un total general
# # -- ############################################################################

# # -- SQL
# # SELECT artist.name AS artist_name, title AS album_title, track.name as track_name,
# # 	milliseconds / 1000 * interval '1 sec' AS duration
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track ON album.albumid = track.albumid
# # 		UNION
# # SELECT artist.name AS artist_name, title AS album_title, '~ SUBTOTAL ON ALBUM',
# # 	SUM(milliseconds / 1000) * interval '1 sec' AS duration_minutes
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track ON album.albumid = track.albumid
# # GROUP BY artist.name, title
# # 		UNION
# # SELECT artist.name AS artist_name, '~~ SUBTOTAL ON ARTIST', '~~~~',
# # 	SUM(milliseconds / 1000) * interval '1 sec' AS duration_minutes
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track ON album.albumid = track.albumid
# # GROUP BY artist.name
# # 		UNION
# # SELECT '~~ GRAND TOTAL ~~', '~~~~~', '~~~~~',
# # 	SUM(milliseconds / 1000) * interval '1 sec' AS duration_minutes
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track ON album.albumid = track.albumid
# # ORDER BY 1, 2, 3
# # 
# # 
# 
# # -- solutie bazata pe ROLLUP, cu valori NULL care indica subtotalurile si totalul general
# # SELECT artist.name AS artist_name, 
# # 	title as album_title, 	
# # 	track.name as track_name, 
# # 	SUM(milliseconds / 1000 * interval '1 sec') AS duration
# # FROM artist 
# # 	NATURAL JOIN album 
# # 	INNER JOIN track ON album.albumid = track.albumid
# # GROUP BY ROLLUP (1, 2, 3 )
# # ORDER BY 1, 2, 3


###
### tidyverse
### 

# afisam codurile UTF pentru a selecta un simbol pentru substotaluri
# si total general 
for (i in 1:2000)
     print(paste0(i, ' - `', intToUtf8(i), '`'))

# solutia:
temp <- bind_rows(
     # rand principal din rezultat
     artist %>%
          rename(artist_name = name) %>%
          inner_join(album) %>%
          inner_join(track)  %>%
          transmute (artist_name, title, track_name = name, 
               duration = trunc(milliseconds / 1000)), 
     
     # subtotal la nivel de album
     artist %>%
          rename(artist_name = name) %>%
          inner_join(album) %>%
          inner_join(track)  %>%
          transmute (artist_name, title, track_name = 'Σ SUBTOTAL ON ALBUM }', milliseconds) %>%
          group_by(artist_name, title, track_name) %>%
          summarise(duration = trunc(sum(milliseconds / 1000)))  %>%
          ungroup(),
     
     # subtotal la nivel de artist
     artist %>%
          rename(artist_name = name) %>%
          inner_join(album) %>%
          inner_join(track)  %>%
          transmute (artist_name, title = 'Σ SUBTOTAL ON ARTIST', 
                     track_name = '}', milliseconds) %>%
          group_by(artist_name, title, track_name) %>%
          summarise(duration = trunc(sum(milliseconds / 1000)))  %>%
          ungroup(),

     artist %>%
          rename(artist_name = name) %>%
          inner_join(album) %>%
          inner_join(track)  %>%
          transmute (artist_name = 'Σ GRAND TOTAL ', 
                     title = '}', 
                     track_name = ' ', milliseconds) %>%
          group_by(artist_name, title, track_name) %>%
          summarise(duration = trunc(sum(milliseconds / 1000)))  %>%
          ungroup()  
     ) %>%
     mutate(duration = lubridate::seconds_to_period(duration)) %>%
     arrange(artist_name, title, track_name)



# 
# # -- ############################################################################
# # --               Afisati, pentru fiecare client, pe trei linii separate,
# # --                       vanzarile pe anii 2010, 2011 si 2012
# # -- ############################################################################
# # 
# # -- SQL
# 
# # SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
# # 	2010 as year, 
# # 	sum(case when extract (year from invoicedate) = 2010 then total else 0 end) as sales
# # FROM customer 
# # 	NATURAL JOIN invoice
# # GROUP BY lastname || ' ' || firstname, city, state, country
# # 	UNION
# # SELECT lastname || ' ' || firstname, city, state, country,
# # 	2011, 
# # 	sum(case when extract (year from invoicedate) = 2011 then total else 0 end)
# # FROM customer 
# # 	NATURAL JOIN invoice
# # GROUP BY lastname || ' ' || firstname, city, state, country 		
# # 		UNION
# # SELECT lastname || ' ' || firstname, city, state, country,
# # 	2012, 
# # 	sum(case when extract (year from invoicedate) = 2012 then total else 0 end)
# # FROM customer 
# # 	NATURAL JOIN invoice
# # GROUP BY lastname || ' ' || firstname, city, state, country 		
# # ORDER BY 1, 2, 3, 4, 5


###
### tidyverse
### 


# solutie corecta, dar incompleta
temp <- bind_rows(
     
     # 2010
     customer %>%
          inner_join(invoice %>%
                          mutate(year = lubridate::year(invoicedate)) %>%
                         filter( year == 2010) 
                     ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup(),

     # 2011
     customer %>%
          inner_join(invoice %>%
                         mutate(year = lubridate::year(invoicedate)) %>%
                         filter( year == 2011) 
                     ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup(),
     
     # 2012
     customer %>%
          inner_join(invoice %>%
                          mutate(year = lubridate::year(invoicedate)) %>%
                         filter( year == 2012) 
                     ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup()

     ) %>%
     arrange(customer_name, city, state, country, year)


# solutie corecta & completa
temp <- bind_rows(
          invoice %>%
               transmute(customerid, invoicedate = lubridate::ymd(invoicedate), total),
          # here we inject an empty invoice for each cutomer for year 2010
          customer %>%
               transmute(customerid, invoicedate = lubridate::ymd('2010-01-01'), total = 0),
          # here we inject an empty invoice for each cutomer for year 2011
          customer %>%
               transmute(customerid, invoicedate = lubridate::ymd('2011-01-01'), total = 0),
          # here we inject an empty invoice for each cutomer for year 2012
          customer %>%
               transmute(customerid, invoicedate = lubridate::ymd('2012-01-01'), total = 0)
               ) %>%
     inner_join(customer) %>%
     mutate(year = lubridate::year(invoicedate)) %>%
     filter( year %in% c(2010, 2011, 2012) ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup() %>%
     arrange(customer_name, city, state, country, year)

 

# # 
# # -- ############################################################################
# # --                 Afisati, pentru fiecare client, pe coloane separate,
# # --                       vanzarile pe anii 2010, 2011 si 2012
# # -- ############################################################################
# # 

# # -- SQL
# 
# # -- solutie bazata pe jonctiune interna, grupare si CASE
# # SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
# # 	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2010 THEN total ELSE 0 END ) AS sales2010,
# # 	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2011 THEN total ELSE 0 END ) AS sales2011,
# # 	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2012 THEN total ELSE 0 END ) AS sales2012
# # FROM customer
# # 	NATURAL JOIN invoice
# # GROUP BY lastname || ' ' || firstname, city, state, country
# # ORDER BY 1
# # 


###
### tidyverse
### 

# solutie 1 - bazate pe sum(if_else...)
temp <- invoice %>%
          transmute(customerid, invoicedate = lubridate::ymd(invoicedate), total) %>%
     inner_join(customer) %>%
     mutate(year = lubridate::year(invoicedate)) %>%
     filter( year %in% c(2010, 2011, 2012) ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country) %>%
     summarise(
          sales2010 = sum(if_else(year == 2010, total, 0)),
          sales2011 = sum(if_else(year == 2011, total, 0)),
          sales2012 = sum(if_else(year == 2012, total, 0))
               ) %>%
     ungroup() %>%
     arrange(customer_name, city, state, country)


# solutie 2 - bazate pe `tidyr::spread`
temp <- invoice %>%
          transmute(customerid, invoicedate = lubridate::ymd(invoicedate), total) %>%
     inner_join(customer) %>%
     mutate(year = lubridate::year(invoicedate)) %>%
     filter( year %in% c(2010, 2011, 2012) ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
     summarise(total = sum(total)) %>%
     ungroup() %>%
     mutate(year = paste0('sales', year)) %>%   # vrem sa in antet sa apara `salesxxxx`
     tidyr::spread(year, total, fill = 0)
     
     
# 
# # -- ############################################################################ 
# # --                 Afisati, pentru fiecare client, pe coloane separate, 
# # --                       vanzarile pentru toti anii!
# # -- ############################################################################ 
# # 

# # -- SQL

# # -- in SQL solutia nu poate fi generalizata, asa ca:
# # 
# # -- in pasul 1, extragem anii...
# # SELECT DISTINCT EXTRACT (YEAR FROM invoicedate )
# # FROM invoice
# # ORDER BY 1
# # 
# # -- ...  iar in pasul 2...
# # SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
# # 	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2009 THEN total ELSE 0 END ) AS sales2009,
# # 	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2010 THEN total ELSE 0 END ) AS sales2010,
# # 	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2011 THEN total ELSE 0 END ) AS sales2011,
# # 	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2012 THEN total ELSE 0 END ) AS sales2012,
# # 	SUM(CASE WHEN EXTRACT (YEAR FROM invoicedate ) = 2013 THEN total ELSE 0 END ) AS sales2013
# # FROM customer 
# # 	NATURAL JOIN invoice
# # GROUP BY lastname || ' ' || firstname, city, state, country 		
# # ORDER BY 1


###
### tidyverse
### 

# solutia urmatoare functioneaza identic, indiferent de numarul anilor din BD
temp <- invoice %>%
          transmute(customerid, invoicedate = lubridate::ymd(invoicedate), total) %>%
     inner_join(customer) %>%
     mutate(year = lubridate::year(invoicedate)) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
     summarise(total = sum(total)) %>%
     ungroup() %>%
     mutate(year = paste0('sales', year)) %>%   # vrem sa in antet sa apara `salesxxxx`
     tidyr::spread(year, total, fill = 0)




# # -- ############################################################################
# # --             Extrageti artistii cu o durata totala a pieselor
# # --                         mai mare de 100 de minute
# # -- ############################################################################
# # 
# 
# # -- SQL
# 
# # -- solutie bazata pe HAVING
# # SELECT artist.name AS artist_name,
# # 	ROUND(SUM(milliseconds / 60000)) AS duration_minutes
# # FROM artist
# # 	NATURAL JOIN album
# # 	INNER JOIN track ON album.albumid = track.albumid
# # GROUP BY artist.name
# # HAVING ROUND(SUM(milliseconds / 60000)) >= 100
# # ORDER BY artist.name
# # 


###
### tidyverse
### 

# in tidyverse nu e nicio diferenta in WHERE si HAVING...
temp <- artist %>%
     rename(artist_name = name) %>%
     inner_join(album) %>%
     inner_join(track)  %>%
     group_by(artist_name) %>%
     summarise(duration_minutes = trunc(sum(milliseconds /60000 ))) %>%
     ungroup() %>%
     filter (duration_minutes >= 100 ) %>% # echivalentul lui HAVING 
     arrange(artist_name)



# 
# 
# -- ############################################################################ 
# -- 			Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################ 
# 
# -- Afisati numarul de piese din fiecare tracklist
# 
# -- Care este cel mai vandut gen muzical?
# 
# -- Care este angajatul cu cei mai multi subordonati directi ? (de ordinul 1)
# 
# 





