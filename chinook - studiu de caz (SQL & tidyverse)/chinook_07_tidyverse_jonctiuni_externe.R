#
# # -- 		Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
# # --
# # -- 07: Jonctiuni externe
# # --
# # -- ultima actualizare: 2020-04-08
# #
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2020/Studii de caz/chinook')
load("chinook.RData")



# # -- ############################################################################
# # -- 		Care sunt artistii care, momentan, nu au niciun album preluat in BD?
# # -- ############################################################################

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
     filter (is.na(albumid)) %>%
     arrange(name)




# # -- ############################################################################
# # -- Extrageti numarul albumelor fiecarui artist; pentru artistii (actualmente)
# # -- 			  fara albume, sa se afiseze `0`
# # -- ############################################################################

# solutie bazata pe `left_join` si `count` - solutie eronata (
# cei care nu au nicun album apar cu 1 (datorita `count`-ului))
temp <- artist %>%
     left_join(album) %>%
     count(name) %>%
     arrange(name)


# solutie corecta
temp <- artist %>%
        left_join(album) %>%
        group_by(name) %>%
        summarise(n = sum(if_else(is.na(title), 0, 1)))



# #
# # -- ############################################################################
# # -- 	   Care sunt artistii care, momentan, nu au niciun album preluat in BD?
# # -- ############################################################################

# solutia bazata pe `left_join` si `count` NU FUNCTIONEAZA!!!
temp <- artist %>%
     left_join(album) %>%
     count(name, na.rm = TRUE) %>%
     filter ( n == 0) %>%
     arrange(name)


# ...nici solutia bazata pe `left_join`, `group_by` si `tally` NU FUNCTIONEAZA!!!
temp <- artist %>%
     left_join(album) %>%
     group_by(name) %>%
     tally() %>%
     ungroup() %>%
     filter ( n == 0) %>%
     arrange(name)


# ...nici solutia bazata pe `left_join`, `group_by` si `tally` NU FUNCTIONEAZA!!!...
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
     transmute(customer_name = paste(lastname, firstname), city, state, 
               country, year, sales) %>%
     arrange(customer_name, city, state, country, year)






# # -- ############################################################################
# # -- 			Afisati, pentru fiecare client, pe coloane separate,
# # -- 					vanzarile pe anii 2010, 2011 si 2012
# # -- ############################################################################


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
# -- 			Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################
#
# -- Obtineti un raport in care linii sunt asociate fiecarui artist,
# --   iar coloanele fiecarui gen muzical (prima coloana va fi numele artistului);
# --   calculati numarul de piese ale fiecarui artist pe fiecare gen muzical
#
