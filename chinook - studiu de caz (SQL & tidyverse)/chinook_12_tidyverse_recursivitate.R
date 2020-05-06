################################################################################
###           Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
################################################################################
###              12: (Pseudo) Recursivitate
################################################################################
### ultima actualizare: 2020-05-06
# 

library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2020/Studii de caz/chinook')
load("chinook.RData")



############################################################################ 
###  	    A. Interogari recursive pentru probleme `pseudo-recursive`
############################################################################ 

############################################################################ 
## 	  Stiind ca `trackid` respecta ordinea pieselor de pe albume,
##   sa se numeroteze toate piesele de pe toate albumele formatiei
##    `Led Zeppelin`; albumele vor fi ordonate alfabetic 
############################################################################ 

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


############################################################################ 
###  	    B. Interogari recursive pentru probleme `recursive`
############################################################################ 
### `tidyverse` nu are (inca) un mecanism ne-procedural pentru recursivitate.
### In functie de natura problemei, solutiile pot fi procedurale sau bazate
### pe pachete ce prelucreaza grafuri (ex. `tidygraph`)

