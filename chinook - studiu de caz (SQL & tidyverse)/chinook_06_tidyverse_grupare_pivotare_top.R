################################################################################
###         Interogari `tidyverse` vs SQL - BD Chinook (IE/SPE/CIG)          ###
################################################################################
###              06: Grupare - group by, subtotaluri, having
################################################################################
### ultima actualizare: 2021-11-08

#
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")

#
# # -- ############################################################################
# # --                Extrageti numarul albumelor fiecarui artist
# # -- ############################################################################

# solutie bazata pe `group_by` si `summarise`  (este recomandabil sa "de-grupam"
# inregistrarile dupa `summarise` daca interogarea se continua cu alte operatiuni)
temp <- artist %>%
     inner_join(album) %>%
     group_by(artist_name = name) %>%
     summarise(n_of_albums = n()) %>%
#     ungroup() %>%
     arrange(artist_name)

# ordonare dupa numarul de albume
temp <- artist %>%
     inner_join(album) %>%
     group_by(artist_name = name) %>%
     summarise(n_of_albums = n()) %>%
     arrange(desc(n_of_albums))


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
# # -- 		    Care este artistul cu cel mai mare numar de albume?
# # -- ############################################################################

# solutie cu `head`
temp <- artist %>%
     inner_join(album) %>%
     group_by(artist_name = name) %>%
     summarise( n_of_albums = n()) %>%
     ungroup() %>%
     arrange(desc(n_of_albums)) %>%
     head(1)


# solutie cu `tail`
temp <- artist %>%
     inner_join(album) %>%
     group_by(artist_name = name) %>%
     summarise( n_of_albums = n()) %>%
     ungroup() %>%
     arrange(n_of_albums) %>%
     tail(1)



# solutie cu `top`
temp <- artist %>%
     inner_join(album) %>%
     group_by(artist_name = name) %>%
     summarise( n_of_albums = n()) %>%
     ungroup() %>%
     top_n(1, n_of_albums)




# # -- ############################################################################
# # -- 	  Extrageti durata totala a pieselor (in minute) pentru fiecare artist
# # -- ############################################################################

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


#-- ############################################################################
#-- 	         Extrageti numărul de clienți, pe țări
#-- ############################################################################

# sort by country name
temp <- customer %>%
        group_by(country) %>%
        summarise (n_of_country_customers = n()) %>%
        arrange(country)


# sort by numver of customers
temp <- customer %>%
        group_by(country) %>%
        summarise (n_of_country_customers = n()) %>%
        arrange(desc(n_of_country_customers))



# # -- ############################################################################
# # --       Extrageti durata totala a pieselor (in minute) pentru fiecare
# # --            album al fiecarui artist, cu afisare de tipul HH:MI:SS
# # --                    (durata in minute si secunde)
# # -- ############################################################################

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


# afisam codurile UTF pentru a selecta un simbol pentru subtotaluri
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
          transmute (artist_name, title, track_name = 'Σ SUBTOTAL ON ALBUM }',
                     milliseconds) %>%
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

     # grand total
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

# solutie corecta, dar incompleta
temp <- bind_rows(

     # 2010
     customer %>%
          inner_join(invoice %>%
                          mutate(year = lubridate::year(invoicedate)) %>%
                          filter( year == 2010)
                     ) %>%
     group_by(customer_name = paste(lastname, firstname), city,
              state, country, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup(),

     # 2011
     customer %>%
          inner_join(invoice %>%
                         mutate(year = lubridate::year(invoicedate)) %>%
                         filter( year == 2011)
                     ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state,
              country, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup(),

     # 2012
     customer %>%
          inner_join(invoice %>%
                          mutate(year = lubridate::year(invoicedate)) %>%
                         filter( year == 2012)
                     ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state,
              country, year) %>%
     summarise(sales = sum(total)) %>%
     ungroup()

     ) %>%
     arrange(customer_name, city, state, country, year)


# solutie corecta & completa
temp <- bind_rows(
          invoice %>%
               transmute(customerid, invoicedate = lubridate::ymd(invoicedate), total),
          # here we inject an empty invoice for each customer for year 2010
          customer %>%
               transmute(customerid, invoicedate = lubridate::ymd('2010-01-01'), total = 0),
          # here we inject an empty invoice for each customer for year 2011
          customer %>%
               transmute(customerid, invoicedate = lubridate::ymd('2011-01-01'), total = 0),
          # here we inject an empty invoice for each customer for year 2012
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


# solutie 2 veche - bazate pe `tidyr::spread`
# temp <- invoice %>%
#           transmute(customerid, invoicedate = lubridate::ymd(invoicedate), total) %>%
#      inner_join(customer) %>%
#      mutate(year = lubridate::year(invoicedate)) %>%
#      filter( year %in% c(2010, 2011, 2012) ) %>%
#      group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
#      summarise(total = sum(total)) %>%
#      ungroup() %>%
#      mutate(year = paste0('sales', year)) %>%   # vrem sa in antet sa apara `salesxxxx`
#      tidyr::spread(year, total, fill = 0)


# solutie 2 (mai) noua - bazate pe `tidyr::pivot_wider`

temp <- invoice %>%
          transmute(customerid, invoicedate = lubridate::ymd(invoicedate), total) %>%
     inner_join(customer) %>%
     mutate(year = lubridate::year(invoicedate)) %>%
     filter( year %in% c(2010, 2011, 2012) ) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
     summarise(total = sum(total)) %>%
     ungroup() %>%
     mutate(year = paste0('sales', year)) %>%   # vrem ca in antet sa apara `salesxxxx`
     tidyr::pivot_wider(names_from = year, values_from = total, values_fill = 0)


#
# # -- ############################################################################
# # --                 Afisati, pentru fiecare client, pe coloane separate,
# # --                       vanzarile pentru toti anii!
# # -- ############################################################################
# #

# solutia urmatoare functioneaza identic, indiferent de numarul anilor din BD
temp <- invoice %>%
          transmute(customerid, invoicedate = lubridate::ymd(invoicedate), total) %>%
     inner_join(customer) %>%
     mutate(year = lubridate::year(invoicedate)) %>%
     group_by(customer_name = paste(lastname, firstname), city, state, country, year) %>%
     summarise(total = sum(total)) %>%
     ungroup() %>%
     mutate(year = paste0('sales', year)) %>%   # vrem sa in antet sa apara `salesxxxx`
     arrange (customer_name, year) %>%
     pivot_wider(names_from = year, values_from = total, values_fill = 0)




# # -- ############################################################################
# # --             Extrageti artistii cu o durata totala a pieselor
# # --                         mai mare de 100 de minute
# # -- ############################################################################
# #

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



#-- ############################################################################
#-- 	        Solutii tidyverse care nu au echivalent "direct" in SQL
#                        (in SQL necesita functiii OLAP)
#-- ############################################################################

################################################################################
#       Extrageti primele trei piese ale fiecarui album al formatiei U2
################################################################################

# solutie cu `top_n`
temp <- artist %>%
        filter (name == 'U2') %>%
        inner_join(album) %>%
        transmute (artist_name = name, album_title = title, albumid) %>%
        inner_join(track) %>%
        arrange(artist_name, album_title, albumid, trackid) %>%
        group_by(artist_name, album_title, albumid) %>%
        top_n(-3, trackid) %>%
        ungroup()


# solutie cu `slice`
temp <- artist %>%
        filter (name == 'U2') %>%
        inner_join(album) %>%
        transmute (artist_name = name, album_title = title, albumid) %>%
        inner_join(track) %>%
        arrange(artist_name, album_title, albumid, trackid) %>%
        group_by(artist_name, album_title, albumid) %>%
        slice(1:3)

#
#
# -- ############################################################################
# --                Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################
#
# -- Afisati numarul de piese din fiecare tracklist
#
# -- Care este cel mai vandut gen muzical?
#
# -- Care este angajatul cu cei mai multi subordonati directi ? (de ordinul 1)
#
#

# Care sunt clientii cu un total al achizitiilor pe anul 2010 mai mare de 10 USD?
#
temp <- customer %>%
        inner_join(invoice) %>%
        filter (year(invoicedate) == 2010) %>%
        group_by(customer = paste(lastname,
                firstname, paste0('(', city, ')'))) %>%
        summarise (cust_purchase = sum(total)) %>%
        filter(cust_purchase > 10) %>%
        arrange(customer)


############################################################################
## 	   La ce intrebari raspund urmatoarele interogari ?
############################################################################

##
invoice %>%
        mutate (year = lubridate::year(invoicedate)) %>%
        distinct(year) %>%
        count()

##
invoice %>%
        mutate (year = lubridate::year(invoicedate)) %>%
        group_by(year) %>%
        summarise(n = n())


##
invoice %>%
        mutate (year = lubridate::year(invoicedate)) %>%
        group_by(year) %>%
        summarise(n = n_distinct(customerid))
