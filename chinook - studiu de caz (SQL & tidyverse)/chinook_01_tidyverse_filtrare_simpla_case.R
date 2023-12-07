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
## 		tidyverse01: Filtrare simpla, regular expressions, structuri CASE
## 		tidyverse01: Data frame filters, regular expressions, CASE structures
##############################################################################
## ultima actualizare / last update: 2023-12-07

##############################################################################
### Functii/operatori/optiuni utilizate (si prezente in subiectele
###     de la testele Moodle urmatoare)
###---------------------------------------------------------------------------
### Some `tidyverse` functions in this script (and subsequent Moodle quizzes)
###---------------------------------------------------------------------------

### `year`, `month`, ... (din pachetul `lubridate`)
### `nchar`
### `case_when`
### `if_else`
### `substr`, `substring`
### `str_detect`
### `str_count`
### `word`
### `str_replace_all`
### `str_remove_all`
##############################################################################


#install.packages('tidyverse')
library(tidyverse)
#install.packages('lubridate')
library(lubridate)


############################################################################
###       Incarcarea datelor salvate anterior in fisierul `.RData`       ###
############################################################################
###                Load data previously saved in `.RData` file           ###
############################################################################

setwd('/Users/marinfotache/Downloads/chinook')
load(file = 'chinook.RData')
#glimpse(invoice)

############################################################################
###                          Interogări `tidyverse`                      ###
############################################################################
###                           `tidyverse` queries                        ###
############################################################################



############################################################################
##                    În ce ani s-au înregistrat vânzări?
############################################################################
##                    Extract the years when sales occurred
############################################################################

###
# sol.1 - `mutate`, `select`, `distinct`, `arrange`
temp <- invoice %>%     # punctul de pornire: tabela/cadrul `invoice`
     mutate (year = lubridate::year(invoicedate)) %>%   # adaugare coloana `year`
     select (year) %>%   # se pastreaza numai atributul `year`
     distinct(year) %>%  # se elimina dublurile
     arrange(year)       # se ordoneaza rezultatul dupa valorile atributului `year`

View(temp)


# Sol.2 - `transmute`, `distinct`, `arrange`
temp <- invoice %>%   # punctul de pornire: tabela/cadrul `invoice`
     transmute (year = lubridate::year(invoicedate)) %>%  # se elimina toate coloanele,
                                                          # cu exceptia noi coloane `year`
     distinct(year) %>%  # se elimina dublurile
     arrange(year)        # se ordoneaza rezultatul dupa valorile atributului `year`


# Sol.3 - `distinct`, `arrange`
temp <- invoice %>%  # punctul de pornire: tabela/cadrul `invoice`
     distinct (year = lubridate::year(invoicedate)) %>%  # se pastreaza numai valorile
                                                         # distincte ale noului atributului
                                                         # `year`
     arrange(year)  # se ordoneaza rezultatul dupa valorile atributului `year`


##############################################################################
## Extrageți lunile calendaristice (și anii) în care s-au înregistrat vânzări
##############################################################################
##              Extract the months (and their years) with sales
##############################################################################

###
# Sol.1 - `mutate`, `select`, `distinct`, `arrange`
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


# rezultat cu o singura coloana:atentie la ordonare!
# single-column results: watch out the order!
temp <- invoice %>%
     mutate (
          year = lubridate::year(invoicedate),
          month = lubridate::month(invoicedate)
          ) %>%
     transmute (year_month = paste(year, month, sep = '-')) %>%
     distinct(year_month) %>%
     arrange(year_month)


# ordonarea e acum corecta
# now the order is fine
temp <- invoice %>%
     mutate (
          year = lubridate::year(invoicedate),
          month = lubridate::month(invoicedate)) %>%
     arrange(year, month) %>%
     transmute (year_month = paste(year, month, sep = '-')) %>%
     distinct(year_month)




# Sol.2 - `transmute`, `distinct`, `arrange`
temp <- invoice %>%
     transmute (
          year = lubridate::year(invoicedate),
          month = lubridate::month(invoicedate)
          ) %>%
     distinct(year, month) %>%
     arrange(year, month)


# Sol.3 - `distinct`, `arrange`
temp <- invoice %>%
     distinct (
          year = lubridate::year(invoicedate),
          month = lubridate::month(invoicedate)
          ) %>%
     arrange(year, month)



##############################################################################
##  Care este lungimea numelui pentru fiecare artist/formatie?
##############################################################################
##  Extract the lenght (the number of characters) for each artist/band's name
##############################################################################

artist %>%
     mutate (lungime_nume = nchar(name)) -> temp


##############################################################################
##    Să se afișeze artiștii în ordinea descrescătoare a lungimii numelui
##############################################################################
##    Display artists/bands ordering (descending) them on their name's lenght
##############################################################################

temp <- artist %>%
     mutate (lungime_nume = nchar(name)) %>%
     arrange(desc(lungime_nume))


##############################################################################
## Să se afișeze numele formatat al artiștilor, conform următoarei cerințe:
## 1. pentru artiștii cu numele lung de până la 10 caractere,
##		se afișează numele întreg
## 2. pentru artiștii cu numele mai lung de 10 caractere se extrag cinci
##  	caractere, se adaugă `...` la mijloc și se finalizează cu
##		ultimele cinci caractere
##############################################################################
## Display the shortened name of the artists with the followihg rules:
## 1. names shorter than 11 characters will be fully displayed
## 2. names longer than 10 characters will be truncated:
##  	extract first 5 characters, concatenate with `...`, and then concatenate
##		with the last 5 characters from the name
##############################################################################

#  `substr` + `substring`
temp <- artist %>%
     mutate (nume_formatat = case_when(
          nchar(name) <= 11 ~ name,
          TRUE ~ paste0(substr(name, 1, 5), '...',
                        substring(name, nchar(name) -4)))
     )

# `substr`
temp <- artist %>%
     mutate (nume_formatat = case_when(
          nchar(name) <= 11 ~ name,
          TRUE ~ paste0(substr(name, 1, 5), '...',
                        substr(name, nchar(name) - 4, nchar(name))))
     )


paste('a', 'b')
paste('a', 'b', 'c', sep = '###')
paste0('a', 'b', 'c')



##############################################################################
##  Care sunt artiștii/formațiile cu numele alcătuit dintr-un singur cuvânt?
##					(adică numele lor nu conține niciun spațiu)
##############################################################################
##  Extract single-word-ed artist names (names containing no white space)
##############################################################################

###
# `regular_expression` (`str_detect`)
temp <- artist %>%
     filter(!str_detect(name, ' '))


# `regular_expression` 1 (`str_detect`) + `if_else`
temp <- artist %>%
     filter( if_else(str_detect(name, ' '), FALSE, TRUE))


# `regular_expression` 2
temp <- artist %>%
     filter( if_else(str_detect(name, ' |/|\\.|\\-'), FALSE, TRUE))


# s`regular_expression` 3 (`str_detect`) + `case_when`
temp <- artist %>%
     filter( case_when (
             str_detect(name, ' ') ~ FALSE,
             TRUE ~ TRUE))


# solutie bazata pe numararea spatiilor / counting the blank spaces
temp <- artist %>%
     mutate (nr_spatii = str_count(name, ' ')) %>%
     filter (nr_spatii == 0)


#... no `mutate`!
temp <- artist %>%
     filter (str_count(name, ' ') == 0)



# echivalent SPLIT_PART din tidyverse vom folosi functia `word`
# in R `word`function does the job of SQL's SPLIT_PART 
temp <- artist %>%
     mutate(
          primul_cuvant = word(name, 1),
          al_doilea_cuvant = word(name, 2)
            ) %>%
     filter (is.na(al_doilea_cuvant))


# `str_replace_all` 
temp <- artist %>%
     filter (name == str_replace_all(name, ' ', ''))

#  `str_remove_all`
temp <- artist %>%
     filter (name == str_remove_all(name, ' '))

#  `str_replace_all` + `nchar``
temp <- artist %>%
     filter (nchar(name) == nchar(str_replace_all(name, ' ', '')))

# `str_remove_all` + `nchar``
temp <- artist %>%
     filter (nchar(name) == nchar(str_remove_all(name, ' ')))



##############################################################################
##      Care sunt artiștii/formatiile cu numele alcătuit din cel puțin
##            două cuvinte? (numele lor conține cel puțin un spațiu)
##############################################################################
## Extract multi-word-ed artist names (names containing at least one whitespace)
##############################################################################


temp <- artist %>%
     filter (str_detect(name, ' '))

# solutie bazata pe numararea spatiilor / counting white spaces
temp <- artist %>%
     filter (str_count(name, ' ') > 0)


#  `word`
temp <- artist %>%
     mutate(
          primul_cuvant = word(name, 1),
          al_doilea_cuvant = word(name, 2)
            ) %>%
     filter (!is.na(al_doilea_cuvant))

temp <- artist %>%
     filter (nchar(name) > nchar(str_replace_all(name, ' ', '')))



##############################################################################
##  Care sunt artiștii/formațiile cu numele alcătuit din exact două cuvinte?
##           (adică numele lor conține un singur spațiu)
##############################################################################
##  Extract two-word-ed artist names (names containing a single whitespace)
##############################################################################

# `str_detect`
temp <- artist %>%
     filter (str_detect(name, ' ') & !str_detect(name, ' .* '))

# `word`
temp <- artist %>%
     mutate(
          primul_cuvant = word(name, 1),
          al_doilea_cuvant = word(name, 2),
          al_treilea_cuvant = word(name, 3)
            ) %>%
     filter (!is.na(al_doilea_cuvant) & is.na(al_treilea_cuvant))


# REPLACE
temp <- artist %>%
     filter (nchar(name) == nchar(str_replace_all(name, ' ', '')) + 1)


# counting spaces...
temp <- artist %>%
     filter (str_count(name, ' ') == 1)



##############################################################################
##           Care sunt primii trei ani s-au inregistrat vanzari?
##############################################################################
##           Extract first sales years
##############################################################################

# sol 1 - `head`
temp <- invoice %>%     # punctul de pornire: tabela/cadrul `invoice`
     transmute (year = lubridate::year(invoicedate)) %>%   #  coloana `year`
     distinct(year) %>%  # se elimina dublurile
     arrange(year)  %>%     # se ordoneaza rezultatul dupa valorile atributului `year`
     head(3)                # echivalentul lui LIMIT 3 din tidyverse


# sol 2 - `tail`
temp <- invoice %>%     # punctul de pornire: tabela/cadrul `invoice`
     transmute (year = lubridate::year(invoicedate)) %>%   #  coloana `year`
     distinct(year) %>%  # se elimina dublurile
     arrange(desc(year))  %>%     # se ordoneaza rezultatul dupa valorile atributului `year`
     tail(3) %>%               # echivalentul lui LIMIT 3 din tidyverse
     arrange(year)


# sol 3 - `slice`
temp <- invoice %>%
     transmute (year = lubridate::year(invoicedate)) %>%
     distinct(year) %>%
     arrange(desc(year))  %>%
     slice((nrow(.)-2):nrow(.)) %>%
     arrange(year)


# sol 4 - `rownum()`
temp <- invoice %>%
     transmute (year = lubridate::year(invoicedate)) %>%
     distinct(year) %>%
     arrange(year) %>%
     filter (row_number() <= 3)



# sol 5 - `top_n`
temp <- invoice %>%
     transmute (year = lubridate::year(invoicedate)) %>%
     distinct(year) %>%
     top_n(-3, year)



##############################################################################
##               Probleme de rezolvat la curs/laborator/acasa
##############################################################################
##               To be completed during lectures/labs or at home
##############################################################################


##############################################################################
## Extrageti numele de utilizator de pe contul de e-mail al fiecarui angajat
##############################################################################
## Extract the usernames from the employees' e-mail addresses
##############################################################################


##############################################################################
##  Extrageti toate serverele de e-mail  (ex. `gmail.com`) ale clientilor
##############################################################################
##  Extract the e-mail servers  (e.g., `gmail.com`) from customers'
##    e-mail addresses
##############################################################################



##############################################################################
##             La ce întrebări răspund următoarele interogări ?
##############################################################################
##          For what requiremens the following queries provide the result?
##############################################################################
