# 
# # -- 				Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
# # --
# # -- 07: Jonctiuni externe
# # --
# # -- ultima actualizare: 2019-04-16
# # 
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2019/Studii de caz/chinook')
load("chinook.RData")

# # -- ############################################################################ 
# # -- 		Care sunt artistii care, momentan, nu au niciun album preluat in BD?
# # -- ############################################################################ 
# # 
# # -- SQL
# 
# # # -- solutie bazata pe diferenta
# # SELECT artist.*
# # FROM artist 
# # EXCEPT
# # SELECT artist.*
# # FROM artist INNER JOIN album ON artist.artistid = album.artistid
# # ORDER BY name
# 
# 
# # -- solutie bazata pe jonctiune externa
# # SELECT *
# # FROM artist LEFT JOIN album ON artist.artistid = album.artistid
# # WHERE title IS NULL
# # ORDER BY name
# # 


###
### tidyverse
### 

# solutie bazata pe diferenta (`dplyr::setdiff`) si `semi_join`
temp <- dplyr::setdiff(
     artist, 
     artist %>%
          semi_join(album)
     ) %>%
     arrange(name)


# solutie bazata pe `anti_join`
temp <- artist %>%
     anti_join(album) %>%
     arrange(name)


# solutie bazata pe `left_join`
temp <- artist %>%
     left_join(album) %>%
     filter (is.na(title)) %>%
     arrange(name)
     
     


# # -- ############################################################################ 
# # -- Extrageti numarul albumelor fiecarui artist; pentru artistii (actualmente) 
# # -- 					fara albume, sa se afiseze `0`
# # -- ############################################################################ 
# # 
# # -- SQL
# # 
# # -- solutia corecta necesita optiunea LEFT JOIN (275 de linii in rezultat)
# # SELECT name AS artist_name, COUNT(albumid) AS nr_albume
# # FROM artist LEFT JOIN album ON artist.artistid = album.artistid
# # GROUP BY name
# # ORDER BY name
# # 

###
### tidyverse
### 

# solutie bazata pe `left_join` si `count`
temp <- artist %>%
     left_join(album) %>%
     count(name) %>%
     arrange(name)


# solutie bazata pe `left_join`, `group_by` si `tally`
temp <- artist %>%
     left_join(album) %>%
     group_by(name) %>%
     tally() %>%
     arrange(name)


# solutie bazata pe `left_join`, `group_by` si `tally`
temp <- artist %>%
     left_join(album) %>%
     group_by(name) %>%
     summarise(n = n()) %>%
     arrange(name)


# # 
# # -- ############################################################################ 
# # -- 		Care sunt artistii care, momentan, nu au niciun album preluat in BD?
# # -- ############################################################################ 
# # 
# # -- SQL
# 
# # -- solutie bazata pe grupare
# # 
# # SELECT name AS artist_name, COUNT(albumid) AS nr_albume
# # FROM artist LEFT JOIN album ON artist.artistid = album.artistid
# # GROUP BY name
# # HAVING COUNT(albumid) = 0
# # ORDER BY name
# # 


###
### tidyverse
### 
 

# solutia bazata pe `left_join` si `count` NU FUNCTIONEAZA!!!
temp <- artist %>%
     left_join(album) %>%
     count(name, na.rm = TRUE) %>%
     filter ( n == 0) %>%
     arrange(name)


# nici solutia bazata pe `left_join`, `group_by` si `tally` NU FUNCTIONEAZA!!!
temp <- artist %>%
     left_join(album) %>%
     group_by(name) %>%
     tally() %>%
     ungroup() %>%
     filter ( n == 0) %>%
     arrange(name)


# nici solutia bazata pe `left_join`, `group_by` si `tally` NU FUNCTIONEAZA!!!...
temp <- artist %>%
     left_join(album) %>%
     group_by(name) %>%
     summarise(n = n()) %>%
     ungroup() %>%
     filter ( n == 0) %>%
     arrange(name)


# ... insa poate fi adaptata
temp <- artist %>%
     left_join(album) %>%
     group_by(name) %>%
     summarise(n = sum(if_else(is.na(title), 0, 1))) %>%
     ungroup() %>%
     filter ( n == 0) %>%
     arrange(name)




# # -- ############################################################################ 
# # -- 			Afisati, pentru fiecare client, pe trei linii separate, 
# # -- 					vanzarile pe anii 2010, 2011 si 2012
# # -- ############################################################################ 
# # 
# # -- SQL
# 
# # -- o solutie bazata pe jonctiune externe, grupare si UNION
# # SELECT lastname || ' ' || firstname AS customer_name, city, state, country, 
# # 	2010 AS year, COALESCE(SUM(total), 0) AS sales
# # FROM customer 
# # 	LEFT JOIN invoice ON customer.customerid = invoice.customerid AND
# # 		EXTRACT (YEAR FROM invoice.invoicedate) = 2010
# # GROUP BY lastname || ' ' || firstname, city, state, country 		
# # 	UNION
# # SELECT lastname || ' ' || firstname AS customer_name, city, state, country, 
# # 	2011 AS year, COALESCE(SUM(total), 0) AS sales
# # FROM customer 
# # 	LEFT JOIN invoice ON customer.customerid = invoice.customerid AND
# # 		EXTRACT (YEAR FROM invoice.invoicedate) = 2011
# # GROUP BY lastname || ' ' || firstname, city, state, country 		
# # 	UNION
# # SELECT lastname || ' ' || firstname AS customer_name, city, state, country, 
# # 	2012 AS year, COALESCE(SUM(total), 0) AS sales
# # FROM customer 
# # 	LEFT JOIN invoice ON customer.customerid = invoice.customerid AND
# # 		EXTRACT (YEAR FROM invoice.invoicedate) = 2012
# # GROUP BY lastname || ' ' || firstname, city, state, country 		
# # ORDER BY customer_name, year
# # 
# # 


###
### tidyverse
### 
# solutie corecta & completa
temp <- bind_rows(
     
     # 2010
     customer %>%
     select (customerid:lastname, city:country) %>%
          left_join(
               invoice %>%
                    transmute(customerid, year = lubridate::year(lubridate::ymd(invoicedate)), 
                              total) %>%
                    filter (year == 2010) %>%
               group_by(customerid, year) %>%
               summarise (sales = sum(total))
          ) %>%
     mutate(year = coalesce(year, 2010), sales = coalesce(sales, 0)),

     # 2011
     customer %>%
     select (customerid:lastname, city:country) %>%
          left_join(
               invoice %>%
                    transmute(customerid, year = lubridate::year(lubridate::ymd(invoicedate)), 
                              total) %>%
                    filter (year == 2011) %>%
               group_by(customerid, year) %>%
               summarise (sales = sum(total))
          ) %>%
     mutate(year = coalesce(year, 2011), sales = coalesce(sales, 0)),

     # 2012
     customer %>%
     select (customerid:lastname, city:country) %>%
          left_join(
               invoice %>%
                    transmute(customerid, year = lubridate::year(lubridate::ymd(invoicedate)), 
                              total) %>%
                    filter (year == 2012) %>%
               group_by(customerid, year) %>%
               summarise (sales = sum(total))
          ) %>%
     mutate(year = coalesce(year, 2012), sales = coalesce(sales, 0))
     ) %>%
     transmute(customer_name = paste(lastname, firstname), city, state, country, year, sales) %>%
     arrange(customer_name, city, state, country, year)




 

# # -- ############################################################################ 
# # -- 			Afisati, pentru fiecare client, pe coloane separate, 
# # -- 					vanzarile pe anii 2010, 2011 si 2012
# # -- ############################################################################ 

# # -- SQL
# 
# # -- solutia urmatoare este eronata !!!!! (trebuie folosite subconsultari in 
# # -- clauza FROM sau expresii-tabele)
# # 
# # -- explicati de unde provine eroarea!
# # SELECT lastname || ' ' || firstname AS customer_name, city, state, country,
# # 	COALESCE(SUM(i2010.total), 0) AS sales2010, 
# # 	COALESCE(SUM(i2011.total), 0) AS sales2011, 
# # 	COALESCE(SUM(i2012.total), 0) AS sales2012 	
# # FROM customer 
# # 	LEFT JOIN invoice i2010 ON customer.customerid = i2010.customerid AND
# # 		EXTRACT (YEAR FROM i2010.invoicedate) = 2010
# # 	LEFT JOIN invoice i2011 ON customer.customerid = i2011.customerid AND
# # 		EXTRACT (YEAR FROM i2011.invoicedate) = 2011
# # 	LEFT JOIN invoice i2012 ON customer.customerid = i2012.customerid AND
# # 		EXTRACT (YEAR FROM i2012.invoicedate) = 2012
# # GROUP BY lastname || ' ' || firstname, city, state, country 		
# # ORDER BY 1
# # 


###
### tidyverse
### 

# solutie bazata pe jonctiune externa
temp <- 
     customer %>%
          select (customerid:lastname, city:country) %>%
          
          left_join(   # 2010
               invoice %>%
                    filter(lubridate::year(lubridate::ymd(invoicedate)) == 2010) %>%     
                    transmute(customerid, total) %>%
                    group_by(customerid) %>%
                    summarise (sales2010 = sum(total))
               ) %>%
          mutate(sales2010 = coalesce(sales2010, 0)) %>%
     
          left_join(   # 2011
               invoice %>%
                    filter(lubridate::year(lubridate::ymd(invoicedate)) == 2011) %>%     
                    transmute(customerid, total) %>%
                    group_by(customerid) %>%
                    summarise (sales2011 = sum(total))
               ) %>%
          mutate(sales2011 = coalesce(sales2011, 0)) %>%

               left_join(   # 2012
               invoice %>%
                    filter(lubridate::year(lubridate::ymd(invoicedate)) == 2012) %>%     
                    transmute(customerid, total) %>%
                    group_by(customerid) %>%
                    summarise (sales2012 = sum(total))
               ) %>%
          mutate(sales2012 = coalesce(sales2012, 0)) %>%
     transmute(customer_name = paste(lastname, firstname), city, state, country, 
               sales2010, sales2011, sales2012) %>%
     arrange(customer_name, city, state, country)





# -- ############################################################################ 
# -- 						Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################ 
# 
# -- Obtineti un raport in care linii sunt asociate fiecarui artist,
# --   iar coloanele fiecarui gen muzical (prima coloana va fi numele artistului);
# --   calculati numarul de piese ale fiecarui artist pe fiecare gen muzical
# 







