library(tidyverse)
library(ggplot2)
head(iris)

view(mtcars)
#adding level to text
#adding labels with geom_text

a1 <- mtcars
a1 %>% 
  ggplot(aes(wt, mpg))+
  geom_point()+
  geom_text(label=rownames(a1),
            nudge_x = 0.25,
            nudge_y = 0.25,
            check_overlap = T)

#adding labels with geomlabel

a2 <- mtcars
a2 %>% 
  ggplot(aes(wt, mpg))+
  geom_point()+
  geom_label(label=rownames(a2),
             nudge_x = 0.50,
             nudge_y = 0.70)

install.packages("hrbrthemes")
library(hrbrthemes)
install.packages("viridis")
library(viridis)


