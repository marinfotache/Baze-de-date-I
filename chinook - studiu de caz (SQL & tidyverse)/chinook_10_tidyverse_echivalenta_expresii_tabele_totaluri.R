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
## 		tidyverse10: Soluții echivalente expresiilor tabele din SQL
## 		tidyverse10: Equivalent solutions to SQL common table expressions (CTE)
##############################################################################
## ultima actualizare / last update: 2022-03-15


library(tidyverse)
library(lubridate)
setwd('/Users/marinfotache/Downloads/chinook')
load("chinook.RData")


###
###
###  logica `tidyverse` nu se pliaza pe expresii tabela; toate solutiile SQL din scriptul
###   `chinook_10_sql_expresii_tabele.sql` au echivalente in precedentele scripturi `tidyverse`:
###   `chinook_08_tidyverse_subconsultari_in_where_si_having.R`
###   `chinook_09_tidyverse_subconsultari_in_from_si_select.R`
###
