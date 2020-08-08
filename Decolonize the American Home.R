library(tidyverse)
library(googlesheets4)
library(treemapify)

histtab16<-read_sheet("https://docs.google.com/spreadsheets/d/16HMnUiaiVIQyoJDCMFOmZlP8BtMMYjdBQWPi4RNedHE/edit#gid=1389327224",   sheet = "Sheet1")
sqft_race<-read_sheet("https://docs.google.com/spreadsheets/d/16HMnUiaiVIQyoJDCMFOmZlP8BtMMYjdBQWPi4RNedHE/edit#gid=1389327224",   sheet = "Sheet3")
race_type<-read_sheet("https://docs.google.com/spreadsheets/d/16HMnUiaiVIQyoJDCMFOmZlP8BtMMYjdBQWPi4RNedHE/edit#gid=1389327224",   sheet = "Sheet4")
house_total<-read_sheet("https://docs.google.com/spreadsheets/d/16HMnUiaiVIQyoJDCMFOmZlP8BtMMYjdBQWPi4RNedHE/edit#gid=1389327224",   sheet = "Sheet5")


decolonize_home<-read_sheet("https://docs.google.com/spreadsheets/d/19nv23xC_vF9rWTwHLoxfRMajHOzrwVMhmyWGsLn9-hY/edit#gid=0",   sheet = "decolonize_home")

#homeownership rate
ggplot(histtab16,aes(x=`Year and Quarter`))+
  geom_line(aes(y =`Non-Hispanic White Alone`), color="blue")+
  geom_line(aes(y =`Black Alone`))+
  geom_line(aes(y =`Hispanic (of any race)`), color="brown")+
  geom_line(aes(y =`Asian, Native Hawaiian and Pacific Islander Alone2`), color="turquoise")+
  labs(title = "Homeownership Rates by Race and Ethnicity 
       of Householder: 1994 to Present",
       x = "Year",
       y= "Percent",
       subtitle = "Blue - White; Turquoise - Asian; Brown - Hispanic; Black - Black",
       caption = "Visual: @Sebasp41 | Data: https://www.census.gov/housing/hvs/data/histtabs.html - Table 16")+
  theme_ipsum()

#squarefootage by race
ggplot(sqft_race, aes(area = Sqft,fill=`Homeownership Rate`, label = Race_sqft, subgroup = Sqft)) +
  geom_treemap() +
  labs(title = "2010 Home square footage by race",
       subtitle = "Estimated as Population x Homeownership Rate x Median US home sqft",
       caption = "Visual: @Sebasp41 | Data: https://www.census.gov/housing/hvs/data/histtabs.html")+
  geom_treemap_text(colour = "white", place = "centre",
                    grow = FALSE)+
  geom_treemap_subgroup_border(color = "white", size = 2)+
  theme_ipsum()

#geom_bar race difference to achieve White rate

ggplot(race_type, aes(fill=factor(Type, levels=c("New Homeowners to achieve White Rate","Current Homeowners", "Homeownership at White Rate")), y=Totals, x=Race)) + 
  geom_bar(position="dodge", stat="identity")+
  labs(title = "What # of new non-White homeowners is needed 
       to achieve the White rate of homeownership?",
       subtitle = "Using data from 2010",
    caption = "Visual: @Sebasp41 | Data: https://www.census.gov/housing/hvs/data/histtabs.html",
    fill = "Type")+
  geom_text(aes(y=Totals, x=Race, label = scales::comma(round(Totals, 0))), position = position_dodge(width = 1), hjust = -.25)+
  scale_y_continuous(labels = scales::comma, expand =c(.24,1))+
  theme_ipsum()+
  coord_flip()+
  theme(legend.position="bottom")

#vacancies in 2010

#house_total <- data.frame("Total" = 17223646, "Homeowners in waiting" = sum(10059540,1859660,9506091))
#house_total$Behind<-house_total$Total-house_total$Homeowners.in.waiting
house_total[3,2]<-4201645


ggplot(house_total, aes(fill=Type,x= reorder(Type, -Total),y=Total)) + 
  geom_bar(position="dodge", stat="identity")+
  labs(title = "Could the US have housed more in 2010?",
       x = "",
       subtitle = "Using data from 2010",
       caption = "Visual: @Sebasp41 | Data: US Census",
       fill = "Type")+
  scale_y_continuous(labels = scales::comma, expand =c(.24,1))+
  theme_ipsum()+
  theme(legend.position="none")
