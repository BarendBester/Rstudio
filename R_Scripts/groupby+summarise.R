library(tidyverse)
library(ggplot2)

view(msleep)
names(msleep)

msleep %>% 
  drop_na(sleep_rem, vore) %>% 
  group_by(vore) %>% 
  summarise('Average total sleep' = mean(sleep_total),
            'Max rem sleep' = max(sleep_rem)) %>% 
  view()

view(AirPassengers)

#create a data frame with 12 columns
air_passengers = data.frame(matrix(AirPassengers,
                                   ncol = 12,
                                   byrow = TRUE,
                                   dimnames = list(as.character(1:12), month.abb))
)
air_passengers$year = as.character(1949:1960)

view(air_passengers)

air_passengers = air_passengers %>% 
  select(year, everything())

max.flights = air_passengers %>% 
  summarise_all(max) %>% 
  view()

max.flights.month = air_passengers %>% 
  summarise_if(is.numeric, max) %>% 
  view()











