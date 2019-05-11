# # -- 			 Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
# # --
# # -- 12: (Pseudo) Recursivitate
# # --
# # -- ultima actualizare: 2019-05-10
# # 

library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2019/Studii de caz/chinook')
load("chinook.RData")



# # 
# # 
# # -- ############################################################################ 
# # --   		A. Interogari recursive pentru probleme `pseudo-recursive`
# # -- ############################################################################ 
# # 
# # 
# # -- ############################################################################ 
# # -- 		Stiind ca `trackid` respecta ordinea pieselor de pe albume,
# # --  sa se numeroteze toate piesele de pe toate albumele formatiei
# # -- `Led Zeppelin`; albumele vor fi ordonate alfabetic 
# # -- ############################################################################ 
# # 
# # 
# # -- SQL
# # 
# # 
# # -- solutie mai simpla, care, in loc de recursivitate, foloseste gruparea si 
# # --   functia `string_agg`
# # -- (vezi si scriptul `chinook_08_sql_subconsultari_in_where_si_having.sql`)
# # WITH track_numbering AS
# # 	(SELECT album.albumid, title as album_title, artist.name as artist_name, 
# # 		ROW_NUMBER() OVER (PARTITION BY title ORDER BY trackid) AS track_no,
# # 		track.name AS track_name
# # 	FROM artist 
# # 		NATURAL JOIN album
# # 		INNER JOIN track ON album.albumid = track.albumid
# # 	ORDER BY 2, 4 
# # 	)
# # SELECT albumid, album_title, artist_name,
# # 	string_agg(DISTINCT CAST(RIGHT(' ' || track_no,2) || ':' || track_name AS VARCHAR), '; '
# # 							 ORDER BY CAST(RIGHT(' ' || track_no,2) || ':' || track_name AS VARCHAR)) 
# # 							 AS all_tracks_from_this_album
# # FROM track_numbering	
# # GROUP BY albumid, album_title, artist_name
# # 
# # 
# # 
###
### tidyverse
### 
# Singura solutie `nativa` tidyverse este cea urmatoare, apropiata logicii
# interogarii de mai sus:
temp <- artist %>%
     rename (artist_name = name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     arrange(artist_name, title, trackid) %>%                   
     group_by(artist_name, title) %>%
     mutate (track_no = row_number()) %>%
     summarise(all_tracks_from_this_album = paste(paste0(track_no, ':', name), collapse = '; ')) %>%
     ungroup()


# # 
# # -- ############################################################################ 
# # --   		    B. Interogari recursive pentru probleme `recursive`
# # -- ############################################################################ 
# # 
# # 
### `tidyverse` nu are (inca) un mecanism ne-procedural pentru recursivitate.
### In functie de natura problemei, solutiile pot fi procedurale sau bazate
### pe pachete ce prelucreaza grafuri (ex. `tidygraph`)

