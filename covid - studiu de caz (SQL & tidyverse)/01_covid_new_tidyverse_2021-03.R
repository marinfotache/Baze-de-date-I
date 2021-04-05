#######################################################################
###       calcularea situatiei zilnice a testelor, cazurilor etc.
#######################################################################


library(tidyverse)
library(lubridate)

setwd('/Users/marinfotache/Downloads/covid')
load('data14_2021-03-27.RData')

# calcularea situatiei zilnice a testelor, cazurilor etc.
covid_new <- covid %>%
        arrange(country_code, report_date) %>%
        group_by(country_code) %>%
        mutate (
                tests_prev_day = coalesce(lag(tests, 1), 0),
                confirmed_prev_day = coalesce(lag(confirmed, 1), 0),
                recovered_prev_day = coalesce(lag(recovered, 1), 0),
                deaths_prev_day = coalesce(lag(deaths, 1), 0),
                hosp_prev_day = coalesce(lag(hosp, 1), 0),
                vent_prev_day = coalesce(lag(vent, 1), 0)
          ) %>%
        ungroup() %>%
        select(country_code, report_date, tests, tests_prev_day,    
                confirmed, confirmed_prev_day, recovered, recovered_prev_day, 
                deaths, deaths_prev_day, hosp, hosp_prev_day, 
                vent, vent_prev_day, 
               cancel_events:stringency_index
        )
