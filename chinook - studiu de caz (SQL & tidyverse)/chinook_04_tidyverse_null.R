# # ####       -- 		Interogari `tidyverse` vs SQL - BD Chinook (IE si SPE)
#
#
# # -- 04: Tratamentul (meta)valorilor NA (echivalentul NULL din SQL)
# # -- Atentie: valorile NULL au alt regim in limbajul R!!!!
#
# ultima actualizare: 2020-03-25
# #
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2020/Studii de caz/chinook')
load("chinook.RData")

# #
# # -- ############################################################################
# # -- 				IS NULL NU EXISTA IN R (exista, dar are
#                                       alt regim)
# # -- ############################################################################
# #
# 

############################################################################
##               Care sunt clientii individuali (non-companii)
############################################################################

temp <- customer %>%
        filter (is.na(company))


############################################################################
##               Care sunt clientii care reprezinta companii
############################################################################

temp <- customer %>%
        filter (!is.na(company))




# # -- ############################################################################
# # -- Care sunt piesele de pe albumele formatiei `Black Sabbath`
# # -- carora nu li se cunoaste compozitorul
# # -- ############################################################################
# #

# solutia bazata pe functia `is.na`
temp <- artist %>%
     filter (name == 'Black Sabbath') %>%
     select (-name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     select (name, composer) %>%
     filter (is.na(composer))



# # -- ############################################################################
# # -- 				  COALESCE
# # -- ############################################################################
# #
# # -- ############################################################################
# # -- Sa se afiseze, in ordine alfabetica, toate titlurile pieselor de pe
# # -- albumele formatiei `Black Sabbath`, impreuna cu autorul (compozitor) lor;
# # -- acolo unde compozitorul nu este specificat (NULL), sa se afiseze
# # -- `COMPOZITOR NECUNOSCUT`
# # -- ############################################################################
# #

# solutie bazata pe functia `coalesce`
temp <- artist %>%
     filter (name == 'Black Sabbath') %>%
     select (-name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     transmute (name, composer = coalesce(composer, 'COMPOZITOR NECUNOSCUT')) %>%
     arrange(name)




#
#
# -- ############################################################################
# -- 			Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################
#
#
# -- Afisati clientii in ordinea tarilor; pentru cei din tari non-federative,
# --   la atributul `state`, in locul valorii NULL afisati `-`

temp <- customer %>%
        select (customerid:lastname, state) %>%
        mutate(state2 = coalesce(state, '-'))


#
# -- Afisati toate facturile (tabela `invoice), completand eventualele valori NULL
# --   ale atributului `billingstate` cu valoarea tributului `billing city` de pe
# --   aceeasi linie
#
