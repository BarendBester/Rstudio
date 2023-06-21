install.packages("tidyverse")
installed.packages("lubridate")
install.packages("nycflights13")

library(tidyverse)
library(lubridate)
library(nycflights13)

view(flights)

# 1. create new columns in count or group by
#counts the flights that are longer than 6 hours

flights.og <- flights %>% 
  mutate(long_flight = (air_time >= 6*60)) %>% 
  view()

flights %>% 
  mutate(long_flight = (air_time >= 6*60)) %>% 
  count(long_flight)

# 2. simplify, count long flights and create flight_path showing which flights and count them
#str_c function combine 2 column 

flights %>% 
  count(flight_path = str_c(origin, "->", dest), sort = TRUE) %>% 
  view()

# 3. Use group by function
# 
flights.by.date <- flights %>% 
  group_by(Date = make_date(year, month, day)) %>% 
  summarise(Number_of_Flights = n(), Average_Flight_Time = median(air_time, na.rm = TRUE)) %>% 
  ungroup()

# Sample and randomly shuffle
# Use slice sample function

Sliced.sample <- flights %>% 
  slice_sample(n=10)

Sliced.sample <- flights %>% 
  slice_sample(prop = 0.01)

#shuffle whole set without slicing with this function
Sliced.sample <- flights %>% 
  slice_sample(prop = 1)

glimpse(Sliced.sample)

#Add sample of rows based on a group
Sliced.sample <- flights %>% 
  group_by(origin) %>% 
  slice_sample(n = 3) %>% 
  ungroup()

flights1 <- flights.og %>% 
  select(year, month, day, origin, dest, carrier, flight, air_time, distance, long_flight) %>% 
  mutate(Date = make_date(year, month, day))
  
# change rows around
a1 <- flights1 %>% 
  select(Date, origin, dest, carrier, flight, air_time, distance, long_flight)

# 4. remove numbers from between strings
# create a mixed column
numbers.1 <- tibble(Numbers_col = c("a3", "d34", "23hg"))

#remove numbers with parse_number function / drops all characters after first numbers
?parse_number
numbers.1 %>%  mutate(Numbers_col = parse_number(Numbers_col))

#selecting columns
flights %>% 
  select(starts_with("dep"), everything(), ends_with("hour"))

# 5.case when to create or change a column when a condition is met

flights %>% 
  select(origin)

flights %>% 
  mutate(origin = case_when(
    origin == "EWR" ~ "Newark International Airport",
    origin == "JFK" ~ "John F. Kennedy International Airport",
    origin == "LGA" ~ "LaGuardia Airport"
  )) %>% 
  count(origin)




#Build more complicated conditional statement

flights %>% 
  mutate(origin = case_when(
    origin == "EWR" & dep_delay > 20 ~ "Newark International Airport - DELAYED",
    origin == "JFK" & dep_delay <= 20 ~ "John F. Kennedy International Airport - ON TIME",
    origin == "LGA" ~ "LaGuardia Airport"
  )) %>% 
  count(origin)


# 6. Use str_replace to find and replace multiple options at once

flights %>% 
  mutate(origin = str_replace_all(origin, c(
    "^EWR$" = "Newark International Airport",
    "^JFK$" = "John F. Kennedy International Airport",
    "^LGA$" = "LaGuardia Airport"
  ))) %>% 
  count(origin)

# 7. Transmute create or change column and keep only specifics

f1a <- flights %>% 
  transmute(date = make_date(year, month, day), 
            tailnum, origin, dest, carrier, distance)


flights.top.carrier <- flights %>% 
  group_by(carrier) %>% 
  filter(n() >= 10000) %>% 
  ungroup()


flights.top.carrier %>% 
  count(carrier, sort = TRUE)

#8 split a string into columns based on a regular expression
view(airlines)

airlines %>% 
  count(name)

split.airlines <- airlines %>%
  extract(
    name,
    into = c("Short name", "Remainder"),
    regex = "^([^\\s]+)(.*)$",
    remove = FALSE
  )
  
view(split.airlines)

# 9.Use semi-join

# create a variable for carriers that start with A

airways.begin.with.a <- airlines %>%
  filter(name %>% str_detect("^A"))
airways.begin.with.a  

#use semi-join to select your specific string

flights %>% 
  semi_join(airways.begin.with.a, by = "carrier") %>% 
  count(carrier)

#Use anti-join to do the opposite
flights %>% 
  anti_join(airways.begin.with.a, by = "carrier") %>% 
  count(carrier)

glimpse(flights)
view(flights)

#join by carrier flights and airlines
flights.with.airline.names <- flights %>% 
  left_join(airlines, by = "carrier")

#create barplot

flights.with.airline.names %>% 
  count(name) %>% 
  ggplot(aes(name,n))+
  geom_col()

# 10. use factory reorder to order the count
flights.with.airline.names %>% 
  count(name) %>% 
  mutate(name = fct_reorder(name,n)) %>% 
  ggplot(aes(name, n))+
  geom_col()+
  coord_flip()+ # 11. coordflip to better display counts
  theme_bw()+
  labs(title = "Airline flights from New york",
       subtitle = "Count of number of flights",
       x = "Number of flights",
       y = "Name of the Flight company",
       caption = "Source: Nycflights13")


# 12 factor lump

flights.with.airline.names %>% 
  mutate(name = fct_lump(name, n=5)) %>% 
  count(name) %>% 
  mutate(name = fct_reorder(name, n)) %>% 
  ggplot(aes(name, n))+
  geom_col()+
  coord_fixed()

# 13 create a function that 
# summaries specific shit you need

col_summary <- function(data, col_names, na.rm = TRUE){
  data %>% 
    summarise(across({{col_names}},
                     list(
                        min = min,
                        max = max,
                        median = median,
                        mean = mean,
                          ),
                     na.rm = n.rm,
                     .names = "{col}_{fn}"))}


flights.with.airline.names %>% 
  col_summary(c(air_time, arr_delay))
  