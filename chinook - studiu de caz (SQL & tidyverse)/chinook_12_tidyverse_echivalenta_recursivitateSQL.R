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
## 					tidyverse12: Interogări recursive
## 					tidyverse12: SQL recursive queries' equivalents
##############################################################################
## ultima actualizare / last update: 2022-03-17

library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")



##############################################################################
##  		A. Interogări recursive pentru probleme `pseudo-recursive`
##############################################################################
##  		A. Recursive queries for non-recursive problems :-)
##############################################################################

##############################################################################
##		Știind că `trackid` respectă ordinea (poziția) pieselor de pe albume,
## să se numeroteze toate piesele de pe toate albumele formației
##`Led Zeppelin`; albumele vor fi ordonate alfabetic, iar piesele după
##poziția lor în cadrul albumului (reluare)
##############################################################################
##		As `trackid` incorporated the track order on each album,
## attach a track number from 1 to N (where N is the number of tracks on
## the current album) for every track on each album released by `Led Zeppelin`;
## albums will be ordered alphabetically, and tracks by their album position
##(reprise)
##############################################################################

# Singura solutie `nativa` tidyverse foloseste `paste(..., collapse = ';')``
temp <- artist %>%
     rename (artist_name = name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     arrange(artist_name, title, trackid) %>%
     group_by(artist_name, title) %>%
     mutate (track_no = row_number()) %>%
     summarise(all_tracks_from_this_album = paste(paste0(track_no, ':', name), collapse = '; ')) %>%
     ungroup()


##############################################################################
##           B. Interogari recursive pentru probleme `recursive`
##############################################################################
##           B. Recursive queries for `recursive` problems
##############################################################################
### `tidyverse` nu are (inca) un mecanism ne-procedural pentru recursivitate.
### In functie de natura problemei, solutiile pot fi procedurale sau bazate
### pe pachete ce prelucreaza grafuri (ex. `tidygraph`)



##############################################################################
##               Probleme de rezolvat la curs/laborator/acasa
##############################################################################
##               To be completed during lectures/labs or at home
##############################################################################




##############################################################################
##             La ce întrebări răspund următoarele interogări ?
##############################################################################
##          For what requiremens the following queries provide the result?
##############################################################################


##...
