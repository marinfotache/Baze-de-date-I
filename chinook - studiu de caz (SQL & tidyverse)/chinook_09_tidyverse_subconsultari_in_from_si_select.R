################################################################################
###             Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
################################################################################
### 09: Subconsultari SQL in clauzele FROM si SELECT. Diviziune relationala (2)
###                     Echivalente in `tidyverse`
################################################################################
### ultima actualizare: 2020-04-25

library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")



############################################################################
###     Echivalente `tidyverse` ale subconsultarilor SQL in clauza FROM
############################################################################


############################################################################
##      Care sunt celelalte albume ale artistului sau formatiei care a
##             lansat albumul `Houses of the Holy` (reluare)
############################################################################

# solutie preluata din scriptul anterior (care emuleaza logica interogarii SQL de mai sus)
temp <- album %>%
     filter (title == 'Houses Of The Holy') %>%
     select (artistid) %>%
     inner_join(album) %>%
     inner_join(artist)



############################################################################
##             Care sunt piesele comune (cu acelasi titlu) de pe
## 	           albumele `Fear Of The Dark` si `A Real Live One`
## 		       ale formatiei 'Iron Maiden' (reluare)
############################################################################

# o solutie relativ apropiata logicii SQL din scriptul `chinook_09_sql...`
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
     

############################################################################
## 	    Care sunt facturile din prima zi de vanzari? (reluare)
############################################################################

# toate solutile din scriptul anterior (`chinook_08_tidyverse...`) care nu 
# folosesc `pull()` se apropie de logica SQL din scriptul `chinook_09_sql...`

# ...incercam si o solutie noua
temp <- min(invoice$invoicedate) %>%
     enframe() %>%
     transmute (invoicedate = value) %>%
     inner_join(invoice)



############################################################################
# # -- 	   Care sunt facturile din prima saptamana de vanzari? (reluare)
############################################################################


# ... solutie noua:
temp <- seq(
          min(trunc(invoice$invoicedate)),
          (min(trunc(invoice$invoicedate)) + 
                 lubridate::period(days = 7)),
          by = 'day') %>%
     enframe() %>%
     transmute (invoicedate = value) %>%
     inner_join(invoice)





############################################################################
##     Care sunt albumele formatiei Led Zeppelin care au mai multe piese
##                      decat albumul `IV` (reluare) 
############################################################################

# intrucat theta-jonctiunea nu e posibila in tidyverse, ramanem la cele 
# doua solutii din scriptul precedent (cea de mai jos este a doua)
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



############################################################################
##             Afisati, pentru fiecare client, pe coloane separate, 
##                 vanzarile pe anii 2010, 2011 si 2012 (reluare)
############################################################################

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



############################################################################
##         Afisati ponderea fiecarei luni in vanzarile anului 2010
############################################################################

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
     
     


############################################################################
###                       Diviziune relationala (2)
############################################################################

############################################################################
##  Care sunt artistii `vanduti` in toate orasele din 'United Kingdom' din
##                care provin clientii (reluare)
############################################################################

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

     

############################################################################
##    Care sunt artistii `vanduti` in toti anii (adica, in fiecare an) din 
##                         intervalul 2009-2012
############################################################################

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



############################################################################
##     Care sunt artistii pentru care au fost vanzari macar (cel putin) 
##       in toti anii in care s-au vandut piese ale formatiei `Queen`
############################################################################

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
     
     
     
     
############################################################################
###   Echivalente `tidyverse` ale subconsultarilor SQL in clauza SELECT
############################################################################

####
#### Logica  `tidyverse` nu se pliaza pe problematica subconsultarilor din SQL;
####      in schimb, toate problemele care in SQL se folosesc subconsultari, 
####      cu sau fara corelare, au solutii in `tidyverse`
####       


