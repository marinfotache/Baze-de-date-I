################################################################################
###         Interogari `tidyverse` vs SQL - BD Chinook (IE/SPE/CIG)          ###
################################################################################
###             03: Operatori ansamblisti (UNION, INTERSECT, EXCEPT)
################################################################################
### ultima actualizare: 2021-03-10

library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")

#
# #
# #
# # -- ############################################################################
# # -- 					UNION
# # -- ############################################################################
# #
# # -- ############################################################################
# # -- 		Care sunt piesele care apar pe doua discuri ale formatiei
# # -- 		    'Iron Maiden', `Fear Of The Dark` si `A Real Live One`
# # -- ############################################################################

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


# # -- ############################################################################
# -- Care sunt subordonatii de ordinul 1 (directi) si 2 (subordonatii direct ai 
# -- subordonatilor de ordinul 1)
# -- ai lui `Adams` (lastname) `Andrew` (firstname)
#

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






# # -- ############################################################################
# # --                                  INTERSECT
# # -- ############################################################################
# #

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


# -- solutie bazata de auto-join
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



# # -- ############################################################################
# # -- 				    EXCEPT
# # -- ############################################################################
# #
# # -- ############################################################################
# # -- Care sunt piesele formatiei 'Iron Maiden' de pe albumul `Fear Of The Dark`
# # -- 				care NU apar si pe albumul `A Real Live One`
# # -- ############################################################################


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



# -- ############################################################################
# -- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori,
# -- nu apare, nici `Robert Plant`, nici `Jimmy Page`
# -- ############################################################################
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




#
# -- ############################################################################
# --                Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################
#
#
# -- Afisare piesele (si artistii) comune playlisturilor `Heavy Metal Classic` si `Music`
#
# -- Care sunt piesele formatiei `Led Zeppelin` compuse numai de `Robert Plant`
#
# -- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
# --  `Jimmy Page`, cu sau fara alti colegi/muzicieni?
#
# -- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
# --  `Jimmy Page`, fara alti colegi/muzicieni?
#
# -- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
# --	`Robert Plant`
#
