##############################################################################
## Universitatea Al.I.Cuza Iași / Al.I.Cuza University of Iasi (Romania)
## Facultatea de Economie si Administrarea Afacerilor / Faculty of
##          Economics and Business Administration
## Colectivul de Informatică Economică / Dept. of Business Information Systems
##############################################################################

##############################################################################
##        Studiu de caz: Interogări SQL pentru baza de date `chinook`
##        Case study: SQL Queries for `chinook` database
##############################################################################
## 	  tidyverse05: Funcții agregat (count, count distinct, ...) fără grupare
## 		tidyverse05: Aggregate functions without gruping
##############################################################################
## ultima actualizare / last update: 2022-03-14

library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")


##############################################################################
##                   Câți artiști sunt în baza de date?
##############################################################################
##               How many artists are stored in the database?
##############################################################################

# Solutie eronata!!! (aceasta solutie numara de cate ori apare fiecare valoare
# a `artistid` in data frame-ul `artist`)
temp <- artist %>%
     count(artistid)


# Solutie 1 - `count()`
temp <- artist %>%
     count()


# Solutie 2 - `summarise`, `n()`
temp <- artist %>%
     summarise(n_of_artists = n())


# Solutie 3 - `tally()`
temp <- artist %>%
     tally()



##############################################################################
##				                     Câți clienți au fax?
##############################################################################
##				                  How many customers have fax?
##############################################################################

# sol 1
temp <- customer %>%
        filter(!is.na(fax)) %>%
        tally()

# sol 2
temp <- customer %>%
        filter(!is.na(fax)) %>%
        summarise(n_of_customers_with_faxes = n())




##############################################################################
##				Pentru câți artiști există măcar un album în baza de date?
##############################################################################
##				         How many artist released at least an album?
##############################################################################


# solutie bazata pe `n_distinct`
temp <- album %>%
     summarise (n = n_distinct(artistid))


# solutie bazata pe `semi-join` si `count`
temp <- artist %>%
     semi_join(album) %>%
     count()


# solutie bazata pe `semi-join` si `summarise`+`n()`
temp <- artist %>%
     semi_join(album) %>%
     summarise (n = n())



##############################################################################
##               Din câte țări sunt clienții companiei?
##############################################################################
##               In how many contries originate the customers?
##############################################################################

# solutie bazata pe `n_distinct`
temp <- customer %>%
     summarise (n = n_distinct(country))




############################################################################
##               Din cate orașe sunt clienții companiei?
############################################################################
##             In how many cities originate the customers?
############################################################################

# solutie bazata pe `n_distinct`
temp <- customer %>%
     summarise (n = n_distinct(paste(city, state,
                                     country, sep = ' - ')))



##############################################################################
##       Câte secunde are albumul `Achtung Baby` al formației `U2`?
##############################################################################
##    Compute the total duration (in seconds) of the album `Achtung Baby`
## released by `U2`
##############################################################################

# solutie bazata pe `summarise` si `sum`
temp <- album %>%
     filter (title == 'Achtung Baby') %>%
     semi_join(artist %>%
                    filter (name == 'U2')) %>%
     inner_join(track) %>%
     summarise(durata = sum(milliseconds / 1000))



##############################################################################
##              Care este durata medie (în secunde) a pieselor
##              de pe albumul `Achtung Baby` al formației `U2`
##############################################################################
##   Compute the average duration (in seconds) of the tracks included
##              on the album `Achtung Baby` released by `U2`
##############################################################################

# solutie bazata pe `summarise` si `mean`
temp <- album %>%
     filter (title == 'Achtung Baby') %>%
     semi_join(artist %>%
                    filter (name == 'U2')) %>%
     inner_join(track) %>%
     summarise(durata_medie = mean(milliseconds / 1000))



##############################################################################
##          Care este durata medie a pieselor formației `U2`
##############################################################################
##   Compute the average duration (in seconds) of the tracks
##              released by `U2`
##############################################################################

# solutie bazata pe `summarise` si `mean`
temp <- album %>%
     semi_join(artist %>%
                    filter (name == 'U2')) %>%
     inner_join(track) %>%
     summarise(durata_medie = mean(milliseconds / 1000))



##############################################################################
##			Care este durata medie a pieselor formației `Pink Floyd`,
##                    exprimată în minute și secunde
##############################################################################
##   Compute the average duration (in minutes and seconds) of the tracks
##              released by `Pink Floyd`
##############################################################################

# solutie bazata pe `summarise`, `mean` si `lubridate::seconds_to_period`
temp <- album %>%
     semi_join(artist %>%
                    filter (name == 'Pink Floyd')) %>%
     inner_join(track) %>%
     summarise(durata_medie =
          trunc(lubridate::seconds_to_period(mean(milliseconds / 1000))))



##############################################################################
##                     În ce zi a fost prima vânzare?
##############################################################################
##                     Find the date of the first sale.
##############################################################################

# solutie cu functia `min`
temp <- invoice %>%
    summarise(first_day = min(invoicedate))


# solutie cu optiunea `head`
temp <- invoice %>%
    arrange (invoicedate) %>%
    head(1)  %>%
    transmute (first_day = invoicedate)

# solutie cu optiunea `tail`
temp <- invoice %>%
    arrange (desc(invoicedate)) %>%
    tail(1)  %>%
    transmute (first_day = invoicedate)


# solutie cu optiunea `top` (atentie la `-1`!!!)
temp <- invoice %>%
    distinct(invoicedate) %>%
    top_n (-1, invoicedate) %>%
    transmute (first_day = invoicedate)


# solutie cu `slice`
temp <- invoice %>%
    distinct(invoicedate) %>%
    arrange(invoicedate)  %>%
    slice(1)


# alta solutie cu `slice`
temp <- invoice %>%
    distinct(invoicedate) %>%
    arrange(desc(invoicedate))  %>%
     slice(nrow(.))


# solutie cu filtrare ce foloseste `rownum()`
temp <- invoice %>%
    distinct(invoicedate) %>%
    arrange(invoicedate)  %>%
    filter (row_number() <= 1)



##############################################################################
##                      În ce dată a fost ultima vanzare?
##############################################################################
##                         Find the last sales date
##############################################################################

temp <- invoice %>%
     summarise(last_day = max(invoicedate))


# solutie cu optiunea `head`
temp <- invoice %>%
    arrange (desc(invoicedate)) %>%
    head(1)  %>%
    transmute (last_day = invoicedate)


# solutie cu optiunea `tail`
temp <- invoice %>%
    arrange (invoicedate) %>%
    tail(1)  %>%
    transmute (last_day = invoicedate)


# solutie cu optiunea `top_n`
temp <- invoice %>%
    distinct(invoicedate) %>%
    top_n (1, invoicedate) %>%
    transmute (first_day = invoicedate)




##############################################################################
##               Probleme de rezolvat la curs/laborator/acasa
##############################################################################
##               To be completed during lectures/labs or at home
##############################################################################

#
##############################################################################
##                Cate piese sunt stocate în baza de date?
##############################################################################
##                How many tracks are stored in the database?
##############################################################################

# ##Care este data primei angajari in companie
#
# ##Cate piese sunt pe playlistul `Grunge`?
#
# ##Cati subordonati are, in total (pe toate nivelurile) angajatul xxxxxx?
#



##############################################################################
##             La ce întrebări răspund următoarele interogări ?
##############################################################################
##          For what requiremens the following queries provide the result?
##############################################################################


##
invoice %>%
        summarise(first_day = min(invoicedate), last_day = max(invoicedate)) %>%
        mutate (range = last_day - first_day) %>%
        transmute(range)

##
temp <- track %>%
        filter (milliseconds / 1000 > mean(milliseconds/1000))


mean(track$milliseconds/1000)
