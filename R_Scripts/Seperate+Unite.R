library(tidyverse)
library(ggplot2)
library(gapminder)

view(gapminder)

# How separate and unite work
gapminder1 <- gapminder %>% 
  separate(col = year,
           into = c("century", "year"),
           sep = 2) %>% 
  view()
 
gapminder1 %>% 
  unite(col = date,
        century, year,
        sep = "") %>% 
  view()
