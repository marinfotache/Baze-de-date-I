##############################################################################
## Universitatea Al.I.Cuza Iași / Al.I.Cuza University of Iasi (Romania)
## Facultatea de Economie si Administrarea Afacerilor / Faculty of
##          Economics and Business Administration
## Colectivul de Informatică Economică / Dept. of Business Information Systems
##############################################################################

##############################################################################
##        Studiu de caz: Interogări tidyverse pentru baza de date `chinook`
##        Case study: tidyverse queries for `chinook` database
##############################################################################
## 	      tidyverse09:  Echivalențe `tidyverse` ale subconsultărilor SQL
##         incluse în clauzele FROM si SELECT. Diviziune relationala (2)
##############################################################################
## 	     tidyverse09: `tidyverse` equivalent solutions for SQL subqueries
##            included in FROM and SELECTT. Relational division (2)
##############################################################################
## ultima actualizare / last update: 2022-03-15


library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")



############################################################################
###     Echivalențe `tidyverse` ale subconsultarilor SQL în clauza FROM
############################################################################
###   `tidyverse` equivalents of SQL subqueries included in FROM clause
############################################################################


##############################################################################
##       Care sunt celelalte albume ale artistului sau formației care a
##                  lansat albumul `Houses of the Holy` (reluare)
##############################################################################
##       List the other albums of the artist/band that released
##                    the album `Houses of the Holy`  (reprise)
##############################################################################

# solutie preluata din scriptul anterior (care emuleaza logica interogarii SQL de mai sus)
temp <- album %>%
     filter (title == 'Houses Of The Holy') %>%
     select (artistid) %>%
     inner_join(album) %>%
     inner_join(artist)



##############################################################################
##			Care sunt piesele comune (cu acelasi titlu) de pe
##			albumele `Fear Of The Dark` si `A Real Live One`
##					ale formatiei 'Iron Maiden' (reluare)
##############################################################################
##			Extract the tracks (track name) included on both `Fear Of The Dark` and
## `A Real Live One` albums released by 'Iron Maiden' (the common tracks of
##     both albums) (reprise)
##############################################################################

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


##############################################################################
##            Care sunt facturile din prima zi de vânzări? (reluare)
##############################################################################
##         Extract invoices issued in the first day with sales (reprise)
##############################################################################


# toate solutile din scriptul anterior (`chinook_08_tidyverse...`) care nu
# folosesc `pull()` se apropie de logica SQL din scriptul `chinook_09_sql...`

# ...incercam si o solutie noua
temp <- min(invoice$invoicedate) %>%
     enframe() %>%
     transmute (invoicedate = value) %>%
     inner_join(invoice)



##############################################################################
##       Care sunt facturile din prima săptămână de vânzări? (reluare)
##############################################################################
##    List invoices issued in the first week since the sales begun (reprise)
##############################################################################


# ... solutie noua:
temp <- seq(
          min(trunc(invoice$invoicedate)),
          (min(trunc(invoice$invoicedate)) +
                 lubridate::period(days = 7)),
          by = 'day') %>%
     enframe() %>%
     transmute (invoicedate = value) %>%
     inner_join(invoice)




##############################################################################
##     Care sunt albumele formației Led Zeppelin care au mai multe piese
##                           decât albumul `IV`? (reluare)
##############################################################################
##     List the albums released by Led Zeppelin with more tracks than
##                           the album `IV` (reprise)
##############################################################################

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



##############################################################################
##              Afișați, pentru fiecare client, pe coloane separate,
##                    vânzările pe anii 2010, 2011 și 2012 (3)
##############################################################################
##            Display, for each customer, on three different columns,
##                    the total sales on 2010, 2011 și 2012  (3)
##############################################################################

# solutia cea mai eleganta se bazeaza pe `pivot_wider`
temp <- invoice %>%
     transmute (customerid, total, year = lubridate::year(invoicedate)) %>%
     filter (year %in% c(2010, 2011, 2012)) %>%
     group_by(customerid, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup() %>%
     inner_join(customer %>%
                     transmute (customerid, customer_name = paste(lastname, firstname),
                                state, country)) %>%
     pivot_wider(names_from = year, values_from = sales, values_fill = 0) %>%
     arrange(customer_name)



##############################################################################
##  Calculați ponderea fiecărei luni calendaristice în vânzările anului 2010
##############################################################################
##        Find the share (percentage) of each month for the 2010 sales
##############################################################################

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




##############################################################################
##                      Diviziune relațională (2)
##############################################################################
##                        Relational division (2)
##############################################################################


##############################################################################
##   Care sunt artiștii cu vânzări în toate orașele din 'United Kingdom' din
##                         care provin clienții (reluare)
##############################################################################
##   Find the artist with sales in all the 'United Kingdom' cities where is
##                         at least one customer (reprise)
##############################################################################

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



##############################################################################
##	 Care sunt artiștii cu vânzări în toți anii (adică, în fiecare an) din
##                       intervalul 2009-2012
##############################################################################
##	 Find the artists with sales all ALL years in 2009-2012 range
##############################################################################

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



##############################################################################
##	 Care sunt artiștii pentru care au fost vânzări măcar (cel puțin)
##         în toți anii în care s-au vândut piese ale formației `Queen`
##############################################################################
##	 Find the artists with sales in at least all the sales years of `Queen`
##############################################################################

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



##############################################################################
##      Echivalente `tidyverse` ale subconsultarilor SQL in clauza SELECT
##############################################################################
##     `tidyverse` equivalents of SQL Subqueries included in SELECT clause
##############################################################################

####
#### Logica  `tidyverse` nu se pliaza "direct" pe problematica subconsultarilor din SQL;
####      in schimb, toate problemele care in SQL se folosesc subconsultari,
####      cu sau fara corelare, au solutii in `tidyverse`
####





##############################################################################
##               Probleme de rezolvat la curs/laborator/acasa
##############################################################################
##               To be completed during lectures/labs or at home
##############################################################################



##############################################################################
##             Care este albumul (sau albumele) formației Queen
##                      cu cele mai multe piese? (reluare)
##############################################################################
##               List the album (or albums) released by `Queen`
##                 having the largest number of tracks (reprise)
##############################################################################


##############################################################################
##	 Care sunt artiștii cu vânzări în toate țările din urmatorul set:
## ('USA', 'France', 'United Kingdom', 'Spain') (reluare)
##############################################################################
##	 Find the artists with sales in ALL of the countries from the following set:
## ('USA', 'France', 'United Kingdom', 'Spain') (reprise)
##############################################################################



##############################################################################
##             La ce întrebări răspund următoarele interogări ?
##############################################################################
##          For what requiremens the following queries provide the result?
##############################################################################
