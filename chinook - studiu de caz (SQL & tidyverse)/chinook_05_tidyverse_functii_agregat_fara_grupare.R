# -- 		   Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
# --
# -- 05: Functii agregat fara grupare
# --
#-- ultima actualizare: 2020-03-25
#
#
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2019/Studii de caz/chinook')
load("chinook.RData")


############################################################################
# #                 Cati artisti sunt in baza de date?
############################################################################

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



############################################################################
### 				Cati clienti au fax?
############################################################################

# sol 1
temp <- customer %>%
        filter(!is.na(fax)) %>%
        tally()
        
temp <- customer %>%
        filter(!is.na(fax)) %>%
        summarise(n_of_cust_with_faxes = n())




############################################################################
# #  --        Pentru cati artisti exista macar un album in BD?
############################################################################


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



############################################################################
# # --                   Din cate tari sunt clientii companiei?
############################################################################

# solutie bazata pe `n_distinct`
temp <- customer %>%
     summarise (n = n_distinct(country))




#
############################################################################
# # --              Din cate orase sunt clientii companiei?
############################################################################

# solutie bazata pe `n_distinct`
temp <- customer %>%
     summarise (n = n_distinct(paste(city, state,
                                     country, sep = ' - ')))



############################################################################
# # --      Cate secunde are albumul `Achtung Baby` al formatiei `U2`
############################################################################

# solutie bazata pe `summarise` si `sum`
temp <- album %>%
     filter (title == 'Achtung Baby') %>%
     semi_join(artist %>%
                    filter (name == 'U2')) %>%
     inner_join(track) %>%
     summarise(durata = sum(milliseconds / 1000))



############################################################################
# #            -- Care este durata medie (in secunde) a pieselor
# #            -- de pe albumul `Achtung Baby` al formatiei `U2`
############################################################################

# solutie bazata pe `summarise` si `mean`
temp <- album %>%
     filter (title == 'Achtung Baby') %>%
     semi_join(artist %>%
                    filter (name == 'U2')) %>%
     inner_join(track) %>%
     summarise(durata_medie = mean(milliseconds / 1000))



############################################################################
# # --         Care este durata medie a pieselor formatiei `U2`
############################################################################

# solutie bazata pe `summarise` si `mean`
temp <- album %>%
     semi_join(artist %>%
                    filter (name == 'U2')) %>%
     inner_join(track) %>%
     summarise(durata_medie = mean(milliseconds / 1000))



############################################################################
# # --      Care este durata medie a pieselor formatiei `Pink Floyd`
# # --                     exprimata in minute si secunde

############################################################################

# solutie bazata pe `summarise`, `mean` si `lubridate::seconds_to_period`
temp <- album %>%
     semi_join(artist %>%
                    filter (name == 'Pink Floyd')) %>%
     inner_join(track) %>%
     summarise(durata_medie =
          trunc(lubridate::seconds_to_period(mean(milliseconds / 1000))))




############################################################################
# # --                   In ce zi a fost prima vanzare?
############################################################################

temp <- invoice %>%
     summarise(first_day = min(invoicedate))



############################################################################
# # --                        In ce zi a fost ultima vanzare?
############################################################################


temp <- invoice %>%
     summarise(first_day = max(invoicedate))




# -- ############################################################################
# -- 			Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################
#
#
# -- Care este data primei angajari in companie
#
# -- Cate piese sunt pe playlistul `Grunge`?
#
# -- Cati subordonati are, in total (pe toate nivelurile) angajatul xxxxxx?
# 
# 


