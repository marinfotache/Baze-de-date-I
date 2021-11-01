


############################################################################
##             Afisati, pentru fiecare client, pe coloane separate,
##                vanzarile pe anii 2010, 2011 si 2012 (reluare)
############################################################################


temp <- customer %>%
     transmute (customer_name = paste(lastname, firstname),
                city, state, country, customerid) %>%
     inner_join(
          invoice %>%
               filter (year(invoicedate) %in% c(2010, 2011, 2012)) %>%
               group_by(customerid, year = year(invoicedate)) %>%
               summarise(sales = sum(total)) %>%
               ungroup()
     ) %>%
     select(-customerid) %>%
     arrange(customer_name, year) %>%
     pivot_wider(names_from = year, values_from = sales)



