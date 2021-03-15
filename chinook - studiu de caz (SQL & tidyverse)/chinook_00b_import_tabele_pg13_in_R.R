################################################################################
###           Interogari `tidyverse` vs SQL - BD Chinook (IE si SPE)
################################################################################
# -- ultima actualizare: 2021-02-13

#install.packages('tidyverse')
library(tidyverse)


############################################################################
# # --          Importul tabelelor din PostgreSQL 13
############################################################################
## curatare sesiune curenta
rm(list = ls())



############################################################################
# # --    Pas 1: Exportati fiecare din table din Pg13 ca fisier `.csv`
### vezi tutorialul video de la adresa 
### https://1drv.ms/u/s!AgPvmBEDzTOSit5mOwPM5StvNvJHRg?e=fNlvHu


############################################################################
# # --  Pas 2. Importati fiecare fisier `.csv` ca un `data frame` 

# setam directorul curent pe folderul in care se afla fisierele `.csv`
setwd('/Users/marinfotache/Downloads/chinook')


# nu e este nevoie de niciun pachet aditional, intrucat citirea
#  fisierelor `.csv` o facem cu pachetul `readr` care e parte din tidyverse

artist <- read_csv('artist.csv')
album <- read_csv('album.csv')
genre <- read_csv('genre.csv')
mediatype <- read_csv('mediatype.csv')
playlist <- read_csv('playlist.csv')
track <- read_csv('track.csv')
playlisttrack <- read_csv('playlisttrack.csv')
employee <- read_csv('employee.csv')
customer <- read_csv('customer.csv')
invoice <- read_csv('invoice.csv')
invoiceline <- read_csv('invoiceline.csv')



############################################################################
# # --  Pas 3. Salvam toate cadrele de date (data frame) ca un singur 
#                         fisier `.rdata`

# este valabila si solutia `save.image...`, insa vom folosi comanda `save...`

# salvare
save(artist, album, genre, mediatype, playlist, track, playlisttrack, 
     employee, customer, invoice, invoiceline, 
     file = 'chinook2.RData')

# stergerea tuturor obiectelor din sesiunea curenta R
rm(list = ls())

