# -- 		Interogari `tidyverse` vs SQL - BD Chinook (IE si SPE)
# --
# -- 01: Filtrare simpla, regular expressions, structuri CASE
# --
# -- ultima actualizare: 2019-04-14
# 
#install.packages('tidyverse')
library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Google Drive/Baze de date 2019/Studii de caz/chinook')
load("chinook.RData")


############################################################################ 
# # --                   In ce ani s-au inregistrat vanzari?
############################################################################ 

# # -- SQL
# # -- prima notatie pentru ordonare (specificarea expresiei de calcul a atributului de ordonare)
# # select distinct extract (year from invoicedate) as an
# # from invoice
# # order by extract (year from invoicedate)
# # 
# # -- a doua notatie pentru ordonare (specificarea atributului (calculat) de ordonare)
# # select distinct extract (year from invoicedate) as an
# # from invoice
# # order by an
# # 
# # -- a treia notatie pentru ordonare (specificarea pozitiei in rezultat a atributului de ordonare)
# # select distinct extract (year from invoicedate) as an
# # from invoice
# # order by 1
# # 


###
### tidyverse
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

# # -- SQL
# # select distinct extract (year from invoicedate) as an,
# # 	extract (month from invoicedate) as luna
# # from invoice
# # order by 1,2
# # 
# # 

###
### tidyverse
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

# # -- SQL
# # select artist.*, length(name) as lungime_nume
# # from artist
# # 

###
### tidyverse
### 
artist %>%
     mutate (lungime_nume = nchar(name)) -> temp 


############################################################################ 
# # -- Sa se afiseze artistii in ordinea descrescatoare a lungimii numelui
############################################################################ 

# # -- SQL
# # select artist.*, length(name) as lungime_nume
# # from artist
# # order by length(name) desc 
# #
 
###
### tidyverse
### 
temp <- artist %>%
     mutate (lungime_nume = nchar(name)) %>%
     arrange(desc(lungime_nume))


# # 
############################################################################ 
# # -- Sa se afiseze numele formatat al artistilor, conform urmatoarei cerinte:
# # -- 1. pentru artistii cu numele lung de pana la 11 caractere, se afiseaza numele intreg
# # -- 2. pentru artistii cu numele mai lung de 11 caracterese se extrag cinci 
# # --   caractere, se adauga `...` la mijloc si se finalizeaza cu ultimele cinci caractere
############################################################################ 

# # -- SQL
# # -- solutie bazata pe LEFT si RIGHT
# # select artist.*, 
# # 	case 
# # 		when length(name) <= 11 then name
# # 		else left(name, 5) || '...' || right(name, 5)
# # 	end as nume_formatat,  
# # 	length(name) as lungime_nume
# # from artist
# # 
# # -- solutie bazata pe SUBSTRING
# # select artist.*, 
# # 	case 
# # 		when length(name) <= 11 then name
# # 		else substring(name, 1, 5) || '...' || 
# # 			substring(name, length(name)-4, length(name))
# # 		end as nume_formatat,  
# # 	length(name) as lungime_nume
# # from artist
# # 

###
### tidyverse
### 

# -- solutia bazata pe LEFT si RIGHT nu are echivalent in R 

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
# # -- Care sunt artistii sau formatiile cu numele alcatuit dintr-un singur cuvant ?
# # -- (adica numele nu contine niciun spatiu)
############################################################################ 

# # 
# # -- SQL
# # -- solutie bazata pe operatorul `LIKE`
# # select *
# # from artist
# # where name not like '% %'
# # 
# # -- solutie bazata pe operatorii `LIKE` si CASE
# # select *
# # from artist
# # where case when name like '% %' then false else true end 
# # 
# # -- soluție cu POSITION
# # SELECT *
# # FROM artist
# # WHERE POSITION(' ' IN NAME) = 0
# # 
# # -- soluție cu SPLIT_PART
# # SELECT *, 
# # 	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
# # 	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant
# # FROM artist
# # WHERE SPLIT_PART(name, ' ', 2) = ''
# # 
# # -- prima soluție cu REPLACE
# # SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii
# # FROM artist
# # WHERE name = REPLACE(name, ' ', '')
# # 
# # -- a doua soluție cu REPLACE
# # SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
# # 	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
# # FROM artist
# # WHERE LENGTH(name) = LENGTH(REPLACE(name, ' ', ''))
# # 
# # 

###
### tidyverse
### 
# solutie bazata pe `regular_expression` (`str_detect`)
temp <- artist %>%
     filter(!str_detect(name, ' '))


# solutie bazata pe `regular_expression` (`str_detect`) si `if_else`
temp <- artist %>%
     filter( if_else(str_detect(name, ' '), FALSE, TRUE))

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
# # -- Care sunt artistii sau formatiile cu numele alcatuit din cel putin doua cuvinte ?
# # -- (adica numele contine cel putin singur spatiu)
############################################################################ 

# # 
# # -- SQL
# # -- solutie bazata pe operatorul `LIKE`
# # select *
# # from artist
# # where name like '% %' 
# # 
# # -- soluție cu POSITION
# # SELECT *, POSITION(' ' IN NAME)
# # FROM artist
# # WHERE POSITION(' ' IN NAME) > 0 
# # 
# # -- soluție cu SPLIT_PART
# # SELECT *, 
# # 	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
# # 	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant
# # FROM artist
# # WHERE SPLIT_PART(name, ' ', 2) <> ''
# # 
# # -- soluție cu REPLACE
# # SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
# # 	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
# # FROM artist
# # WHERE LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) > 0
# # 

###
### tidyverse
### 

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

# # 
# # -- SQL
# # -- solutie bazata pe operatorul `LIKE`
# # select *
# # from artist
# # where name like '% %' and name not like '% % %'
# # 
# # -- soluție cu SPLIT_PART
# # SELECT *, 
# # 	SPLIT_PART(name, ' ', 1) AS primul_cuvant,
# # 	SPLIT_PART(name, ' ', 2) AS al_doilea_cuvant,
# # 	SPLIT_PART(name, ' ', 3) AS al_treilea_cuvant
# # FROM artist
# # WHERE SPLIT_PART(name, ' ', 2) <> '' and SPLIT_PART(name, ' ', 3) = ''
# # 
# # -- soluție cu REPLACE
# # SELECT *, REPLACE(name, ' ', '') AS nume_fara_spatii,
# # 	LENGTH(name), LENGTH(REPLACE(name, ' ', ''))
# # FROM artist
# # WHERE LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 1
# # 
# # 

###
### tidyverse
### 

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
# -- 						Probleme de rezolvat la curs/laborator/acasa
# -- ############################################################################ 
# 
# -- Extrageti numele de utilizator de pe contul de e-mail al fiecarui angajat
# 
# -- Extrageti toate serverele de e-mail  (ex. `gmail.com`) ale clientilor
# 
# -- Care sunt piesele formatiei `Led Zeppelin` compuse de cel putin trei muzicieni?
# 
# -- Care sunt piesele formatiei `Led Zeppelin` compuse (si) de `John Bonham`
# 
# -- Care sunt piesele formatiei `Led Zeppelin` compuse numai de `Robert Plant`
# 
# -- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
# --  `Jimmy Page`, cu sau fara alti colegi/muzicieni?
# 
# -- Care sunt piesele formatiei `Led Zeppelin` compuse, impreuna, de `Robert Plant` si
# --  `Jimmy Page`, fara alti colegi/muzicieni?
# 
# -- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
# --	`Robert Plant` 
# 
# -- Care sunt piesele formatiei `Led Zeppelin` la care, printre compozitori, nu apare
# --	nici `Robert Plant`, nici `Jimmy Page` 
# 
# 
