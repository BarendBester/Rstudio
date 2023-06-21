library(tidyverse)
library(ggplot2)

view(ToothGrowth)

theme_set(theme_bw()+theme(panel.grid.major = element_blank()))

ToothGrowth %>% 
  filter(supp == "VC") %>% 
  mutate(dose = as.factor(dose)) %>% 
  group_by(dose) %>%
  summarise(mean_len = mean(len),
            sd_len = sd(len)) %>% 
  ggplot(aes(dose, mean_len))+
  geom_point(size = 3,
             colour = "blue")+
  geom_errorbar(aes(dose,
                    ymin = mean_len - sd_len,
                    ymax = mean_len + sd_len,
                    width = 0.05))+
  labs(title = "Average tooth growth for VC sump")+
  xlab("Dose")+
  ylab("Average tooth growth")

ToothGrowth %>% 
  filter(supp == "VC") %>% 
  mutate(dose = as.factor(dose)) %>% 
  group_by(dose) %>%
  summarise(mean_len = mean(len),
            sd_len = sd(len)) %>% 
  ggplot(aes(dose, mean_len))+
  geom_bar(stat = "identity",
           fill = "skyblue",
           alpha = 0.7)+
  geom_errorbar(aes(dose,
                    ymin = mean_len - sd_len,
                    ymax = mean_len + sd_len,
                    width = 0.05))+
  labs(title = "Average tooth growth for VC sump")+
  xlab("Dose")+
  ylab("Average tooth growth")

  