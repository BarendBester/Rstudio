library(tidyverse)

# finding outliers

glimpse(msleep)

iqr <- quantile(msleep$bodywt, 0.75)-quantile(msleep$bodywt, 0.25)
lowerthreshold <- quantile(msleep$bodywt, 0.25)-1.5*iqr
upperthreshold <- quantile(msleep$bodywt, 0.75)+1.5*iqr

outliers <- msleep %>% 
  filter(bodywt < lowerthreshold | bodywt > upperthreshold) %>% 
  select(name, vore, sleep_total, bodywt) %>% 
  
  
view(outliers)

# Calculate total co2_emission per country: emissions_by_country
emissions_by_country <- food_consumption %>%
  group_by(country) %>%
  summarize(total_emission = sum(co2_emission))

# Compute the first and third quartiles and IQR of total_emission
q1 <- quantile(emissions_by_country$total_emission, 0.25)
q3 <- quantile(emissions_by_country$total_emission, 0.75)
iqr <- q3 - q1

# Calculate the lower and upper cutoffs for outliers
lower <- q1 - 1.5 * iqr
upper <- q3 + 1.5 * iqr

# Filter emissions_by_country to find outliers
emissions_by_country %>%
  filter(total_emission<lower | total_emission>upper)