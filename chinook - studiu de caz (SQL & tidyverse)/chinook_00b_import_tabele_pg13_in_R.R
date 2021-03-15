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
### 


############################################################################
# # --  Pas 2. Importati fiecare fisier `.csv` ca un `data frame` 

# nu e este nevoie de niciu pas aditional, intrucat 
















#setwd('D:/chinook')
setwd('/Users/marinfotache/Downloads/chinook')
getwd()

# salvare
save.image(file = 'chinook.RData')

# stergerea tuturor obiectelor din sesiunea curenta R
rm(list = ls())

