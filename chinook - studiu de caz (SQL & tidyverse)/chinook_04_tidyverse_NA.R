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
## 			tidyverse04: Tratamentul valorilor lipsă
## 			tidyverse04: Missing values (NA) treatment (in R NULLs are not NAs!!!)
##############################################################################
## ultima actualizare / last update: 2023-12-01

library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")


##############################################################################
###                                    is.na()
##############################################################################

##############################################################################
##            Care sunt clienții individuali (non-companii)
##############################################################################
##            Extract the individual (non-companies) customers
##############################################################################

temp <- customer %>%
        filter (is.na(company))


##############################################################################
##               Care sunt clienții care reprezintă companii
##############################################################################
##               Which are the customers representing companies?
##############################################################################

temp <- customer %>%
        filter (!is.na(company))



##############################################################################
##      Care sunt piesele de pe albumele formației `Black Sabbath`
##                  cărora nu li se cunoaște compozitorul
##############################################################################
## Extract the tracks released by `Black Sabbath` whose composers are unknown
##############################################################################

# `is.na`
temp <- artist %>%
     filter (name == 'Black Sabbath') %>%
     select (-name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     select (name, composer) %>%
     filter (is.na(composer))


# `is.na`
temp <- artist %>%
     filter (name == 'Black Sabbath') %>%
     inner_join(album) %>%
     inner_join(track, by = c('albumid' = 'albumid')) %>%
     transmute (track_name = name.y, composer) %>%
     filter (is.na(composer))


##############################################################################
##   Să se afișeze, sub formă de șir de caractere, orașele din care provin
## clienții (pentru a elimina confuziile, numele orașului trebuie concatenat
## cu statul și tara din care face parte orașul respectiv)
##############################################################################
##  Extract, as strings, the cities of the customers (the string will contain
## the city name concatenated with its state and country)
##############################################################################



#############################################################################
##  Afisati clientii in ordinea tarilor; pentru cei din tari non-federative,
##  la atributul `state`, in locul valorii NULL, afisati `-`
#############################################################################

# `if_else`
temp <- customer %>%
    select (customerid:lastname, state) %>%
    mutate(state2 = if_else(is.na(state), '-', state))


# `case_when`
temp <- customer %>%
    select (customerid:lastname, state) %>%
    mutate(state2 = case_when(
            is.na(state) ~ '-',
            TRUE ~ state))


#  `coalesce` - vezi mai jos / see below
#
#


##############################################################################
###                               COALESCE
##############################################################################

##############################################################################
## Afișați clienții în ordinea țărilor; pentru cei din țări non-federative,
##   la atributul `state`, în locul valorii NULL, afișati `-`
##############################################################################
## Display customers ordered by their countries. For customers in
##  non-federative countries, the NULL value of attribute `state` will be
##   replaces with hyphen (`-`)
##############################################################################

temp <- customer %>%
    select (customerid:lastname, state) %>%
    mutate(state2 = coalesce(state, '-'))


##############################################################################
## Să se afișeze, în ordine alfabetică, toate titlurile pieselor de pe
##  albumele formației `Black Sabbath`, împreuna cu autorii (compozitorii) lor;
##  acolo unde compozitorul nu este specificat (NULL), să se afișeze
##  `COMPOZITOR NECUNOSCUT`
##############################################################################
## Dispay alphabeticaly the names of the names released by `Black Sabbath` and
##  theirs composers; whenever the composes is unknown, replace NULL with
##  `COMPOZITOR NECUNOSCUT`
##############################################################################

#  `coalesce`
temp <- artist %>%
     filter (name == 'Black Sabbath') %>%
     select (-name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     transmute (name, composer = coalesce(composer, 'COMPOZITOR NECUNOSCUT')) %>%
     arrange(name)





##############################################################################
##               Probleme de rezolvat la curs/laborator/acasa
##############################################################################
##               To be completed during lectures/labs or at home
##############################################################################


# ############################################################################
# Sa se afiseze, sub forma de sir de caractere, orasele din care provin
# clientii (pentru a elimina confuziile, numele orasului trebuie concatenat
# cu statul si tara din care face parte orasul respectiv)

temp <- customer %>%
    select (city, state, country) %>%
    mutate (city_string1 = paste(city, coalesce(state, '-'), country)) %>%
    distinct(.)





############################################################################
# ##Afisati toate facturile (tabela `invoice), completand eventualele valori NULL
# ##  ale atributului `billingstate` cu valoarea tributului `billing city` de pe
# ##  aceasi linie
#



##############################################################################
##             La ce întrebări răspund următoarele interogări ?
##############################################################################
##          For what requiremens the following queries provide the result?
##############################################################################
