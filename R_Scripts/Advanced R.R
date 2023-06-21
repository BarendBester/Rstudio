# Nested Data
# Data frames in Data frames
library(gapminder)
library(dplyr)
library(purrr)
library(tidyr)
library(ggplot2)
library(tidyverse)

new_gapminder <- gapminder %>% 
  mutate(year1950 = year - 1950) %>% 
  view()



by_country$data[[1]]

# means <- vector("double", ncol(mtcars))
# for(i in seq_along(mtcars)) {
#  means[[i]] <- mean(mtcars[[i]], na.rm = TRUE)}


# funs <- list(mean, median, sd)
# funs %>% 
#  map(~mtcars %>% map_dbl(.x))

new_gapminder
country_model <- function(df){
  lm(lifeExp ~ year1950, data = df)
}

by_country <- new_gapminder %>% 
  group_by(continent, country) %>% 
  nest() %>% 
  mutate(mod = data %>% map(country_model))

models <- by_country %>% 
  mutate(model = data %>% map(country_model))
models

models %>%  filter(continent == "Africa")




















