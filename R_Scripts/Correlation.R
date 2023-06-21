library(tidyverse)

# Understand the relationship between two variables

#Scatterplot

view(midwest)
head(midwest)
glimpse(midwest)

theme_set(theme_bw())

scatter <- midwest


scatter %>% 
  ggplot(aes(area, poptotal))+
  geom_point(aes(colour=state, size=popdensity))+
  geom_smooth(method = "loess", se=F)+
  xlim(c(0, 0.1))+
  ylim(c(0, 500000))+
  labs(subtitle = "Area Vs Population",
       y="Population",
       x="Area",
       title = "Scatterplot",
       caption = "Source: midwest")

install.packages("ggalt")
library(ggalt)

midwestselect <- midwest[midwest$poptotal > 35000 &
                           midwest$poptotal <= 50000 &
                           midwest$area > 0.01 &
                           midwest$area < 0.1,]

scatter1 <- midwest

gg <- ggplot(midwest, aes(area, poptotal))+
  geom_point(aes(col=state, size=popdensity))+
  geom_smooth(method = "loess", se=F)+
  xlim(c(0, 0.1))+
  ylim(c(0, 500000))+
  labs(subtitle = "Area Vs Population",
       y="Population",
       x="Area",
       title = "Scatterplot",
       caption = "Source: midwest")

plot(gg)



gg1 <- ggplot(midwest, aes(area, poptotal))+
  geom_point(aes(col=state, size=popdensity))+
  geom_smooth(method = "loess", se=F)+
  xlim(c(0, 0.1))+
  ylim(c(0, 500000))+
  geom_encircle(aes(area, poptotal),
                data = midwestselect,
                colour = "red",
                size = 2,
                expand = 0.08)+
  labs(subtitle = "Area Vs Population",
       y="Population",
       x="Area",
       title = "Scatterplot",
       caption = "Source: midwest")


plot(gg1)

#simple plot can hide points if overlapping integers

view(mpg)
?mpg

a1 <- ggplot(mpg, aes(cty, hwy))
a1 + geom_point()+
  geom_smooth(method = "lm", se=F)+
  labs(subtitle = "mpg:ncity vs highway milage",
       y="hwy",
       x="cty",
       title = "Scatterplot with overlapping points",
       caption = "Source: mpg")


#Use jitter plot to view these

a1 + geom_jitter(width = 0.5, size = 1)+
  geom_smooth(method = "lm", se=F)+
  labs(subtitle = "mpg:ncity vs highway milage",
       y="hwy",
       x="cty",
       title = "Scatterplot with overlapping points",
       caption = "Source: mpg")

#Or use a counts chart when points overlap the size of the point increases
  
a1 + geom_count(col="tomato3", show.legend = F)+
  labs(subtitle = "mpg: city vs highway milage",
       y="hwy",
       x="cty",
       title = "Scatterplot with overlapping points",
       caption = "Source: mpg")

#bubble chart shows difference in range
#1make select mpg 

mpgselect <- mpg[mpg$manufacturer %in% c("audi", "ford", "honda", "hyundai"),]

bubblechart <- mpg %>% 
  filter(manufacturer %in% c("audi", "ford", "honda", "hyundai"))+
  ggplot(aes(displ, cty))



bubblechart <- mpgselect %>% 
  ggplot(aes(displ, cty, colour=manufacturer))+
  geom_jitter(aes(size=hwy))+
  geom_smooth(method="lm", se=F)+
  labs(subtitle = "Mpg: Displacement vs city milage",
       y="cty",
       x="displ",
       title = "Bubble chart",
       caption = "Source: mpg")


plot(bubblechart)




