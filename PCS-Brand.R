library(tidyverse)
library(rvest)
library(googlesheets4)
library(googledrive)
library(ggplot2)
library(gganimate)
library(hrbrthemes)
library(viridis)
library(dplyr)
library(gifski)
library(png)
library(ggiraph)
library(ggiraphExtra)
library(gghighlight)



jump <- seq(2000, 2020, by = 1)
site <- paste('https://www.procyclingstats.com/statistics.php?p',
              '=start&s=wins-per-bike-brand&year=',
              jump,
              '&filter=Filter', 
              sep="")

cList <- lapply(site, function(i) {
  webpage <- read_html(i)
  cycle_table <- html_nodes(webpage, 'table')
  cycle <- html_table(cycle_table)[[1]]
})

finaldf <- do.call(rbind, cList)

finaldf %>%
  write.csv("finaldf.csv", row.names = FALSE)


###Write file to google sheets to fill in years, then proceed to continue below############

finaldf_sheet<-read_sheet("https://docs.google.com/spreadsheets/d/12H-aeeOd9xi1Yh7VgemCQeyE59unZ0WiSRhOQfE-LiM/edit#gid=1974564597",   sheet = "finaldf")




finaldf_sheet_n <- subset(finaldf_sheet, Wins >= 25,
                  select=c(`Bike brand`, Wins, Year))

finaldf_sheet_n <-finaldf_sheet[, 1:4]%>%
  group_by(`Year`) %>% 
  arrange(Year, desc(Wins)) %>% 
  filter(Wins > quantile(Wins, .9))


finaldf_sheet_n<-subset(finaldf_sheet_n, Year!=2020)


#animated Plot
f<-finaldf_sheet_n %>%
  ggplot( aes(x=Year, y=Wins, group=`Bike brand`, color=`Bike brand`)) +
  geom_line() +
  geom_point() +
  scale_color_viridis(discrete = TRUE) +
  ggtitle("Cycling wins by bike brand since 2000") +
  ylab("Total Wins") +
  theme_ipsum() +
  transition_reveal(Year)

#static interactive 

my_gg <-ggplot(finaldf_sheet_n, aes(Year, Wins,group = `Bike brand`, colour = `Bike brand`))+
  geom_line_interactive(aes(tooltip = `Bike brand`), size = 1)+
  theme_ipsum()
girafe(code = print(my_gg) )

finaldf_sheet<-subset(finaldf_sheet, Year!=2020)

ggplot(finaldf_sheet) +
  geom_line(aes(x=Year, y=Wins, colour = `Bike brand`)) +
  gghighlight(max(Wins) > 80)+ 
  labs(title = "Cycling wins by bike brand from 2000-2019",
       subtitle = "Data shows brands that have won at least 80 times in any given Year",
       caption="@Sebasp41 | Data: https://www.procyclingstats.com/statistics/start/wins-per-bike-brand")+
  theme_ipsum()
