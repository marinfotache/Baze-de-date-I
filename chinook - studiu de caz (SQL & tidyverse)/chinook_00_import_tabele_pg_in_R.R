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
## ultima actualizare / last update: 2023-12-01

#install.packages('tidyverse')
library(tidyverse)


## clear the memory
rm(list = ls())

# install.packages('RPostgres')
library(RPostgres)


##   `chinook` database is already created on your system! if not, 
## in pgAdmin (or other PostgreSQL client) your have to create it and 
##    run the script `02 Chinook_PostgreSql 2017.sql`


###  A. Open a connection (after loading the package and the driver)

## On Windows systems, PostgreSQL database service must already be started
con <- dbConnect(RPostgres::Postgres(), dbname="chinook", user="postgres", 
                 host = 'localhost', password="postgres")

# On Mac OS

con <- dbConnect(RPostgres::Postgres(), host='localhost', port='5435', 
                 dbname='ucll', user='postgres', password='postgres')



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



### Remove objects (other than the data frames)
rm(con, temp, i, tables)


# Save all the data frames in a single .RData file (change the default directory according to your system)
setwd('/Users/marinfotache/Downloads/chinook')
save.image(file = 'chinook.RData')

