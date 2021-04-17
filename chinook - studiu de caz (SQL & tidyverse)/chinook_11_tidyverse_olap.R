################################################################################
###         Interogari `tidyverse` vs SQL - BD Chinook (IE/SPE/CIG)          ###
################################################################################
###                             11: Optiuni OLAP
################################################################################
### ultima actualizare: 2020-04-25
#

library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")

############################################################################
##         Stiind ca `trackid` respecta ordinea pieselor de pe albume,
##        sa se numeroteze toate piesele de pe toate albumele formatiei
##      `Led Zeppelin`; albumele vor fi ordonate alfabetic
############################################################################

# solutie cu row_number()
temp <- artist %>%
     filter (name == 'Led Zeppelin') %>%
     select (artistid) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     arrange(title, trackid) %>%
     group_by(title) %>%
     mutate (track_no = row_number()) %>%
     ungroup() %>%
     transmute (album_title = title, track_no, track_name = name) %>%
     arrange(album_title, track_no)


# solutie cu min_rank()
temp <- artist %>%
     filter (name == 'Led Zeppelin') %>%
     select (artistid) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     group_by(title) %>%
     mutate (track_no = min_rank(trackid)) %>%
     ungroup() %>%
     transmute (album_title = title, track_no, track_name = name) %>%
     arrange(album_title, track_no)


# solutie cu dense_rank() - `trackid` este oricum unic, deci `min_rank` si
# `dense_rank` genereaza, in acest caz, acelasi rezultat
temp <- artist %>%
     filter (name == 'Led Zeppelin') %>%
     select (artistid) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     group_by(title) %>%
     mutate (track_no = dense_rank(trackid)) %>%
     ungroup() %>%
     transmute (album_title = title, track_no, track_name = name) %>%
     arrange(album_title, track_no)



############################################################################
##       Stiind ca `trackid` respecta ordinea pieselor de pe albume,
##  sa se numeroteze toate piesele de pe toate albumele tuturor artistilor;
##             artistii si albumele vor fi ordonate alfabetic
############################################################################

# solutie cu row_number()
temp <- artist %>%
     rename (artist_name = name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     arrange(artist_name, title, trackid) %>%
     group_by(artist_name, title) %>%
     mutate (track_no = row_number()) %>%
     ungroup() %>%
     transmute (artist_name, album_title = title, track_no, track_name = name) %>%
     arrange(artist_name, album_title, track_no)


# solutie cu min_rank()
temp <- artist %>%
     rename (artist_name = name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     group_by(artist_name, title) %>%
     mutate (track_no = min_rank(trackid)) %>%
     ungroup() %>%
     transmute (artist_name, album_title = title, track_no, track_name = name) %>%
     arrange(artist_name, album_title, track_no)



############################################################################
##            Afisati topul albumelor lansate de formatia Queen,
##                     dupa numarul de piese continute
############################################################################

# solutie cu min_rank()
temp <- artist %>%
        filter (name == 'Queen') %>%
        select (artistid) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        group_by(title) %>%
        summarise(n_of_tracks = n()) %>%
        ungroup() %>%
        mutate (album_rank = min_rank(desc(n_of_tracks)))


# solutie cu dense_rank()
temp <- artist %>%
        filter (name == 'Queen') %>%
        select (artistid) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        group_by(title) %>%
        summarise(n_of_tracks = n()) %>%
        ungroup() %>%
        mutate (album_rank = dense_rank(desc(n_of_tracks)))


############################################################################
##             Care este albumul (sau albumele) formatiei Queen
##                   cu cele mai multe piese? (reluare)
############################################################################

# solutie cu min_rank()
temp <- artist %>%
        filter (name == 'Queen') %>%
        select (artistid) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        group_by(title) %>%
        summarise(n_of_tracks = n()) %>%
        ungroup() %>%
        mutate (album_rank = min_rank(desc(n_of_tracks))) %>%
        filter (album_rank == 1)


############################################################################
## Pentru fiecare album al fiecarui artist, afisati pozitia albumului (dupa
##  numarul de piese continute) in clasamentul pe albumele artistului si
##   pozitia in clasamentul general (al albumelor tuturor artistilor)
############################################################################

# solutie cu min_rank()
temp <- artist %>%
        rename (artist_name = name) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        group_by(artist_name, title) %>%
        summarise (n_of_tracks = n()) %>%
        ungroup() %>%
        group_by(artist_name) %>%
        mutate(rank__artist = min_rank(desc(n_of_tracks))) %>%
        ungroup() %>%
        mutate(rank__overall = min_rank(desc(n_of_tracks))) %>%
        transmute (artist_name, album_title = title, n_of_tracks, rank__artist, rank__overall) %>%
        arrange(artist_name, album_title)


# solutie cu dense_rank()
temp <- artist %>%
        rename (artist_name = name) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        group_by(artist_name, title) %>%
        summarise (n_of_tracks = n()) %>%
        ungroup() %>%
        group_by(artist_name) %>%
        mutate(rank__artist = dense_rank(desc(n_of_tracks))) %>%
        ungroup() %>%
        mutate(rank__overall = dense_rank(desc(n_of_tracks))) %>%
        transmute (artist_name, album_title = title, n_of_tracks, rank__artist, rank__overall) %>%
        arrange(artist_name, album_title)


############################################################################
##   Luand in calcul numarul de piese, pe ce pozitie se gaseste albumul
##     `Machine Head`  in ierarhia albumelor formatiei `Deep Purple`?
############################################################################

# solutie cu dense_rank()
temp <- artist %>%
        filter (name == 'Deep Purple') %>%
        select (artistid) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        group_by(title) %>%
        summarise(n_of_tracks = n()) %>%
        ungroup() %>%
        mutate (album_rank = dense_rank(desc(n_of_tracks))) %>%
        filter (title == 'Machine Head')



############################################################################
##  Extrageti, pentru fiecare an, topul celor mai bine vandute trei piese
############################################################################

temp <- invoice %>%
        mutate (year = lubridate::year(invoicedate)) %>%
        select (invoiceid, year) %>%
        inner_join(invoiceline) %>%
        group_by(trackid, year) %>%
        summarise(sales = quantity * unitprice) %>%
        ungroup() %>%
        inner_join(track) %>%
        transmute (year, trackid, sales, track_name = name, albumid) %>%
        inner_join(album) %>%
        inner_join(artist) %>%
        transmute (year, track_name, album_title = title, artist_name = name,
                   sales) %>%
        group_by(year) %>%
        mutate (rank_of_the_track = min_rank(desc(sales))) %>%
        filter (rank_of_the_track <= 3) %>%
        arrange(year, rank_of_the_track)



############################################################################
##  Pentru fiecare luna cu vanzari, afisati cresterea sau scaderea valorii
##                vanzarilor, comparativ cu luna precedenta
############################################################################

temp <- invoice %>%
        mutate (year = lubridate::year(invoicedate),
                month = lubridate::month(invoicedate)) %>%
        group_by(year, month) %>%
        summarise (sales = sum(total)) %>%
        ungroup() %>%
        arrange(year, month) %>%
        transmute (year, month, current_month__sales = sales,
                   previous_month__sales = lag(sales, default = 0),
                   difference = current_month__sales - previous_month__sales)


############################################################################
##  Pentru fiecare an cu vanzari, afisati cresterea sau scaderea valorii
##           lunare a vanzarilor, comparativ cu luna precedenta
## (diferenta dintre lunile consecutive se va calcula numai in cadrul
## fiecarui an)
############################################################################

temp <- invoice %>%
        mutate (year = lubridate::year(invoicedate),
                month = lubridate::month(invoicedate)) %>%
        group_by(year, month) %>%
        summarise (sales = sum(total)) %>%
        ungroup() %>%
        arrange(year, month) %>%
        transmute (year, month, sales) %>%
        group_by(year) %>%
        mutate (current_month__sales = sales,
                previous_month__sales = lag(sales, default = 0),
                difference = current_month__sales - previous_month__sales) %>%
        ungroup()


############################################################################
### 			Probleme de rezolvat la curs/laborator/acasa
############################################################################

############################################################################
# # -- 			La ce intrebari raspund urmatoarele interogari ?
############################################################################

##
# # ...
