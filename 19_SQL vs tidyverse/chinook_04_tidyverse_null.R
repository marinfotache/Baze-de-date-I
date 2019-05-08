# # ####       -- 		Interogari `tidyverse` vs SQL - BD Chinook (IE si SPE)
# 
# 
# # -- 04: Tratamentul (meta)valorilor NA (echivalentul NULL din SQL)
# # -- Atentie: valorile NULL au alt regim in limbajul R!!!!
# 
# # -- ultima actualizare: 2019-04-14
# # 
# 
# # 
# # -- ############################################################################ 
# # -- 									IS NULL
# # -- ############################################################################ 
# # 
# # -- ############################################################################ 
# # -- Care sunt piesele de pe albumele formatiei `Black Sabbath`
# # -- carora nu se cunoaste compozitorul
# # -- ############################################################################ 
# # 
# # #-- SQL
# 
# # SELECT *
# # FROM artist 
# # 	INNER JOIN album ON artist.artistid = album.artistid
# # 	INNER JOIN track ON album.albumid = track.albumid
# # WHERE artist.name = 'Black Sabbath' AND composer is null
# # 


###
### tidyverse
### 

# solutia bazata pe functia `is.na`
temp <- artist %>%
     filter (name == 'Black Sabbath') %>%
     select (-name) %>%
     inner_join(album) %>%
     inner_join(track) %>%
     select (name, composer) %>%
     filter (is.na(composer))



# # -- ############################################################################ 
# # -- 								COALESCE
# # -- ############################################################################ 
# # 
# # -- ############################################################################ 
# # -- Sa se afiseze, in ordine alfabetica, toate titlurile pieselor de pe 
# # -- albumele formatiei `Black Sabbath`, impreuna cu autorul (compozitor) lor;
# # -- acolo unde compozitorul nu este specificat (NULL), sa se afiseze
# # -- `COMPOZITOR NECUNOSCUT`
# # -- ############################################################################ 
# #
# #-- SQL
# 
# # SELECT track.name, COALESCE(composer, 'COMPOZITOR NECUNOSCUT') AS compozitor
# # FROM artist 
# # 	INNER JOIN album ON artist.artistid = album.artistid
# # 	INNER JOIN track ON album.albumid = track.albumid
# # WHERE artist.name = 'Black Sabbath' 
# # ORDER BY 1
# # 


###
### tidyverse
### 

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
# -- 						Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################ 
# 
# -- Extrageti clientii neafiliati niciuneii companii
# 
# -- Afisati clientii in ordinea tarilor; pentru cei din tari non-federative, 
# --   la atributul `state`, in locul valorii NULL afisati `-`
# 
# 
# -- Afisati toate facturile (tabela `invoice), completand eventualele valori NULL
# --   ale atributului `billingstate` cu valoarea tributului `billing city` de pe
# --   aceeasi linie
# 



