library(gsheet)
library(dplyr)

url <- 'https://docs.google.com/spreadsheets/d/1GJ2UqiCCBY1d1FkKW1SxDGDOReTwarB3_h1FGwr_pl8/edit?usp=sharing'
race <- gsheet2tbl(url)

d17url<-'https://docs.google.com/spreadsheets/d/191LhkDE1w05q2Eo7n6tEmNSiZg3xjtK5tMM-KZBMXQw/edit?usp=sharing'
d17 <- gsheet2tbl(d17url)


race$date <- as.Date(race$date, "%Y-%m-%d")

race_17f<-subset(race, date> "2016-12-31" & date < "2018-01-01")

race_17f_data<-race_17f %>% 
  group_by(race) %>%
  tally()

race_glm_data[7,1]<-"Null"