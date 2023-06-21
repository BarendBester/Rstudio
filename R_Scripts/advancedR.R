library(tidyverse)

head(lynx)
view(lynx)

hist(lynx)

hist(lynx,
     breaks =  14,
     freq = FALSE,
     col = "thistle1",
     main = paste0("Histogram of Annual Canadian Lynx",
                   "Trappings, 1821-1934"),
     xlab = "Number of Lynx Trapped")

curve(dnorm(x, mean = mean(lynx), sd = sd(lynx) ),
      col = "thistle4",
      lwd = 2,
      add = TRUE)
lines(density(lynx), col = "blue3", lwd = 2)

# counts/frequencies for categorical  
# quart-tiles and mean for quantitative variables

head(iris)

summary(iris$Species)
summary(iris$Sepal.Length)
summary(iris)

install.packages("pacman")
library(pacman)
p_load(psych)
p_help(psych, web = F)

describe(iris$Sepal.Length) #one quantitative variable
describe(iris)

# Cases

hist(iris$Petal.Length)
summary(iris$Petal.Length)
summary(iris$Species)

n1 <- 15 #double
typeof(n1)






