# Andrew Dunn
# data viz to accompany Mehul Gupta's CPR "Inflation Reduction Act's EV tax credits""
# 11.3.2022

# data from page 182
# https://tedb.ornl.gov/wp-content/uploads/2021/02/TEDB_Ed_39.pdf#page=182

library(readxl)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(knitr)


setwd("~/Desktop/CPR/electric vehicle tax credits Nov 2022")

full_df <- read_excel("Hybrid and Plug-In Vehicle Sales.xlsx")

df <- full_df %>%
  select(1, 6:8) %>%
  rename("Year" = "Calendar year", "Hybrid" = "Hybrid share of all light vehicles",
         "Plugin" = "Plug-in hybrid share of all light vehicles", 
         "Electric" = "All-electric share of all light vehicles")

ggplot(df, aes(x = Year, Hybrid)) +
  geom_line(aes(y = Hybrid), color = "darkred") + 
  geom_text(data = df %>% filter(Year == last(Year)), aes(label = "Hybrid", 
                                                               x = Year + 1.3, 
                                                               y = Hybrid) , size = 3) + 
  geom_line(aes(y = Plugin), color = "steelblue") + 
  geom_text(data = df %>% filter(Year == last(Year)), aes(label = "Plug-In", 
                                                          x = Year + 1.3, 
                                                          y = Plugin) , size = 3) +
  geom_line(aes(y = Electric), color = "darkgreen") +
  geom_text(data = df %>% filter(Year == last(Year)), aes(label = "Electric", 
                                                          x = Year + 1.3, 
                                                          y = Electric) , size = 3) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
  labs(x = "Year", 
       y = "Share of All Light Vehicles", 
       title = "Electric Vehicle Share Has Grown Slowly",
       subtitle = "Share of Electric Vehicle Sales Relative to Hybrid and Plug-ins",
       caption = c("\n Source: Transportation Energy Book Data Book, Edition 39 (2021) \n 
                   Author: Andrew Dunn \n 
                   Editor: Zai Rutter \n 
                   Date: Nov 3, 2022"),
       color = 'Committees') +
  theme(plot.title = element_text(hjust = 0.5), panel.grid.minor = element_blank(), 
        panel.grid.major = element_line(color = "azure3"),
        panel.background = element_blank()) 


