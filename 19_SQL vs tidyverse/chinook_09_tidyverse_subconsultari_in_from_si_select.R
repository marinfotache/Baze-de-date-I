# # -- 			 Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
# # --
# # -- 09: Subconsultari in clauzele FROM si SELECT. Diviziune relationala (2)
# # --
# # -- ultima actualizare: 2019-04-27
# # 
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2019/Studii de caz/chinook')
load("chinook.RData")

# # 
# # --
# # -- ############################################################################ 
# # -- 					Subconsultari in clauza FROM 
# # -- ############################################################################ 
# # --
# # 
# # -- ############################################################################ 
# # -- 		Care sunt celelalte albume ale artistului sau formatiei care a 
# # --     				lansat albumul `Houses of the Holy` (reluare)
# # -- ############################################################################ 
# # 
# # 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe o subconsultare in clauza FROM, care include albumul 
# # -- 'Houses Of The Holy' si numele artistului
# # select *
# # from (select artistid
# # 	  from album 
# # 	  where title = 'Houses Of The Holy'
# # 	  ) artist_anchor 
# # 	  	natural join album
# # 		natural join artist
# # 
# # 

###
### tidyverse
### 

# solutie preluata din scriptul anterior (care emuleaza logica interogarii SQL de mai sus)
temp <- album %>%
     filter (title == 'Houses Of The Holy') %>%
     select (artistid) %>%
     inner_join(album) %>%
     inner_join(artist)



# # 
# # -- ############################################################################ 
# # -- 			Care sunt piesele comune (cu acelasi titlu) de pe 
# # -- 			albumele `Fear Of The Dark` si `A Real Live One`
# # -- 					ale formatiei 'Iron Maiden' (reluare)
# # -- ############################################################################ 
# # 
# # 
# # 
# # -- SQL
# # 
# # -- solutie noua, bazata pe subconsultare in clauza FROM
# # SELECT *
# # FROM 
# # 	(SELECT track.name 
# # 	 FROM artist 
# # 	INNER JOIN album ON artist.artistid = album.artistid
# # 	INNER JOIN track ON album.albumid = track.albumid
# # 	WHERE artist.name = 'Iron Maiden' AND title = 'Fear Of The Dark') tracks_album_1	
# # 		NATURAL JOIN 
# # 	(SELECT track.name 
# # 	 FROM artist 
# # 	INNER JOIN album ON artist.artistid = album.artistid
# # 	INNER JOIN track ON album.albumid = track.albumid
# # 	WHERE artist.name = 'Iron Maiden' AND title = 'A Real Live One') tracks_album_2	
# # 
# # 

###
### tidyverse
### 

# o solutie relativ apropiata logicii SQL de mai sus
temp <- artist %>%
     filter (name == 'Iron Maiden') %>%
     select (artistid) %>%
     inner_join(album) %>%
     filter (title == 'Fear Of The Dark') %>%
     select (albumid) %>%
     inner_join(track) %>%
     select (name) %>%
          inner_join(
     artist %>%
          filter (name == 'Iron Maiden') %>%
          select (artistid) %>%
          inner_join(album) %>%
          filter (title == 'A Real Live One') %>%
          select (albumid) %>%
          inner_join(track) %>%
          select (name)               
          )
     

# # 
# # -- ############################################################################ 
# # -- 			Care sunt facturile din prima zi de vanzari? (reluare)
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe o subconsultare in clauza FROM 
# # SELECT *
# # FROM invoice NATURAL JOIN 
# # 	(SELECT MIN(invoicedate) AS invoicedate
# # 	 FROM invoice) X
# # 


###
### tidyverse
### 

# toate solutile din scriptul anterior (`chinook_08_tidyverse...`) care nu 
# folosesc `pull()` se apropie de logica de mai sus; 
# incercam si o solutie noua
temp <- min(invoice$invoicedate) %>%
     enframe() %>%
     transmute (invoicedate = value) %>%
     inner_join(invoice)



# # -- ############################################################################ 
# # -- 	   Care sunt facturile din prima saptamana de vanzari? (reluare)
# # -- ############################################################################ 
# # 
# # 
# # 
# # -- SQL
# # 
# # -- o solutie (mai complicata) cu subconsultare in clauza FROM 
# # SELECT *
# # FROM invoice 
# # 	NATURAL JOIN 
# # 	(SELECT DISTINCT invoicedate
# # 	 FROM invoice
# # 	 WHERE invoicedate BETWEEN (SELECT MIN(invoicedate) FROM invoice) AND 
# # 		(SELECT MIN(invoicedate) + INTERVAL '7 DAYS' FROM invoice))  X		
# # 


###
### tidyverse
### 
# toate solutile din scriptul anterior (`chinook_08_tidyverse...`) care nu 
# folosesc `pull()` se apropie de logica de mai sus; 
# incercam si o solutie noua
temp <- seq(
          min(trunc(invoice$invoicedate)),
          (min(trunc(invoice$invoicedate)) + 
                 lubridate::period(days = 7)),
          by = 'day') %>%
     enframe() %>%
     transmute (invoicedate = value) %>%
     inner_join(invoice)





# # 
# # -- ############################################################################ 
# # -- 		Care sunt albumele formatiei Led Zeppelin care au mai multe piese
# # --                  decat albumul `IV` (reluare) 
# # -- ############################################################################ 
# # -- SQL
# # 
# # -- solutie care transforma grupurile in tupluri (inregistrari) si 
# # --   apoi le (theta-)jonctioneaza
# # SELECT *
# # FROM (SELECT title AS album_title, COUNT(*) AS n_of_tracks
# # 	  FROM album
# # 		NATURAL JOIN artist
# # 		INNER JOIN track on album.albumid = track.albumid	
# # 	  WHERE artist.name = 'Led Zeppelin'
# # 	  GROUP BY title
# # 	 	) albums_lz
# # 			INNER JOIN   -- HERE IS A THETA-JOIN (in case you missed it !!!)
# # 	(SELECT COUNT(*) AS n_of_tracks_lz_4
# # 	 FROM album
# # 		NATURAL JOIN artist
# # 		INNER JOIN track on album.albumid = track.albumid	
# # 	WHERE artist.name = 'Led Zeppelin' AND title = 'IV') lz_4
# # 			ON albums_lz.n_of_tracks > lz_4.n_of_tracks_lz_4
# # ORDER BY 1
# # 
# # 

###
### tidyverse
### 

# intrucat theta-jonctiunea nu e posibila in tidyverse, ramanem la cele doua solutii
# din scriptul precedent (cea de mai jos este a doua)
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



# # -- ############################################################################ 
# # -- 			Afisati, pentru fiecare client, pe coloane separate, 
# # -- 				vanzarile pe anii 2010, 2011 si 2012 (reluare)
# # -- ############################################################################ 
# # 
# # 
# # 
# # -- SQL
# # 
# # -- solutie bazata pe subconsultari in clauza FROM 
# # SELECT lastname || ' ' || firstname AS customer_name, 
# # 	city, state, country,
# # 	COALESCE(sales2011.sales, 0) AS sales2010, 
# # 	COALESCE(sales2011.sales, 0) AS sales2011, 
# # 	COALESCE(sales2012.sales, 0) AS sales2012 	
# # FROM customer 
# # 	LEFT JOIN 
# # 			(SELECT customerid, SUM(total) AS sales
# # 		 	 FROM invoice 
# # 		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2010
# # 		 	 GROUP BY customerid) sales2010
# # 		ON customer.customerid = sales2010.customerid 
# # 	LEFT JOIN 
# # 			(SELECT customerid, SUM(total) AS sales 
# # 		 	 FROM invoice 
# # 		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2011
# # 		 	 GROUP BY customerid) sales2011
# # 		ON customer.customerid = sales2011.customerid 
# # 	LEFT JOIN 
# # 			(SELECT customerid, SUM(total) AS sales 
# # 		 	 FROM invoice 
# # 		 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2012
# # 		 	 GROUP BY customerid) sales2012
# # 		ON customer.customerid = sales2012.customerid 
# # ORDER BY 1
# # 
# # 

###
### tidyverse
### 

# solutia cea mai eleganta se bazeaza pe `spread`
temp <- invoice %>%
     transmute (customerid, total, year = lubridate::year(invoicedate)) %>%
     filter (year %in% c(2010, 2011, 2012)) %>%
     group_by(customerid, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup() %>%
     inner_join(customer %>%
                     transmute (customerid, customer_name = paste(lastname, firstname), 
                                state, country)) %>%
     spread(year, sales, fill = 0) %>%
     arrange(customer_name)



# # -- ############################################################################ 
# # --  		Afisati ponderea fiecarei luni in vanzarile anului 2010
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# # -- solutia afiseaza toate lunile anului, chiar si cele fara vanzari
# # SELECT months.month, monthly_sales, sales_2010, 
# # 	ROUND (monthly_sales / sales_2010, 2) AS month_share
# # FROM
# # 	(SELECT CAST (month AS NUMERIC) AS month FROM generate_series (1, 12, 1) months (month)) months
# # 	LEFT JOIN 		 
# # 		(SELECT CAST (EXTRACT (MONTH FROM invoicedate) AS NUMERIC) AS month, SUM(total) AS monthly_sales
# # 	 	 FROM invoice 
# # 	 	 WHERE EXTRACT (YEAR FROM invoicedate) = 2010  
# # 		 GROUP BY EXTRACT (MONTH FROM invoicedate) )  monthly_sales 
# # 		ON months.month = monthly_sales.month
# # 	CROSS JOIN 	
# # 		(SELECT SUM(total) AS sales_2010 FROM invoice WHERE EXTRACT (YEAR FROM invoicedate) = 2010) sales2010
# # 	 


###
### tidyverse
### 

temp <- 1:12 %>%
     enframe() %>%
     transmute (month = value) %>%
     left_join(
          invoice %>%
               filter (lubridate::year(invoicedate) == 2010) %>%
               mutate(month = lubridate::month(invoicedate)) %>%
               group_by(month) %>%
               summarise (monthly_sales = sum(total)) %>%
               ungroup()
     ) %>%
     mutate (sales_2010 = sum(monthly_sales), 
             month_share = round(monthly_sales / sales_2010,2))
     
     


# # --
# # -- ############################################################################ 
# # -- 						Diviziune relationala (2)
# # -- ############################################################################ 
# # --
# # 
# # 
# # -- ############################################################################ 
# # -- 	 Care sunt artistii `vanduti` in toate orasele din 'United Kingdom' din
# # --  					care provin clientii (reluare)
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# # -- solutie `pur divizionala` (fara nicio grupare):
# # -- idee dintre toti artistii ii eliminam pe cei care nu apar in toate 
# # --   combinatiile posibile (obtinute prin CROSS-JOIN) `artist`-`oras`
# # SELECT  artist.name AS artist_name
# # FROM artist
# # EXCEPT
# # SELECT DISTINCT artist_name
# # FROM 
# # 	(SELECT artist.name AS artist_name, city
# # 	FROM artist CROSS JOIN 
# # 	 	(SELECT DISTINCT city FROM customer WHERE country IN ('United Kingdom') ) cities
# # 	) cross_join_artists_cities
# # WHERE artist_name || ' - ' || city NOT IN (
# # 	SELECT DISTINCT artist.name || ' - ' || city
# # 	FROM artist
# # 		NATURAL JOIN album
# # 		INNER JOIN track on album.albumid = track.albumid	
# # 		INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 		INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 		NATURAL JOIN customer 
# # 	WHERE country IN ('United Kingdom')	) 
# # ORDER BY 1
# # 

###
### tidyverse
### 

# o solutie care transpune logica diviziunii relationale
temp <- dplyr::setdiff(
     artist %>%
          transmute(artist_name = name ),
     artist %>%
               transmute(artist_name = name ) %>%
               mutate (foo = 1) %>%
          inner_join(
               customer %>%
                    filter (country ==  'United Kingdom') %>%
                    distinct(city) %>%
                    mutate (foo = 1)
          ) %>%
          select (-foo) %>%
          anti_join(
               artist %>%               
                    rename(artist_name = name ) %>%
                    inner_join(album) %>%
                    inner_join(track) %>%
                    select (-unitprice) %>%
                    inner_join(invoiceline) %>%
                    inner_join(invoice) %>%
                    inner_join(customer) %>%
                    filter (country ==  'United Kingdom') %>%
                    distinct(artist_name, city)
          )   %>%
     transmute(artist_name)     
     )

     

# # 
# # -- ############################################################################ 
# # -- 	 Care sunt artistii `vanduti` in toti anii (adica, in fiecare an) din 
# # --    intervalul 2009-2012
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutie `pur divizionala` :
# # SELECT artist.name AS artist
# # FROM artist
# # EXCEPT
# # SELECT artist_name
# # FROM 
# # 	(SELECT name AS artist_name FROM artist) artists
# # 		CROSS JOIN 
# # 	(SELECT *
# # 	 FROM generate_series (2009, 2012, 1)) years (year)
# # WHERE artist_name || ' - ' || year NOT IN (
# # 	SELECT DISTINCT artist.name || ' - ' || EXTRACT (YEAR FROM invoicedate)
# # 	FROM artist
# # 		NATURAL JOIN album
# # 		INNER JOIN track on album.albumid = track.albumid	
# # 		INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 		INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	)
# # 
# # 

###
### tidyverse
### 

# o solutie care transpune logica diviziunii relationale
temp <- dplyr::setdiff(
     artist %>%
          transmute(artist_name = name ),
     artist %>%
               transmute(artist_name = name ) %>%
               mutate (foo = 1) %>%
          inner_join(
               2009:2012 %>%
                    enframe() %>%
                    transmute (year = value) %>%
                    mutate (foo = 1)
          ) %>%
          select (-foo) %>%
          anti_join(
               artist %>%               
                    rename(artist_name = name ) %>%
                    inner_join(album) %>%
                    inner_join(track) %>%
                    select (-unitprice) %>%
                    inner_join(invoiceline) %>%
                    inner_join(invoice) %>%
                    mutate (year = lubridate::year(invoicedate)) %>%
                    inner_join(
                         2009:2012 %>%
                              enframe() %>%
                              transmute (year = value) 
                              ) %>%
                    distinct(artist_name, year)
          ) %>%
     transmute(artist_name)
     )



# 
# # -- ############################################################################ 
# # -- 	 Care sunt artistii pentru care au fost vanzari macar (cel putin) 
# # --          in toti anii in care s-au vandut piese ale formatiei `Queen`
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # -- solutie `non-divizionala` :
# # SELECT name
# # FROM 
# # 	(SELECT DISTINCT EXTRACT (YEAR FROM invoicedate) AS year
# # 	 FROM
# # 		artist
# # 		 	INNER JOIN album ON artist.artistid = album.artistid 
# # 			INNER JOIN track ON album.albumid = track.albumid	
# # 			INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 			INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	 WHERE artist.name = 'Queen') years_queen
# # 			INNER JOIN 
# # 	(SELECT DISTINCT artist.name, EXTRACT (YEAR FROM invoicedate) AS year
# # 	 FROM
# # 		artist
# # 		 	INNER JOIN album ON artist.artistid = album.artistid 
# # 			INNER JOIN track ON album.albumid = track.albumid	
# # 			INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 			INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	 ) years_queen__artists ON years_queen.year = years_queen__artists.year
# # GROUP BY name
# # HAVING COUNT(years_queen__artists.year) = (
# # 	SELECT COUNT(*)
# # 	FROM 
# # 		(SELECT DISTINCT EXTRACT (YEAR FROM invoicedate) AS year
# # 		 FROM
# # 			artist
# # 		 		INNER JOIN album ON artist.artistid = album.artistid 
# # 				INNER JOIN track ON album.albumid = track.albumid	
# # 				INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 				INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	 	WHERE artist.name = 'Queen') years_queen
# # 	)
# # 		
# #
# # -- solutie `pur divizionala` :
# # SELECT artist.name AS artist
# # FROM artist
# # EXCEPT
# # SELECT artist_name
# # FROM 
# # 	(SELECT name AS artist_name FROM artist) artists
# # 		CROSS JOIN 
# # 	(SELECT DISTINCT EXTRACT (YEAR FROM invoicedate) AS year
# # 	 FROM invoice
# # 	 	NATURAL JOIN invoiceline
# # 	 	NATURAL JOIN track
# # 	 WHERE albumid IN (SELECT albumid 
# # 					   FROM album NATURAL JOIN artist
# # 					    WHERE name = 'Queen')) years_u2	 
# # WHERE artist_name || ' - ' || year NOT IN (
# # 	SELECT DISTINCT artist.name || ' - ' || EXTRACT (YEAR FROM invoicedate)
# # 	FROM artist
# # 		INNER JOIN album ON artist.artistid = album.artistid 
# # 		INNER JOIN track ON album.albumid = track.albumid	
# # 		INNER JOIN invoiceline ON track.trackid = invoiceline.trackid
# # 		INNER JOIN invoice ON  invoiceline.invoiceid = invoice.invoiceid
# # 	)
# # 


###
### tidyverse
### 

# solutie mai apropiata de logica `non-divizionala` 
temp <- artist %>%                                      #---------------------
     filter (name == 'Queen') %>%                       #        
     select (artistid) %>%                              #
     inner_join(album) %>%                              #   here we get the
     inner_join(track) %>%                              #  all the sales
     select (-unitprice) %>%                            #  years for 
     inner_join(invoiceline) %>%                        #  artist/band
     inner_join(invoice) %>%                            #  `Queen`
     mutate (year = lubridate::year(invoicedate)) %>%   #
     distinct (year)  %>%                               #--------------------
     mutate (n_of_years_queen = n()) %>%    # add a column with the number of years for `Queen`
     inner_join(
          artist %>%                                   #-------------------
               rename (artist_name  = name) %>%        #  
               inner_join(album) %>%                   #  here we get
               inner_join(track) %>%                   #  all the sales years
               select (-unitprice) %>%                 #    for each artist,
               inner_join(invoiceline) %>%             #  i.e. 
               inner_join(invoice) %>%                 #  all distinct
               mutate (year =                          #  values
                    lubridate::year(invoicedate)) %>%  #  (artist_name, year)
               distinct (artist_name, year)            #-------------------
     )  %>% 
          # at this point, we have all (artist_name, year) combinations,
          # but only for "Queen years";
          #    next, we'll compute the number of years for each artist
          #    (carrying the `n_of_years_queen`)
     group_by(artist_name, n_of_years_queen) %>%
     tally() %>%
     ungroup() %>%
     filter (n == n_of_years_queen)
     
     


# solutie apropiata de logica diviziunii relationale 
temp <- artist %>%                                      
     rename (artist_name = name) %>%                              
     inner_join(album) %>%                              
     inner_join(track) %>%                             
     select (-unitprice) %>%                          
     inner_join(invoiceline) %>%                      
     inner_join(invoice) %>%                            
     mutate (year = lubridate::year(invoicedate)) %>%   
     distinct (artist_name, year)  %>%
     arrange (artist_name, year)  %>%
     inner_join(
          artist %>%                                      
          filter (name == 'Queen') %>%                          
          select (artistid) %>%                              
          inner_join(album) %>%                              
          inner_join(track) %>%                             
          select (-unitprice) %>%                          
          inner_join(invoiceline) %>%                      
          inner_join(invoice) %>%                            
          mutate (year = lubridate::year(invoicedate)) %>%   
          distinct (year)         
     ) %>%
     group_by(artist_name) %>%
     summarise (years = paste(year, collapse = '|')) %>%
     ungroup() %>%
     
     inner_join(

               artist %>%                                      
                    filter (name == 'Queen') %>%                          
                    select (artistid) %>%                              
                    inner_join(album) %>%                              
                    inner_join(track) %>%                             
                    select (-unitprice) %>%                          
                    inner_join(invoiceline) %>%                      
                    inner_join(invoice) %>%                            
                    mutate (year = lubridate::year(invoicedate)) %>%   
                    distinct (year)  %>% 
                    arrange(year) %>%
                    summarise (years = paste(year, collapse = '|'))
          
     )     
     
     
     
     
# # 
# # --
# # -- ############################################################################ 
# # -- 				Subconsultari in clauza SELECT, ... 
# # -- ############################################################################ 
# # --
# # 


####
#### Logica  `tidyverse` nu se pliaza pe problematica subconsultarilor din SQL;
####      in schimb, toate problemele care in SQL se folosesc subconsultari, 
####      cu sau fara corelare, au solutii in `tidyverse`
####       


