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
## 			tidyverse03: Operatori ansamblisti (UNION, INTERSECT, EXCEPT)
## 			tidyverse03: Ansemble operators: (UNION, INTERSECT, EXCEPT)
##############################################################################
## ultima actualizare / last update: 2022-03-14


library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")


###############################################################################
###                                      UNION
###############################################################################


##############################################################################
##			Care sunt piesele care apar pe două discuri ale formației
##				'Iron Maiden', `Fear Of The Dark` și `A Real Live One`
##############################################################################
##			Extract the tracks included on two of the albums releases by
##				'Iron Maiden' - `Fear Of The Dark` and `A Real Live One`
##############################################################################

# solutia urmatoare nu elimina dublurile
temp <- artist %>%
     filter (name == 'Iron Maiden') %>%
     select (-name) %>%
     inner_join(album) %>%
     filter (title == 'Fear Of The Dark' | title == 'A Real Live One') %>%
     inner_join(track) %>%
     select (name) %>%
     arrange(name)

# solutia urmatoare elimina dublurile
temp <- artist %>%
     filter (name == 'Iron Maiden') %>%
     select (-name) %>%
     inner_join(album) %>%
     filter (title == 'Fear Of The Dark' | title == 'A Real Live One') %>%
     inner_join(track) %>%
     distinct (name) %>%
     arrange(name)


# sol. 1 cu `union`
temp <- dplyr::union(
     artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'Fear Of The Dark') %>%
          inner_join(track) %>%
          distinct (name),
     artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'A Real Live One') %>%
          inner_join(track) %>%
          distinct (name)) %>%
     arrange(name)


# sol. 2 cu `union`
temp <- artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'Fear Of The Dark') %>%
          inner_join(track) %>%
          distinct (name) %>%
     dplyr::union(
          artist %>%
               filter (name == 'Iron Maiden') %>%
               select (-name) %>%
               inner_join(album) %>%
               filter (title == 'A Real Live One') %>%
               inner_join(track) %>%
               distinct (name)
          ) %>%
     arrange(name)


##############################################################################
## Care sunt subordonatii de ordinul 1 (directi) si 2 (subordonatii directi ai
## subordonatilor de ordinul 1) ai lui `Adams` (lastname) `Andrew` (firstname)
##############################################################################
##Extract first-order and second-order subordinates of
##   `Adams` (lastname) `Andrew` (firstname)
##############################################################################

# solutie bazata pe `union`
temp <-
        # subordonatii de ordinul I
        employee %>%
                filter (lastname == 'Adams' & firstname == 'Andrew') %>%
                transmute (boss_employeeid = employeeid) %>%
                inner_join(employee, by = c('boss_employeeid' = 'reportsto')) %>%
                select (-boss_employeeid) %>%
        dplyr::union( # subordonatii de ordinul II
                employee %>%
                        filter (lastname == 'Adams' & firstname == 'Andrew') %>%
                        transmute (boss_employeeid = employeeid) %>%
                        inner_join(employee, by = c('boss_employeeid' = 'reportsto')) %>%
                        transmute (first_order_subordinates_id = employeeid) %>%
                        inner_join(employee, by = c('first_order_subordinates_id' = 'reportsto')) %>%
                        select (-first_order_subordinates_id)
        )



# solutie bazata pe `bind_rows`
temp <- bind_rows(
        # subordonatii de ordinul I
        employee %>%
                filter (lastname == 'Adams' & firstname == 'Andrew') %>%
                transmute (boss_employeeid = employeeid) %>%
                inner_join(employee, by = c('boss_employeeid' = 'reportsto')) %>%
                select (-boss_employeeid),
        # subordonarii de ordinul II
        employee %>%
                filter (lastname == 'Adams' & firstname == 'Andrew') %>%
                transmute (boss_employeeid = employeeid) %>%
                inner_join(employee, by = c('boss_employeeid' = 'reportsto')) %>% #subordonatii directi
                transmute (first_order_subordinates_id = employeeid) %>%
                inner_join(employee, by = c('first_order_subordinates_id' = 'reportsto')) %>%
                select (-first_order_subordinates_id)
        )





##############################################################################
##                                INTERSECT
##############################################################################

##############################################################################
##			Care sunt piesele comune (cu acelasi titlu) de pe
##			albumele `Fear Of The Dark` si `A Real Live One`
##					ale formatiei 'Iron Maiden'
##############################################################################
##			Extract the tracks (track name) included on both `Fear Of The Dark` and
## `A Real Live One` albums released by 'Iron Maiden' (the common tracks of
##     both albums)
##############################################################################

# solutie eronata 1 !!! (AND)
temp <- artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'Fear Of The Dark' & title == 'A Real Live One') %>%
          inner_join(track) %>%
          select (name)

# solutie eronata 2 !!! (OR)
temp <- artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'Fear Of The Dark' | title == 'A Real Live One') %>%
          inner_join(track) %>%
          select (name)


# solutie corecta bazata pe `intersect`
temp <- dplyr::intersect(
     artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'Fear Of The Dark') %>%
          inner_join(track) %>%
          select (name),
     artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'A Real Live One') %>%
          inner_join(track) %>%
          select (name)
     )


# solutie corecta bazata pe `intersect`
#
# de vazut ce e in neregula !!!
temp <- artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'Fear Of The Dark') %>%
          inner_join(track) %>%
          select (name) %>%
        dplyr::intersect(
             artist %>%
                filter (name == 'Iron Maiden') %>%
                select (-name) %>%
                inner_join(album) %>%
                filter (title == 'A Real Live One') %>%
                inner_join(track) %>%
                select (name)
                        )


# ##solutie bazata de auto-join
temp <- artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'Fear Of The Dark') %>%
          inner_join(track) %>%
          select (name) %>%
     inner_join(
          artist %>%
               filter (name == 'Iron Maiden') %>%
               select (-name) %>%
               inner_join(album) %>%
               filter (title == 'A Real Live One') %>%
               inner_join(track) %>%
               select (name)
               )



# solutie noua (fara echivalent in SQL-PostgreSQL): SEMI JOIN
temp <- track %>%
     semi_join(
          album %>%
               filter (title == 'Fear Of The Dark') %>%
               semi_join(
                    artist %>%
                         filter (name == 'Iron Maiden')
                         )) %>%
     select (name) %>%
     semi_join(
          track %>%
               semi_join(
                    album %>%
                         filter (title == 'A Real Live One') %>%
                    semi_join(
                         artist %>%
                              filter (name == 'Iron Maiden')
                              ))
     )



##############################################################################
##                                 EXCEPT
##############################################################################

##############################################################################
## Care sunt piesele formatiei 'Iron Maiden' de pe albumul `Fear Of The Dark`
##				care NU apar si pe albumul `A Real Live One`
##############################################################################
## Extract the tracks released by 'Iron Maiden' which were inluded on the
##  album `Fear Of The Dark` but not included on the album `A Real Live One`
##############################################################################


# solutie bazata pe `setdiff` (exchivalentul EXCEPT)
temp <- dplyr::setdiff(
     artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'Fear Of The Dark') %>%
          inner_join(track) %>%
          select (name),
     artist %>%
          filter (name == 'Iron Maiden') %>%
          select (-name) %>%
          inner_join(album) %>%
          filter (title == 'A Real Live One') %>%
          inner_join(track) %>%
          select (name)
     )


# solutie noua (fara echivalent in SQL-PostgreSQL): ANTI JOIN
temp <- track %>%
     semi_join(
          album %>%
               filter (title == 'Fear Of The Dark') %>%
               semi_join(
                    artist %>%
                         filter (name == 'Iron Maiden')
                         )) %>%
     select (name) %>%
     anti_join(
          track %>%
               semi_join(
                    album %>%
                         filter (title == 'A Real Live One') %>%
                    semi_join(
                         artist %>%
                              filter (name == 'Iron Maiden')
                              ))
     )



##############################################################################
##  Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori,
##          nu apare nici `Robert Plant`, nici `Jimmy Page`
##############################################################################
##  Extract the tracks released by `Led Zeppelin` whose composers are neither
##          `Robert Plant` nor `Jimmy Page`
##############################################################################

temp <- artist %>%
        filter (name == 'Led Zeppelin') %>%
        transmute(artistid, artist_name = name) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        anti_join(
                artist %>%
                filter (name == 'Led Zeppelin') %>%
                transmute(artistid, artist_name = name) %>%
                inner_join(album) %>%
                inner_join(track) %>%
                filter (str_detect(composer, 'Plant'))) %>%
        anti_join(
                artist %>%
                filter (name == 'Led Zeppelin') %>%
                transmute(artistid, artist_name = name) %>%
                inner_join(album) %>%
                inner_join(track) %>%
                filter (str_detect(composer, 'Page')))





##############################################################################
##               Probleme de rezolvat la curs/laborator/acasa
##############################################################################
##               To be completed during lectures/labs or at home
##############################################################################
#
#
# Afisare piesele (si artistii) comune playlisturilor `Heavy Metal Classic` si `Music`
#
# Care sunt piesele formatiei `Led Zeppelin` compuse numai de `Robert Plant`
#
# Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
#  `Jimmy Page`, cu sau fara alti colegi/muzicieni?
#
# Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
#  `Jimmy Page`, fara alti colegi/muzicieni?
#
# Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
# 	`Robert Plant`
#

##############################################################################
##             La ce întrebări răspund următoarele interogări ?
##############################################################################
##          For what requiremens the following queries provide the result?
##############################################################################
