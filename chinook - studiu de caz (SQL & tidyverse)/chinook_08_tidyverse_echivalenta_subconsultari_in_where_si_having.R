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
## tidyverse08: Echivalențe ale subconsultărilor SQL. Diviziune relațională (1)
## tidyverse08: Subqueries (sort of). Relational division (1)
##############################################################################
## ultima actualizare / last update: 2022-03-15

library(tidyverse)
library(lubridate)
setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")


###############################################################################
##        Echivalențe ale subconsultărilor SQL (necorelate) în clauza WHERE
###############################################################################
##               Equivalents of SQL uncorrelated subqueries in WHERE
###############################################################################



##############################################################################
##       Care sunt celelalte albume ale artistului sau formației care a
##                  lansat albumul `Houses of the Holy`
##############################################################################
##       List the other albums of the artist/band that released
##                    the album `Houses of the Holy`
##############################################################################

# solutie echivalenta auto-jonctiunii, fara afisarea artistului,
# cu includerea albumului-ancora ('Houses Of The Holy')
temp <- album %>%
     filter (title == 'Houses Of The Holy') %>%
     select (artistid) %>%
     inner_join(album)



# solutie echivalenta auto-jonctiunii, cu afisarea artistului,
# si includerea albumului-ancora ('Houses Of The Holy')
temp <- album %>%
     filter (title == 'Houses Of The Holy') %>%
     select (artistid) %>%
     inner_join(album) %>%
     inner_join(artist)


# solutie echivalenta (oarecum) sub-consultarii
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid == (album %>%
                              filter (title == 'Houses Of The Holy') %>%
                              pull(artistid))
                  )

# in locul operatorului `==` se poate folosi `%in%`
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid %in% (album %>%
                              filter (title == 'Houses Of The Holy') %>%
                              pull(artistid))
                  )


# o alta solutie echivalenta (oarecum) sub-consultarii (clauzei IN)
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid %in% (album %>%
                              filter (title == 'Houses Of The Holy')) [['artistid']] )

# alt gen de referinta
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid %in% (album %>%
                              filter (title == 'Houses Of The Holy')) [1,3] )


# ... si inca una....
temp <- album %>%
     inner_join(artist) %>%
     filter (artistid %in% (album %>%
                              filter (title == 'Houses Of The Holy') %>%
                              .$artistid)
                  )




##############################################################################
##     Care sunt piesele de pe albumul `Achtung Baby` al formației U2?
##############################################################################
##     List all tracks on the album `Achtung Baby` released by U2?
##############################################################################

temp <- track %>%
     filter (albumid == album %>%
                              filter (title == 'Achtung Baby' &
                                   artistid %in%
                                             (artist %>%
                                                  filter (name == 'U2') %>%
                                                  pull(artistid)
                                             )) %>%
                              pull(albumid)
                  )



# solutie care `mimeaza` doar o subconsultare in clauza WHERE
temp <- track %>%
     filter (albumid == album %>%
                              inner_join(artist) %>%
                              filter (title == 'Achtung Baby' & name == 'U2') %>%
                              pull(albumid)
                  )



##############################################################################
##			Care sunt piesele comune (cu acelasi titlu) de pe
##			albumele `Fear Of The Dark` si `A Real Live One`
##					ale formatiei 'Iron Maiden' (reluare)
##############################################################################
##			Extract the tracks (track name) included on both `Fear Of The Dark` and
## `A Real Live One` albums released by 'Iron Maiden' (the common tracks of
##     both albums) (reprise)
##############################################################################


temp <- artist %>%
     filter (name == 'Iron Maiden') %>%
     select (artistid) %>%
     inner_join(album) %>%
     filter (title == 'Fear Of The Dark') %>%
     select (albumid) %>%
     inner_join(track) %>%
     filter (name %in%
                    (artist %>%
                         filter (name == 'Iron Maiden') %>%
                         select (artistid) %>%
                         inner_join(album) %>%
                         filter (title == 'A Real Live One') %>%
                         select (albumid) %>%
                         inner_join(track) %>%
                         pull(name))
                  )



##############################################################################
##              Care sunt facturile din prima zi de vânzări?
##############################################################################
##              Extract invoices issued in the first day with sales
##############################################################################

# solutie care foloseste jonctiunea interna si `top_n`
temp <- invoice %>%
     inner_join(
          invoice %>%
               top_n(-1, invoicedate) %>%
               select (invoicedate)
     )

# solutie care foloseste jonctiunea interna si `row_number()`
temp <- invoice %>%
     inner_join(
          invoice %>%
               arrange(invoicedate) %>%
               filter (row_number() == 1) %>%
               select (invoicedate)
     )

# solutie care foloseste jonctiunea interna si `head`
temp <- invoice %>%
     inner_join(
          invoice %>%
               arrange(invoicedate) %>%
               head (1) %>%                 # echivalent al lui LIMIT din SQL
               select (invoicedate)
     )


# solutie care foloseste jonctiunea interna si `min`
temp <- invoice %>%
     inner_join(
          invoice %>%
               filter(invoicedate == min(invoicedate)) %>%
               select (invoicedate)
     )


# solutie care foloseste `min` fara jonctiune
temp <- invoice %>%
     filter(invoicedate == min(invoicedate))


# solutie care foloseste `%in%`
temp <- invoice %>%
     filter(invoicedate %in% (invoice %>%
                              top_n(-1, invoicedate) %>%
                              pull(invoicedate))
                 )


# solutie care foloseste doar `top_n`
temp <- invoice %>%
     top_n(-1, invoicedate)


# solutie care foloseste `slice`
temp <- invoice %>%
     arrange(invoicedate) %>%
     slice(1)


##############################################################################
##          Care sunt facturile din prima săptămână de vânzări?
##############################################################################
##       List invoices issued in the first week since the sales begun
##############################################################################

# prima solutie bazata pe un predicat similar `between`
temp <- invoice %>%
     filter (invoicedate >= min(invoicedate) &
                  invoicedate <=  min(invoicedate) + lubridate::days(7)
                  )

# a doua solutie bazata pe un predicat similar `between`
temp <- invoice %>%
     mutate (first_day = min(invoicedate),
           last_day = first_day + lubridate::days(7)) %>%
     filter (invoicedate >= first_day & invoicedate <= last_day)


# solutie bazata pe operatorul `%in%`
temp <- invoice %>%
     filter (invoicedate %in% (
          invoice %>%
               mutate (first_day = min(invoicedate),
                       last_day = min(invoicedate) + lubridate::days(7)) %>%
               filter (invoicedate >= first_day & invoicedate <= last_day) %>%
               pull(invoicedate))
     )



##############################################################################
##           Care sunt facturile din prima lună de vânzări?
##############################################################################
##       List invoices issued in the first month since the sales begun
##############################################################################

# prima solutie bazata pe un predicat similar `between`
temp <- invoice %>%
     filter (invoicedate >= min(invoicedate) &
                  invoicedate <=  min(invoicedate) +
                        lubridate::period(months = 1)
                  )

# a doua solutie bazata pe un predicat similar `between`
temp <- invoice %>%
     mutate (first_day = min(invoicedate),
           last_day = first_day + lubridate::period(months = 1)) %>%
     filter (invoicedate >= first_day & invoicedate <= last_day)


# solutie bazata pe operatorul `%in%`
temp <- invoice %>%
     filter (invoicedate %in% (
          invoice %>%
               mutate (first_day = min(invoicedate),
                       last_day = min(invoicedate) + lubridate::period(months = 1)) %>%
               filter (invoicedate >= first_day & invoicedate <= last_day) %>%
               pull(invoicedate))
     )


##############################################################################
##       Câte facturi s-au emis în anul și luna primei facturi?
##############################################################################
##   How many invoices were issued in the whole month when the sales begun?
##############################################################################

# solutie care `mimeaza` o singura subconsulare
temp <- invoice %>%
     filter ( paste(lubridate::year(invoicedate),
                    lubridate::month(invoicedate) + 100, sep = '-') ==
          (invoice %>%
               transmute( year_month_plus_100 = paste(lubridate::year(invoicedate),
                    lubridate::month(invoicedate) + 100, sep = '-')) %>%
               summarise ( year_month_plus_100 = min(year_month_plus_100)  ) %>%
               pull())
     )

# solutie care `mimeaza` trei subconsultari
temp <- invoice %>%
     filter (lubridate::year(invoicedate) ==
          (invoice %>%
               summarise( min = min(lubridate::year(invoicedate))) %>%
               pull()) ) %>%
     filter (lubridate::month(invoicedate) == lubridate::month(min(invoicedate)))



##############################################################################
##           Câte facturi s-au emis în primele 10 zile cu vânzări ?
##############################################################################
##   How many invoices were issued in the first 10 days with sales ?
##############################################################################

# prima solutie bazata pe `top_n`
temp <- invoice %>%
     inner_join(
          invoice %>%
               distinct(invoicedate) %>%
               arrange(invoicedate) %>%
               top_n(-10)
     )


# solutie bazata pe operatorul `%in%`
temp <- invoice %>%
     filter (invoicedate %in%
          (invoice %>%
               distinct(invoicedate) %>%
               arrange(invoicedate) %>%
               head(10) %>%
               pull()
          )
     )


#  solutie bazata pe `slice`
temp <- invoice %>%
     inner_join(
          invoice %>%
               distinct(invoicedate) %>%
               arrange(invoicedate) %>%
               slice(1:10)
     )


##############################################################################
##       Care sunt cei mai vechi cinci angajați ai companiei?
##############################################################################
##                    Extract the first five employed people
##############################################################################

# solutia bazata pe `top_n` ia in calcul si valorile egale, deci preferabila
# functiei `head` (functia `head` e oarecum echivalenta LIMIT-ului)
temp <- employee %>%
     top_n(-5, hiredate)




##############################################################################
##         Echivalențe ale subconsultărilor SQL incluse în clauza HAVING
##############################################################################
##         tidyverse equivalents of SQL subqueries included in HAVING
##############################################################################


##############################################################################
##     Care sunt albumele formației Led Zeppelin care au mai multe piese
##                           decât albumul `IV`
##############################################################################
##     List the albums released by Led Zeppelin with more tracks than
##                           the album `IV`
##############################################################################


# solutie care `mimeaza` o subconsultare ce contine numarul pieselor de
#       pe albumul `IV`
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'Led Zeppelin') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     filter (n_of_tracks >       ## here comes the "subquery"
          (artist %>%
               inner_join(album) %>%
               filter (name == 'Led Zeppelin' & title == 'IV') %>%
          select (-name) %>%
          inner_join(track)  %>%
          tally() %>%
          pull()
          ))


# solutie bazata pe adaugarea unei coloane care contine numarul pieselor
#       de pe albumul `IV`
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'Led Zeppelin') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     ungroup() %>%
     mutate (n_of_tracks_IV = if_else(title == 'IV', n_of_tracks, 0L)) %>%
                # `0L` e obligatoriu!!! (va explic la curs)
     mutate (n_of_tracks_IV = max(n_of_tracks_IV)) %>%
     filter (n_of_tracks > n_of_tracks_IV)



##############################################################################
##           Care este albumul (sau albumele) formației Queen
##                     cu cele mai multe piese?
##############################################################################
##           List the album (or albums) released by `Queen`
##                     having the largest number of tracks
##############################################################################

# solutie bazata pe `top_n`
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'Queen') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     ungroup() %>%
     top_n(1, n_of_tracks)


# solutie bazata pe `filter` si `max`
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'Queen') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     ungroup() %>%
     filter (n_of_tracks == max(n_of_tracks))



##############################################################################
##		Extrageți TOP 7 albume ale formației `U2`, după numărul de piese?
##############################################################################
##		    Get TOP 7 albums released by `U2`, by their number of tracks?
##############################################################################

temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'U2') %>%
     select (-name) %>%
     inner_join(track) %>%
     group_by(title) %>%
     summarise (n_of_tracks = n()) %>%
     ungroup() %>%
     arrange(desc(n_of_tracks))  %>%
     top_n(7, n_of_tracks)



##############################################################################
##                      Diviziune relațională (1)
##############################################################################
##                        Relational division (1)
##############################################################################


##############################################################################
##    Extrageți artiștii și albumele de pe care s-au vândut toate piesele.
##Notă: se iau în calcul numai albumele cu cel puțin două piese
##############################################################################
##    List the artist and their albums for which all album tracks were
##     sold
##Important notice: only albums with at least two tracks are considered
##############################################################################


# solutie care compara, pentru fiecare album, numarul de piese de pe album
#       cu numarul de piese vandute
temp <- artist %>%                      # se extrage numarul de piese de pe fiecare album
     rename(artist_name = name ) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     group_by(artist_name, title) %>%
     summarise(n_of_tracks = n()) %>%
     filter (n_of_tracks > 1) %>%
          inner_join(
               # artistii, albumele si numarul de piese de pe album se vor
               #   jonctiona cu artistii, albumele si numarul de piese (de pe acel album)
               #   vandute
     artist %>%                      # se extrage numarul de piese vandute de pe fiecare album
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          group_by(artist_name, title) %>%
          summarise(n_of_tracks = n_distinct(trackid))
          ) %>%
     arrange(artist_name)



# solutie bazata pe logica diviziunii
temp <- artist %>%                      # se extrage numarul de piese vandute de pe fiecare album
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          arrange(artist_name, title, albumid, name) %>%
          group_by(artist_name, title, albumid) %>%
          summarise (all_tracks_from_this_album = paste(name, collapse = '|'))  %>%
          ungroup() %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          distinct(artist_name, title, albumid, all_tracks_from_this_album, name) %>%
          arrange(artist_name, title, albumid, name) %>%
          group_by(artist_name, title, all_tracks_from_this_album) %>%
          summarise (sold_tracks_from_the_album = paste(name, collapse = '|'))  %>%
          ungroup() %>%
          filter (all_tracks_from_this_album == sold_tracks_from_the_album &
                    str_detect(all_tracks_from_this_album, '\\|')) %>%
          arrange(artist_name)




##############################################################################
##	 Care sunt artiștii cu vânzări în toate țările din urmatorul set:
## ('USA', 'France', 'United Kingdom', 'Spain')
##############################################################################
##	 Find the artists with sales in ALL of the countries from the following set:
## ('USA', 'France', 'United Kingdom', 'Spain')
##############################################################################

# echivalenta primei solutii SQL (vezi scriptul `chinook_08_sql...`)
temp <- artist %>%
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country %in%  c('USA', 'France', 'United Kingdom', 'Spain')) %>%
          group_by(artist_name) %>%
          summarise(n_of_countries = n_distinct(country)) %>%
          filter (n_of_countries == 4)


# echivalenta celei de-a doua solutii SQL (vezi scriptul `chinook_08_sql...`)
temp <- artist %>%
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country %in%  c('USA', 'France', 'United Kingdom', 'Spain')) %>%
          distinct(artist_name, country) %>%
          arrange(artist_name, country) %>%
          group_by(artist_name) %>%
          summarise(countries = paste(country, collapse = '|')) %>%
          ungroup() %>%
          inner_join(
               customer %>%
                    filter (country %in%  c('USA', 'France', 'United Kingdom', 'Spain')) %>%
                    distinct(country) %>%
                    arrange(country) %>%
                    summarise(countries = paste(country, collapse = '|'))
          )


# o alta solutie echivalenta celei de-a doua solutii SQL (vezi scriptul `chinook_08_sql...`)
temp <- artist %>%
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country %in%  c('USA', 'France', 'United Kingdom', 'Spain')) %>%
          distinct(artist_name, country) %>%
          arrange(artist_name, country) %>%
          group_by(artist_name) %>%
          summarise(countries = paste(country, collapse = '|')) %>%
          ungroup() %>%
          inner_join(
               c('USA', 'France', 'United Kingdom', 'Spain') %>%
               enframe() %>%
               transmute(country = value) %>%
               arrange (country) %>%
               summarise(countries = paste(country, collapse = '|'))
          )




##############################################################################
##   Care sunt artiștii cu vânzări în toate orașele din 'United Kingdom' din
##                         care provin clienții
##############################################################################
##   Find the artist with sales in all the 'United Kingdom' cities where is
##                         at least one customer
##############################################################################

temp <- artist %>%
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country ==  'United Kingdom') %>%
          group_by(artist_name) %>%
          summarise(n_of_cities_uk = n_distinct(city)) %>%
     inner_join(
          customer %>%
               filter (country ==  'United Kingdom') %>%
               summarise(n_of_cities_uk = n_distinct(city))
     )


# solutie mai apropiata de logica diviziunii
temp <- artist %>%
          rename(artist_name = name ) %>%
          inner_join(album) %>%
          inner_join(track) %>%
          select (-unitprice) %>%
          inner_join(invoiceline) %>%
          inner_join(invoice) %>%
          inner_join(customer) %>%
          filter (country ==  'United Kingdom') %>%
          distinct(artist_name, city) %>%
          arrange(artist_name, city) %>%
          group_by(artist_name) %>%
          summarise(cities_uk = paste(city, collapse = '|')) %>%
     inner_join(
          customer %>%
               filter (country ==  'United Kingdom') %>%
               distinct(city) %>%
               arrange(city) %>%
               summarise(cities_uk = paste(city, collapse = '|'))
     )





##############################################################################
##               Probleme de rezolvat la curs/laborator/acasa
##############################################################################
##               To be completed during lectures/labs or at home
##############################################################################
# #
# # ##Care primul (sau primii) angajat(i) in companie?
# #
# # ##Care sunt artistii care au in baza de date mai multe albume decat
#       formatia `Queen`?
# #
# #




##
## Care sunt piesele formatiei `Led Zeppelin` mai lungi decat `Stairway to Heaven`
##     de pe albumul `IV`
##

## solutie echivalenta unei interogari SQL ce foloseste subconsultare in
## clauza WHERE
temp <- artist %>%
        filter (name == 'Led Zeppelin') %>%
        select (artistid) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        filter (milliseconds >
                (
                       track %>%
                               filter (name == 'Stairway To Heaven') %>%
                               inner_join(album) %>%
                               filter (title == 'IV') %>%
                               inner_join(artist %>%
                                                  filter (name == 'Led Zeppelin') %>%
                                                  select (artistid)) %>%
                               select (milliseconds) %>%
                               pull(milliseconds)
                )
                        ) %>%
        select (name, title, milliseconds) %>%
        arrange(milliseconds)



## solutie bazata pe crearea unei coloane ce contine valoarea de referinta
temp <- artist %>%
        filter (name == 'Led Zeppelin') %>%
        select (artistid) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        mutate (milliseconds_stairway =
                        if_else(name == 'Stairway To Heaven' & title == 'IV',
                                milliseconds, 0L)) %>%
        mutate (milliseconds_stairway = max(milliseconds_stairway)) %>%
        filter (milliseconds > milliseconds_stairway) %>%
        select (name, title, milliseconds) %>%
        arrange(milliseconds)

glimpse(track)



##
## Care sunt albumele formatiei `Led Zeppelin` mai lungi decat  albumul `IV`
##

## solutie bazata pe crearea unei coloane ce contine valoarea de referinta
temp <- artist %>%
        filter (name == 'Led Zeppelin') %>%
        select (artistid) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        group_by(title) %>%
        summarise(album_duration = sum(milliseconds) / 1000) %>%
        ungroup() %>%
        mutate (duration_IV = if_else(title == 'IV', album_duration, 0)) %>%
        mutate(duration_IV = max(duration_IV)) %>%
        filter (album_duration > duration_IV) %>%
        arrange(album_duration)



## solutie echivalenta unei interogari SQL ce foloseste subconsultare in
## clauza HAVING
temp <- artist %>%
        filter (name == 'Led Zeppelin') %>%
        select (artistid) %>%
        inner_join(album) %>%
        inner_join(track) %>%
        group_by(title) %>%
        summarise(album_duration = sum(milliseconds) / 1000) %>%
        ungroup() %>%
        filter(album_duration >
                       (      # "subconsultare" care furnizeaza durata albumului `IV`
                        artist %>%
                                filter (name == 'Led Zeppelin') %>%
                                select (artistid) %>%
                                inner_join(album) %>%
                                filter (title == 'IV') %>%
                                inner_join(track) %>%
                                summarise(album_duration = sum(milliseconds) / 1000) %>%
                                pull(album_duration)
                       )
                       )  %>%
        arrange(album_duration)


##############################################################################
##	 Care sunt artiștii `vânduți` în toate țările din care provin clienții?
##############################################################################
##	     Find the artists with sales in all of the countries with customers
##############################################################################



##############################################################################
##             La ce întrebări răspund următoarele interogări ?
##############################################################################
##          For what requiremens the following queries provide the result?
##############################################################################

##
temp <- customer %>%
        group_by(country) %>%
        summarise(n = n()) %>%
        ungroup() %>%
        mutate (n_brazil = if_else(country == 'Brazil', n, 0L)) %>%
        mutate(n_brazil = max(n_brazil)) %>%
        filter (n >= n_brazil)


# echivalent
temp <- customer %>%
        group_by(country) %>%
        summarise(n = n()) %>%
        ungroup() %>%
        filter (n >= (
                # subconsultare care furnizeaza numarul clientilor din `Brazil`
                customer %>%
                        filter (country == 'Brazil') %>%
                        summarise (n = n()) %>%
                        pull(n)
        ))


# Brazil trebuie exclusa din rezultat
temp <- customer %>%
        group_by(country) %>%
        summarise(n = n()) %>%
        ungroup() %>%
        mutate (n_brazil = if_else(country == 'Brazil', n, 0L)) %>%
        mutate(n_brazil = max(n_brazil)) %>%
        filter (n >= n_brazil & country != 'Brazil')


temp <- customer %>%
        group_by(country) %>%
        summarise(n = n()) %>%
        ungroup() %>%
        filter (n >= (
                # subconsultare care furnizeaza numarul clientilor din `Brazil`
                customer %>%
                        filter (country == 'Brazil') %>%
                        summarise (n = n()) %>%
                        pull(n)
        ) &  country != 'Brazil')





##
temp <- invoice %>%
        transmute(year = year(invoicedate), customerid) %>%
        inner_join(customer) %>%
        distinct(country, year) %>%
        inner_join(
                invoice %>%
                        transmute(year = year(invoicedate), customerid) %>%
                        inner_join(customer) %>%
                        filter (country == 'Brazil') %>%
                        select (year)) %>%
        group_by(country) %>%
        summarise(n = n_distinct(year)) %>%
        ungroup() %>%
        filter ( n %in%
                        (invoice %>%
                                transmute(year = year(invoicedate), customerid) %>%
                                inner_join(customer) %>%
                                filter (country == 'Brazil') %>%
                                summarise (n = n_distinct(year))) [['n']]
                         )
