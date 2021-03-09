################################################################################
###         Interogari `tidyverse` vs SQL - BD Chinook (IE/SPE/CIG)          ###
################################################################################
###                         02: Jonctiuni interne
################################################################################
### ultima actualizare: 2020-03-22

library(tidyverse)
library(lubridate)
setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")

#############################################################################
### 			               Care sunt albumele formatiei `U2`
#############################################################################


# sol 1.1 - NATURAL JOIN
temp <- artist %>%
      filter (name == 'U2') %>%
      inner_join(album)

# sol 1.2 - NATURAL JOIN
temp <- artist %>%
     inner_join(album) %>%
     filter (name == 'U2')


# -- sol. 2
temp <- artist %>%
     filter (name == 'U2') %>%
     inner_join(album, by = c('artistid' = 'artistid'))



############################################################################
### 	Care sunt piesele de pe albumul `Achtung Baby` al formatiei U2?
############################################################################

# sol 0 - ERONATA!!!
temp <- artist %>%
     inner_join(album) %>%
     inner_join(track) %>%
     filter (name == 'U2' & title == 'Achtung Baby')

# sol 1 - NATURAL JOIN + ECHI-JOIN
temp <- artist %>%
     inner_join(album) %>%
     inner_join(track, by = c('albumid' = 'albumid')) %>%
     filter (name.x == 'U2' & title == 'Achtung Baby')


# sol 2 - NATURAL JOIN + rename
temp <- artist %>%
     rename(artist_name = name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     filter (artist_name == 'U2' & title == 'Achtung Baby')


# sol 3 - NATURAL JOIN + select
temp <- artist %>%
     filter (name == 'U2') %>%
     select (-name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     filter (title == 'Achtung Baby')


# sol 4 - NATURAL JOIN + select + rename
temp <- artist %>%
     filter (name == 'U2') %>%
     inner_join(album) %>%
     inner_join(track %>%
                     rename (track_name = name)
                ) %>%
     filter (title == 'Achtung Baby')


# sol 5 - NATURAL JOIN + transmute + rename
temp <- artist %>%
     filter (name == 'U2') %>%
     transmute (artistid) %>%
     inner_join(album) %>%
     filter (title == 'Achtung Baby') %>%
     transmute (albumid) %>%
     inner_join(track %>%
                     rename (track_name = name)
                )



###########################################
# introd to semi_join

# inner join (natural)
temp <- album %>%
    inner_join(artist)


# semi join
temp <- album %>%
    semi_join(artist)


# inner join (natural)
temp <- artist %>%
    inner_join(album)


# semi join
temp <- artist %>%
    semi_join(album)

###########################################




# sol 6 - SEMI-JOIN
temp <- track %>%
     semi_join(
          album %>%
               filter (title == 'Achtung Baby') %>%
          semi_join(artist %>%
                         filter (name == 'U2')
                    )
     ) %>%
     select(trackid:composer)


############################################################################
###            #-- Care sunt piesele formatiei U2 vandute in anul 2013?
############################################################################
temp <- track %>%
             inner_join(album) %>%
             transmute (track_name = name, trackid, album_title = title,
                        artistid) %>%
             inner_join(artist %>%
                                filter (name == 'U2')) %>%
             select (track_name:album_title) %>%
             inner_join(invoiceline) %>%
             inner_join(invoice) %>%
             filter (lubridate::year(invoicedate) == 2013) %>%
             select (track_name, album_title) %>%
             arrange (track_name)



############################################################################
###          In ce tari s-a vandut muzica formatiei `Led Zeppelin`
############################################################################
temp <- artist %>%
    filter (name == 'Led Zeppelin') %>%
    select (artistid) %>%
    inner_join(album) %>%
    transmute (album_title = title, albumid) %>%
    inner_join(track) %>%
    transmute (track_name = name, album_title, trackid) %>%
    inner_join(invoiceline) %>%
    inner_join(invoice) %>%
    inner_join(customer) %>%
    distinct (country) %>%
    arrange(country)



############################################################################
###   Care sunt piesele formatiei `Led Zeppelin` la care, printre autori,
###               se numara bateristul `John Bonham`
############################################################################

temp <- artist %>%
      filter (name == 'Led Zeppelin') %>%
      select (artistid) %>%
      inner_join(album) %>%
      transmute (album_title = title, albumid) %>%
      inner_join(track) %>%
      filter (str_detect(composer, 'Bonham'))




############################################################################
### 			                    AUTOJONCTIUNE
############################################################################
###
###
############################################################################
###            Care sunt celelalte albume ale formatiei care a lansat
###                             albumul 'Achtung Baby'?
############################################################################

# -- solutie care `emuleaza` AUTO JOIN-ul din SQL

# sol 1 - NATURAL JOIN + select
temp <- album %>%
     filter (title == 'Achtung Baby') %>%
     select (artistid) %>%
     inner_join(album)


# sol 2 - ECHI-JOIN + transmute
temp <- album %>%
     filter (title == 'Achtung Baby') %>%
     inner_join(album, by = c('artistid' = 'artistid')) %>%
     transmute(artistid, albumid = albumid.y, title = title.y)



#########################################################################
###   Care este numele angajatului: lastname = 'Johnson' AND
###         firstname = 'Steve'
#########################################################################

# sol . 1
temp <- employee %>%
        filter (lastname == 'Johnson' & firstname == 'Steve') %>%
        inner_join(employee, by = c('reportsto' = 'employeeid')) %>%
        select (lastname.y, firstname.y)

# sol . 2
temp <- employee %>%
        filter (lastname == 'Johnson' & firstname == 'Steve') %>%
        transmute (employeeid = reportsto) %>%
        inner_join(employee)

# sol . 3
temp <- employee %>%
        filter (lastname == 'Johnson' & firstname == 'Steve') %>%
        select (reportsto) %>%
        inner_join(employee, by = c('reportsto' = 'employeeid'))




#
# -- ############################################################################
# -- 		         Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################
#
#
# -- Afisare piesele si artistii din playlistul `Heavy Metal Classic`
#
#
# -- Care sunt piesele formatiei `Led Zeppelin` compuse de cel putin trei muzicieni?
#
#
#-- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
#--	`Robert Plant`
#
#-- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
#--	nici `Robert Plant`, nici `Jimmy Page`
