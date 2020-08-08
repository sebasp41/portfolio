library(tidyverse)
library(hrbrthemes)
library(googlesheets4)
library(scales)
library(directlabels)
library(dplyr)

cng111_115<-read_sheet("https://docs.google.com/spreadsheets/d/1e-BUZ-mYiXvGmYYNK9M9K25qHS_39R5n0i12fxDE0pU/edit#gid=1613575953",   sheet = "total")

###totals
ggplot(cng111_115, aes(`Congressional Session`, label=HSP))+
  geom_bar(fill = "#44a08d")+
  labs(title= "Count of buildings named per Congressional Session", 
       subtitle = "Label denotes party of House, Senate, and Presidency, respectively.",
       caption = "@Sebasp41")+
  geom_label(stat = 'count',vjust = 2.5) +
theme_ipsum()


#perc of total
cng_sess_tot<-cng111_115 %>% group_by(`Congressional Session`) %>% tally()
cng_sess_tot$total<-c(388,283,296,329,442,139)
cng_sess_tot$perc<-cng_sess_tot$n/cng_sess_tot$total
cng_sess_tot$HSP <- c("DDD","RDD", "RDD","RRD","RRR","DRR")

ggplot(cng_sess_tot,aes(x=`Congressional Session`, y =perc, label=HSP))+
  geom_bar(fill = "#44a08d", stat = "identity")+
  labs(title= "Percent of buildings named out of total things passed in Congress", 
       subtitle = "Label denotes party of House, Senate, and Presidency, respectively.",
       caption = "@Sebasp41")+
  geom_label(stat = 'identity',vjust = 2.5) +
  theme_ipsum()

#day one pace

ggplot(cng111_115, aes(x = Day, y = CumSum, group = `Congressional Session`, colour = `Congressional Session`)) + 
  geom_line() +
  labs(title= "Pace of buildings being named by Congressional Session",
       x="Session Day",
       y="Sum of buildings named",
       caption = "Data: wikipedia")+
  scale_colour_discrete(guide = 'none') +
  geom_dl(aes(label = `Congressional Session`), method = list(dl.combine("last.points"), cex = 0.8))+
  theme_ipsum()

