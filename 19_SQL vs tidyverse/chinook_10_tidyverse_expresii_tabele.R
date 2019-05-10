# # -- 			 Interogari tidyverse vs SQL - BD Chinook - IE si SPE:
# # --
# # -- 10: Expresii tabele in SQL
# # --
# # -- ultima actualizare: 2019-05-10
# # 

library(tidyverse)
library(lubridate)
setwd('/Users/marinfotache/Google Drive/Baze de date 2019/Studii de caz/chinook')
load("chinook.RData")


###   
###
###  logica `tidyverse` nu se pliaza pe expresii tabela; toate solutiile SQL din scriptul
###   `chinook_10_sql_expresii_tabele.sql` au echivalente in precedentele scripturi `tidyverse`:
###   `chinook_08_tidyverse_subconsultari_in_where_si_having.R`
###   `chinook_09_tidyverse_subconsultari_in_from_si_select.R`
###   
