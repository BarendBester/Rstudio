library(tidyverse)
library(ggplot2)
install.packages("cowplot")

EUvax <- read.csv("C:/Users/beatr/Documents/Rstudio/EUvaccine.csv")
view(EUvax)

mapdata <- map_data("world")

view(mapdata)

mapdata <- left_join(mapdata, EUvax, by="region")
view(mapdata)

#remove/filter out data that has NA for percentage vaccinated
mapdata1 <- mapdata %>% 
  filter(!is.na(mapdata$Perc_vaccinated))
view(mapdata1)


map1 <- mapdata1 %>% 
  ggplot(aes(long, lat, group=group))+
  geom_polygon(aes(fill=Perc_vaccinated), color="black")
  
map1

map2 <- map1 + scale_fill_gradient(name= "% vaccinated",
                                   low = "yellow",
                                   high = "red",
                                   na.value = "grey50")+
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks =element_blank(),
        axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        rect = element_blank())
map2

library(cowplot)
install.packages("magick")
library(magick)

ggdraw()+
  draw_image("C:/Users/beatr/Documents/Rstudio/vaccine.jpg", x=0.4, y=0.4, scale = .2)+
  draw_plot(map2)


install.packages("maps")
install.packages("mapproj")

library(maps)
library(mapproj)

world_tbl <- map_data("world")

# Draw a world map with geom-polygon

map3a <- world_tbl %>% 
  ggplot(aes(long,lat, group=group))+
  geom_polygon()
  

map3a

#Draw a world map with geom-map

map3b <- world_tbl %>% 
  ggplot() +
  geom_map(aes(long, lat, map_id = region),
           map=world_tbl,
           colour="grey80", size=0.3)
map3b

map3b + coord_map("ortho", orientation = c(39, -98, 0))


#Make a map of USA 


USA_tbl <- map_data("state")

USA_map <- USA_tbl %>% 
  ggplot(aes(long, lat, map_id=region))+
  geom_map(map = USA_tbl,
           colour = "grey80",
           fill="grey30", size=0.3)+
  coord_map("ortho", orientation = c(39, -98, 0))



install.packages("sf")
install.packages("rnaturalearth")
install.packages("countrycode")
install.packages("ggrepel")

library(tidyverse)
library(sf)
library(rnaturalearth)
library(countrycode)
library(ggrepel)


world <- ne_countries(scale = "small", returnclass = "sf")

world %>% 
  ggplot()+
  geom_sf()

#st_transform to change projection
#examples "+proj=moll", "+proj=aeqd", "+proj=goode"

world %>% 
  st_transform(crs = "+proj=robin") %>% 
  ggplot()+
  geom_sf()+
  theme_minimal()










