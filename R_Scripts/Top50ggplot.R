install.packages("ggExtra")

library(tidyverse)
library(ggplot2)
library(ggExtra)

theme_set(theme_bw())

?mpg

#too see the relationship and distribution 
#of data use a marginal histogram and box plot, scatter plot density plot.

fuelstat <- mpg[mpg$hwy >= 35 & mpg$cty > 27, ]

g <- mpg %>% 
  ggplot(aes(cty, hwy))+
  geom_count()+
  geom_smooth(method = "lm", se=F)+
  labs(title = "The relationship between cars milage",
       subtitle = "city vs highway milage",
       x="Count of city milage",
       y="Count of highway milage",
       caption = "Source: mpg")

ggMarginal(g, type = "histogram", fill = "transparent")

ggMarginal(g, type = "boxplot", fill = "transparent")
ggMarginal(g, type = "density", fill = "transparent")

g1 <- ggMarginal(g, type = "histogram", fill = "transparent")


#Correl-gram

#multiple continues variables
#The correlation coefficient, r, tells us about the strength and direction of the linear relationship between x and y. 
#However, the reliability of the linear model also depends on how many observed data points are in the sample
# We need to look at both the value of the correlation coefficient r and the sample size n, together. We perform a hypothesis
#test of the "significance of the correlation coefficient" to decide whether the linear relationship in the sample
#data is strong enough to use to model the relationship in the population



install.packages("ggcorrplot")
library(ggcorrplot)

corplot <- round(cor(mtcars), 1)

ggcorrplot(corplot, hc.order = TRUE,
           type = "lower",
           lab = TRUE,
           lab_size =  4,
           method = "circle",
           colors = c("tomato2", "white", "springgreen3"),
           title = "Correlogram of mtcars",
           ggtheme = theme_bw())


#Diverging bar chart = use geom-bar
#Geom-bar is for bar-charts + histograms
#Geom-bar uses stat set to count as default if just x variable = histogram
#Thus to make a diverging bar set stat=identity + provide x+y with x character or factor and y numeric

#Make sure categorical variable has 2 categories.

data(mtcars)
view(mtcars)
mtcars$`car name`<- rownames(mtcars) #create a new column for car names



#1. Preperation

#create a normalized value for mpg 
# this indicates the range of data and how it lies on a plot.
mtcars$mpg_z <- round(mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg, 2) #Z-score = (x - μ) / σ

#create categorical value row mpg_type by using if else below and above zero.
mtcars$mpg_type <- ifelse(mtcars$mpg_z < 0, "below", "above")
#sort the table 
mtcars <- mtcars[order(mtcars$mpg_z), ]
#convert to factor to retain sorted order
mtcars$`car name` <- factor(mtcars$`car name`, levels = mtcars$`car name`)


#2. Draw diverging bar chart

diverging_barplot <- mtcars %>% 
  ggplot(aes(`car name`, mpg_z, label=mpg_z))+
  geom_bar(stat='identity', aes(fill=mpg_type), width = .5)+
  scale_fill_manual(name="Milaege",
                    labels= c("Above Average", "Below Average"),
                    values = c("above"="#00ba38", "below"="#f8766d"))+
  labs(subtitle = "Normalised milaege from mtcars",
       title = "Diverging bars")+
  coord_flip()
diverging_barplot
