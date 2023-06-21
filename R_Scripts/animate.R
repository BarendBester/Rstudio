install.packages("gganimate")
install.packages("gapminder")
install.packages("gifski")
install.packages("av")

library(tidyverse)
library(gganimate)
library(gapminder)

animateplot <- gapminder %>% 
  ggplot(aes(gdpPercap, lifeExp, size=pop, frame=year))+
  geom_point()+
  geom_smooth(aes(group=year),
              method = "lm",
              show.legend = FALSE)+
  facet_wrap(~continent, scales = "free")+
  scale_x_log10()

gganimate(animateplot, interval=0.2)
  

iris
names(iris)

p <- ggplot(iris, aes(Petal.Width, Petal.Length))+
  geom_point()
plot(p)

anime <- p + transition_states(Species,
                               transition_length = 2,
                               state_length = 1)
anime

#animated plot

p <- ggplot(gapminder, aes(x = gdpPercap, y=lifeExp, size = pop, colour = country)) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")

p + transition_time(year) + labs(title = "Year: {frame_time}")

view(gapminder)

p <- gapminder %>% 
  ggplot(aes(x = gdpPercap, y=lifeExp, size = pop, colour = continent)) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")

Animateplot <- p + transition_time(year) + labs(title = "Year: {frame_time}")
Animateplot

anim_save("animplot.gif", Animateplot)


graph1 = gapminder %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, color=continent, size=pop)) +
  geom_point(alpha = 0.7, stroke = 0) +
  scale_size(range=c(2,12), guide="none") +
  scale_x_log10() +
  labs(title = "Life Expectancy vs GDP",
       x = "Income",
       y = "Life Expectancy",
       color = "Continent",
       caption = "Source: Gapminder") +
  theme(axis.title = element_text(),
        text = element_text(family = "Rubik"),
        legend.text=element_text(size=10)) +
  scale_color_brewer(palette = "Set2")

graph1.animation = graph1 +
  transition_time(year) +
  labs(subtitle = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.1)

animate(graph1.animation, height = 500, width = 800, fps = 30, duration = 10,
        end_pause = 60, res = 100)
anim_save("gapminder graph.gif")

warming <- read_csv("warming.csv")




