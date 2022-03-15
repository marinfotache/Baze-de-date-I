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
## 		tidyverse00: Importul tabelelor din PostgreSQL
## 		tidyverse00: Data import from PostgreSQL
##############################################################################
## ultima actualizare / last update: 2022-03-15

#install.packages('tidyverse')
library(tidyverse)


## clear the memory
rm(list = ls())

# install.packages('RPostgres')
library(RPostgres)

###  A. Open a connection (after loading the package and the driver)

## On Windows systems, PostgreSQL database service must already be started
con <- dbConnect(RPostgres::Postgres(), dbname="chinook", user="postgres", 
                 host = 'localhost', password="postgres")

# On Mac OS
con <- dbConnect(RPostgres::Postgres(), host='localhost', port='5434', 
                 dbname='chinook', user='postgres', password='postgres')



###  B. Display the table names in PostgreSQL database 

tables <- dbGetQuery(con, 
     "select table_name from information_schema.tables where table_schema = 'public'")
tables


###  C. Import each PostgreSQL table as a data frame in R
for (i in 1:nrow(tables)) {
     # extragrea tabelei din BD PostgreSQL
     temp <- dbGetQuery(con, paste("select * from ", tables[i,1], sep=""))
     # crearea dataframe-ului
     assign(tables[i,1], temp)
}


###  D. Close PostgreSQL connection
for (connection in dbListConnections(drv) ) {
    dbDisconnect(connection)
}

### Remove objects (other than the data frames)
rm(con, drv, temp, i, tables)


# Save all the data frames in a single .RData file
setwd('/Users/marinfotache/Downloads/chinook')
save.image(file = 'chinook.RData')

