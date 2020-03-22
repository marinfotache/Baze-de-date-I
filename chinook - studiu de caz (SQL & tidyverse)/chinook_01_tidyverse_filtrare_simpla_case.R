# -- 		Interogari `tidyverse` vs SQL - BD Chinook (IE si SPE)
# --
# -- 01: Filtrare simpla, regular expressions, structuri CASE
# --
# -- ultima actualizare: 2020-02-26
#
#install.packages('tidyverse')
library(tidyverse)
library(lubridate)


############################################################################
# # --                   Importul tabelelor din PostgreSQL
############################################################################

## curatare sesiune curenta
rm(list = ls())

# install.packages('RPostgreSQL')
library(RPostgreSQL)

## incarcare driver PostgreSQL
drv <- dbDriver("PostgreSQL")


###  A. Stabilirea conexiunii cu BD PostgreSQL

## Windows
con <- dbConnect(drv, dbname="chinook", user="postgres",
                 host = 'localhost', password="postgres")

# Mac OS
con <- dbConnect(drv, host='localhost', port='5432', dbname='chinook',
                 user='postgres', password='postgres')


###  B. Extragerea numelui fiecarei tabele

tables <- dbGetQuery(con,
     "select table_name from information_schema.tables where table_schema = 'public'")
tables



###  C. Importul tuturor tabelelor
for (i in 1:nrow(tables)) {
     # extragrea tabelei din BD PostgreSQL
     temp <- dbGetQuery(con, paste("select * from ", tables[i,1], sep=""))
     # crearea dataframe-ului
     assign(tables[i,1], temp)
}


###  D. inchidere conexiuni PostgreSQL
for (connection in dbListConnections(drv) ) {
  dbDisconnect(connection)
}

###  E. Descarcare (din memorie) a driverului
dbUnloadDriver(drv)

###  F. Salvarea tuturor dataframe-urilor din
###  sesiunea curenta ca fisier .writeData

# # stergere obiecte inutile
rm(con, drv, temp, i, tables, connection )


#setwd('D:/chinook')
setwd('/Users/marinfotache/Downloads/chinook')
getwd()

# salvare
save.image(file = 'chinook.RData')

# stergerea tuturor obiectelor din sesiunea curenta R
rm(list = ls())


############################################################################
###       Incarcarea datelor salvate anterior in fisierul `.RData`       ###
####        (foarte util pentru sesiunile de lucru in R urmatoare)       ###
############################################################################
setwd('/Users/marinfotache/Downloads/chinook')
save.image(file = 'chinook.RData')



############################################################################
###                            Interogari tidyverse                      ###
############################################################################




############################################################################
# # --                   In ce ani s-au inregistrat vanzari?
############################################################################

###
# Solutie 1 - `mutate`, `select`, `distinct`, `arrange`
temp <- invoice %>%     # punctul de pornire: tabela/cadrul `invoice`
     mutate (year = lubridate::year(invoicedate)) %>%   # adaugare coloana `year`
     select (year) %>%   # se pastreaza numai atributul `year`
     distinct(year) %>%  # se elimina dublurile
     arrange(year)       # se ordoneaza rezultatul dupa valorile atributului `year`

View(temp)


# Solutie 2 - `transmute`, `distinct`, `arrange`
temp <- invoice %>%   # punctul de pornire: tabela/cadrul `invoice`
     transmute (year = lubridate::year(invoicedate)) %>%  # se elimina toate coloanele,
                                                          # cu exceptia noi coloane `year`
     distinct(year) %>%  # se elimina dublurile
     arrange(year)        # se ordoneaza rezultatul dupa valorile atributului `year`


# Solutie 3 - `distinct`, `arrange`
temp <- invoice %>%  # punctul de pornire: tabela/cadrul `invoice`
     distinct (year = lubridate::year(invoicedate)) %>%  # se pastreaza numai valorile
                                                         # distincte ale noului atributului
                                                         # `year`
     arrange(year)  # se ordoneaza rezultatul dupa valorile atributului `year`



############################################################################
# # --          Extrageti lunile calendaristice (si anii) in care
# # --                     s-au inregistrat vanzari
############################################################################

###
# Solutie 1 - `mutate`, `select`, `distinct`, `arrange`
temp <- invoice %>%    # punctul de pornire: tabela/cadrul `invoice`
     mutate (                                    # se adauga doua coloane, `year` si `month`
          year = lubridate::year(invoicedate),
          month = lubridate::month(invoicedate)
          ) %>%
     select (year, month) %>%   # se pastreaza numai cele doua atribute
     distinct(year, month) %>%  # se elimina dublurile combinatiei (year, month)
     arrange(year, month)       # se ordoneaza inregistrarile din rezultat dupa valorile
                                #  atributului `year`; la valori egale ale `year`,
                                #  criteriul de balotaj e `month`



# Solutie 2 - `transmute`, `distinct`, `arrange`
temp <- invoice %>%
     transmute (
          year = lubridate::year(invoicedate),
          month = lubridate::month(invoicedate)
          ) %>%
     distinct(year, month) %>%
     arrange(year, month)


# Solutie 3 - `distinct`, `arrange`
temp <- invoice %>%
     distinct (
          year = lubridate::year(invoicedate),
          month = lubridate::month(invoicedate)
          ) %>%
     arrange(year, month)



############################################################################
# # --          Care lungimea numelui pentru fiecare artist/formatie?
############################################################################

artist %>%
     mutate (lungime_nume = nchar(name)) -> temp


############################################################################
# # -- Sa se afiseze artistii in ordinea descrescatoare a lungimii numelui
############################################################################

temp <- artist %>%
     mutate (lungime_nume = nchar(name)) %>%
     arrange(desc(lungime_nume))


############################################################################
# # -- Sa se afiseze numele formatat al artistilor, conform urmatoarei cerinte:
# # -- 1. pentru artistii cu numele lung de pana la 11 caractere, 
#         se afiseaza numele intreg
# # -- 2. pentru artistii cu numele mai lung de 11 caracterere,
#         se extrag cinci caractere, se adauga `...` la mijloc 
#         si se finalizeaza cu ultimele cinci caractere
############################################################################

# -- solutia bazata pe LEFT si RIGHT din SQL nu are echivalent in R

# solutie ce foloseste functiile `substr` si `substring`
temp <- artist %>%
     mutate (nume_formatat = case_when(
          nchar(name) <= 11 ~ name,
          TRUE ~ paste0(substr(name, 1, 5), '...',
                        substring(name, nchar(name) -4)))
     )

# solutie ce foloseste functia `substr`
temp <- artist %>%
     mutate (nume_formatat = case_when(
          nchar(name) <= 11 ~ name,
          TRUE ~ paste0(substr(name, 1, 5), '...',
                        substr(name, nchar(name) -4, nchar(name))))
     )



############################################################################
# # -- Care sunt artistii sau formatiile cu numele alcatuit 
# dintr-un singur cuvant ? (adica numele nu contine niciun spatiu)
############################################################################

###
# solutie bazata pe `regular_expression` (`str_detect`)
temp <- artist %>%
     filter(!str_detect(name, ' '))


# solutie bazata pe `regular_expression` (`str_detect`) si `if_else`
temp <- artist %>%
     filter( if_else(str_detect(name, ' '), FALSE, TRUE))

# alti separatori intre cuvinte
temp <- artist %>%
     filter( if_else(str_detect(name, ' |/|\\.'), FALSE, TRUE))

# solutie bazata pe `regular_expression` (`str_detect`) si `case_when`
temp <- artist %>%
     filter( case_when (
             str_detect(name, ' ') ~ FALSE,
             TRUE ~ TRUE))

# solutie bazata pe numararea spatiilor
temp <- artist %>%
     mutate (nr_spatii = str_count(name, ' ')) %>%
     filter (nr_spatii == 0)

#... varianta fara `mutate`
temp <- artist %>%
     filter (str_count(name, ' ') == 0)

# echivalent SPLIT_PART din SQL vom folosi functia `word`
temp <- artist %>%
     mutate(
          primul_cuvant = word(name, 1),
          al_doilea_cuvant = word(name, 2)
            ) %>%
     filter (is.na(al_doilea_cuvant))

# solutie cu `str_replace_all` (echivalenta solutiei cu REPLACE din SQL)
temp <- artist %>%
     filter (name == str_replace_all(name, ' ', ''))

# solutie cu `str_remove_all`
temp <- artist %>%
     filter (name == str_remove_all(name, ' '))

# solutie cu `str_replace_all`
temp <- artist %>%
     filter (nchar(name) == nchar(str_replace_all(name, ' ', '')))

# solutie cu `str_remove_all`
temp <- artist %>%
     filter (nchar(name) == nchar(str_remove_all(name, ' ')))



############################################################################
# # -- Care sunt artistii sau formatiile cu numele alcatuit din cel 
#   putin doua cuvinte ? (adica numele contine cel putin singur spatiu)
############################################################################


temp <- artist %>%
     filter (str_detect(name, ' '))

# solutie bazata pe numararea spatiilor
temp <- artist %>%
     filter (str_count(name, ' ') > 0)

# echivalent SPLIT_PART din SQL vom folosi functia `word`
temp <- artist %>%
     mutate(
          primul_cuvant = word(name, 1),
          al_doilea_cuvant = word(name, 2)
            ) %>%
     filter (!is.na(al_doilea_cuvant))

temp <- artist %>%
     filter (nchar(name) > nchar(str_replace_all(name, ' ', '')))



# #
############################################################################
# # -- Care sunt artistii sau formatiile cu numele alcatuit din exact doua cuvinte ?
# # -- (adica numele contine un singur spatiu)
############################################################################

# solutie bazare pe `str_detect`
temp <- artist %>%
     filter (str_detect(name, ' ') & !str_detect(name, ' .* '))

# echivalent SPLIT_PART din SQL vom folosi functia `word`
temp <- artist %>%
     mutate(
          primul_cuvant = word(name, 1),
          al_doilea_cuvant = word(name, 2),
          al_treilea_cuvant = word(name, 3)
            ) %>%
     filter (!is.na(al_doilea_cuvant) & is.na(al_treilea_cuvant))


# -- soluție cu REPLACE
temp <- artist %>%
     filter (nchar(name) == nchar(str_replace_all(name, ' ', '')) + 1)


# solutie fara echivalent in SQL-Pg, bazata pe numararea spatiilor
temp <- artist %>%
     filter (str_count(name, ' ') == 1)




#
#
# -- ############################################################################
# -- 			Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################
#
# -- Extrageti numele de utilizator de pe contul de e-mail al fiecarui angajat
#
# -- Extrageti toate serverele de e-mail  (ex. `gmail.com`) ale clientilor
#
