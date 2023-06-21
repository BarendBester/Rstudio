library(tidyverse)
library(ggplot2)
view(quakes)
head(quakes)
view(volcano)
head(volcano)

install.packages("sf")
library(sf)
(nc = read_sf(system.file("gpkg/nc.gpkg", package = "sf")))
view(nc)

names(nc)
#SID74 = sudden instant death
SID74_plot <- nc %>% 
  ggplot(aes(fill = SID74))+
  geom_sf()
SID74_plot

install.packages("stars")
library(stars)
(L7 = read_stars(system.file("tif/L7_ETMs.tif", package = "stars")))


ggplot(data = L7)+
  geom_stars()+
  facet_wrap(~band)+
  coord_equal()
stars.plot
























