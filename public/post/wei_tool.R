library(rvest)
library(tidyr)
library(tidyverse)
library(dplyr)
library(DT)
library(kableExtra)
library(knitr)


brefski<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_f=Y&pos_is_fg=Y&pos_is_fc=Y&pos_is_c=Y&pos_is_cf=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&order_by=pts_per_g"
brefski1<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=100"
brefski2<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=200"
brefski3<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=300"
brefski4<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=400"
brefski5<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=500"
brefski6<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=600"
brefski7<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=700"
brefski8<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=800"
brefski9<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=900"
brefski10<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=1000"
brefski11<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=1100"
brefski12<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=1200"
brefski13<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=1300"
brefski14<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=1400"
brefski15<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=1500"
brefski16<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=1600"
brefski17<-"https://www.sports-reference.com/cbb/play-index/psl_finder.cgi?request=1&match=single&year_min=2019&year_max=2019&conf_id=&school_id=&class_is_fr=Y&class_is_so=Y&class_is_jr=Y&class_is_sr=Y&pos_is_g=Y&pos_is_gf=Y&pos_is_fg=Y&pos_is_f=Y&pos_is_fc=Y&pos_is_cf=Y&pos_is_c=Y&games_type=A&qual=pts_per_g&c1stat=off_rtg&c1comp=gt&c1val=&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&order_by=pts_per_g&order_by_asc=&offset=1700"




brcape <- brefski %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape <- brcape[[1]]
colnames(brcape) = brcape[1, ]
brcape = brcape[-1, ]

brcape1 <- brefski1 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape1 <- brcape1[[1]]
colnames(brcape1) = brcape1[1, ]
brcape1 = brcape1[-1, ]

brcape2 <- brefski2 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape2 <- brcape2[[1]]
colnames(brcape2) = brcape2[1, ]
brcape2 = brcape2[-1, ]

brcape3 <- brefski3 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape3 <- brcape3[[1]]
colnames(brcape3) = brcape3[1, ]
brcape3 = brcape3[-1, ]

brcape4 <- brefski4 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape4 <- brcape4[[1]]
colnames(brcape4) = brcape4[1, ]
brcape4 = brcape4[-1, ]

brcape5 <- brefski5 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape5 <- brcape5[[1]]
colnames(brcape5) = brcape5[1, ]
brcape5 = brcape5[-1, ]

brcape6 <- brefski6 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape6 <- brcape6[[1]]
colnames(brcape6) = brcape6[1, ]
brcape6 = brcape6[-1, ]

brcape7 <- brefski7 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape7 <- brcape7[[1]]
colnames(brcape7) = brcape7[1, ]
brcape7 = brcape7[-1, ]

brcape8 <- brefski8 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape8 <- brcape8[[1]]
colnames(brcape8) = brcape8[1, ]
brcape8 = brcape8[-1, ]

brcape9 <- brefski9 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape9 <- brcape9[[1]]
colnames(brcape9) = brcape9[1, ]
brcape9 = brcape9[-1, ]

brcape10 <- brefski10 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape10 <- brcape10[[1]]
colnames(brcape10) = brcape10[1, ]
brcape10 = brcape10[-1, ]

brcape11 <- brefski11 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape11 <- brcape11[[1]]
colnames(brcape11) = brcape11[1, ]
brcape11 = brcape11[-1, ]

brcape12 <- brefski12 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape12 <- brcape12[[1]]
colnames(brcape12) = brcape12[1, ]
brcape12 = brcape12[-1, ]

brcape13 <- brefski13 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape13 <- brcape13[[1]]
colnames(brcape13) = brcape13[1, ]
brcape13 = brcape13[-1, ]

brcape14 <- brefski14 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape14 <- brcape14[[1]]
colnames(brcape14) = brcape14[1, ]
brcape14 = brcape14[-1, ]

brcape15 <- brefski15 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape15 <- brcape15[[1]]
colnames(brcape15) = brcape15[1, ]
brcape15 = brcape15[-1, ]

brcape16 <- brefski16 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape16 <- brcape16[[1]]
colnames(brcape16) = brcape16[1, ]
brcape16 = brcape16[-1, ]

brcape17 <- brefski17 %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="stats"]') %>%
  html_table()
brcape17 <- brcape17[[1]]
colnames(brcape17) = brcape17[1, ]
brcape17 = brcape17[-1, ]

#top 60
url<-"https://www.nbadraft.net/ranking/bigboard"
mfl <- url %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="content-area"]/div/table') %>%
  html_table()
mfl <- mfl[[1]]
mlf<-mfl[,3:6]
mlf$Pos<-sub("/.*", "", mlf$Pos)
#column changer
cols_to_change = c(8:47)
for(i in cols_to_change){class(brcape[, i]) = "numeric"}
for(i in cols_to_change){class(brcape1[, i]) = "numeric"}
for(i in cols_to_change){class(brcape2[, i]) = "numeric"}
for(i in cols_to_change){class(brcape3[, i]) = "numeric"}
for(i in cols_to_change){class(brcape4[, i]) = "numeric"}
for(i in cols_to_change){class(brcape5[, i]) = "numeric"}
for(i in cols_to_change){class(brcape6[, i]) = "numeric"}
for(i in cols_to_change){class(brcape7[, i]) = "numeric"}
for(i in cols_to_change){class(brcape8[, i]) = "numeric"}
for(i in cols_to_change){class(brcape9[, i]) = "numeric"}
for(i in cols_to_change){class(brcape10[, i]) = "numeric"}
for(i in cols_to_change){class(brcape11[, i]) = "numeric"}
for(i in cols_to_change){class(brcape12[, i]) = "numeric"}
for(i in cols_to_change){class(brcape13[, i]) = "numeric"}
for(i in cols_to_change){class(brcape14[, i]) = "numeric"}
for(i in cols_to_change){class(brcape15[, i]) = "numeric"}
for(i in cols_to_change){class(brcape16[, i]) = "numeric"}
for(i in cols_to_change){class(brcape17[, i]) = "numeric"}

#appender
brcapeall <- rbind(brcape, brcape1, brcape2,brcape3,brcape4, brcape5, brcape6,brcape7,brcape8,brcape9,
                   brcape10, brcape11, brcape12,brcape13,brcape14, brcape15, brcape16,brcape17)
final<-brcapeall %>% drop_na()
#table cleaning
final$`AST/TOV`<-final$AST/final$TOV
final$ASB<-final$AST+final$STL+final$BLK
final$RSB<-final$TRB+final$STL+final$BLK
final$SB<-final$STL+final$BLK
final$`2PFG%`<-final$`2P`/final$`2PA`
final$`3PFG%`<-final$`3P`/final$`3PA`

final1<-final[final$Player %in% mlf$Player,]

final2<- final1[, c("Player","FGA","2PFG%","3PFG%","PTS","AST","TRB","STL","BLK","ASB","RSB","SB","AST/TOV","ORtg")]
final2<-final2 %>% mutate_if(is.numeric, ~round(., 2))


final3<-merge(final2, mlf, by="Player")
final3<-final3[,c(1,17,15,16,2:14)]

finalpg<-subset(final3, Pos=="PG")
  finalpg1 <- subset(finalpg, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, AST, STL, RSB, `AST/TOV`, ORtg))
finalsg<-subset(final3, Pos=="SG")
  finalsg1 <- subset(finalsg, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, STL, RSB, `AST/TOV`, ORtg))
finalsf<-subset(final3, Pos=="SF")
  finalsf1 <- subset(finalsf, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, AST, ASB, `AST/TOV`, ORtg))
finalpf<-subset(final3, Pos=="PF")
  finalpf1 <- subset(finalpf, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, TRB, SB, `AST/TOV`, ORtg))
finalc<-subset(final3, Pos=="C")
  finalc1 <- subset(finalc, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, TRB, BLK, `AST/TOV`, ORtg))


#conditional formatting breaks and clears
#datatables
datatable(finalpg1) %>% formatStyle('FGA',options = list(pageLength = 20), color = styleInterval(c(10, 13), c("#FF0000","#FFD700","#1E9600")))%>% 
  formatStyle('2PFG%', color = styleInterval(c(.35, .5), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('3PFG%', color = styleInterval(c(.3, .35), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('PTS', color = styleInterval(c(16, 18), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('AST', color = styleInterval(c(3, 5), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('STL', color = styleInterval(c(1, 1.2), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('RSB', color = styleInterval(c(4, 6), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('AST/TOV', color = styleInterval(c(1.4, 1.6), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('ORtg', color = styleInterval(c(108, 112), c("#FF0000","#FFD700","#1E9600")))

datatable(finalsg1) %>% formatStyle('FGA',options = list(pageLength = 20), color = styleInterval(c(10, 13), c("#FF0000","#FFD700","#1E9600")))%>% 
  formatStyle('2PFG%', color = styleInterval(c(.35, .5), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('3PFG%', color = styleInterval(c(.3, .35), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('PTS', color = styleInterval(c(18, 20), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('STL', color = styleInterval(c(1.1, 1.3), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('RSB', color = styleInterval(c(5, 7), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('AST/TOV', color = styleInterval(c(1.2, 1.4), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('ORtg', color = styleInterval(c(108, 112), c("#FF0000","#FFD700","#1E9600")))

datatable(finalsf1) %>% formatStyle('FGA',options = list(pageLength = 20), color = styleInterval(c(10, 13), c("#FF0000","#FFD700","#1E9600")))%>% 
  formatStyle('2PFG%', color = styleInterval(c(.35, .5), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('3PFG%', color = styleInterval(c(.3, .35), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('PTS', color = styleInterval(c(16, 18), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('ASB', color = styleInterval(c(3, 5), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('AST/TOV', color = styleInterval(c(.4, .6), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('ORtg', color = styleInterval(c(108, 112), c("#FF0000","#FFD700","#1E9600")))

datatable(finalpf1) %>% formatStyle('FGA', options = list(pageLength = 20), color = styleInterval(c(10, 13), c("#FF0000","#FFD700","#1E9600")))%>% 
  formatStyle('2PFG%', color = styleInterval(c(.53, .58), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('3PFG%', color = styleInterval(c(.275, .325), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('PTS', color = styleInterval(c(16, 18), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('TRB', color = styleInterval(c(8, 10), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('SB', color = styleInterval(c(1.5, 3.5), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('AST/TOV', color = styleInterval(c(.4, .6), c("#FF0000","#FFD700","#1E9600"))) %>%
  formatStyle('ORtg', color = styleInterval(c(108, 112), c("#FF0000","#FFD700","#1E9600")))

datatable(finalc1) %>% formatStyle('FGA', options = list(pageLength = 20), color = styleInterval(c(10, 13), c("#FF0091","#000000","#1B00FF")))%>% 
  formatStyle('2PFG%', color = styleInterval(c(.55, .60), c("#FF0091","#000000","#1B00FF"))) %>%
  formatStyle('3PFG%', color = styleInterval(c(.275, .325), c("#FF0091","#000000","#1B00FF"))) %>%
  formatStyle('PTS', color = styleInterval(c(16, 18), c("#FF0091","#000000","#1B00FF"))) %>%
  formatStyle('TRB', color = styleInterval(c(8, 10), c("#FF0091","#000000","#1B00FF"))) %>%
  formatStyle('BLK', color = styleInterval(c(2, 3), c("#FF0091","#000000","#1B00FF"))) %>%
  formatStyle('AST/TOV', color = styleInterval(c(.4, .6), c("#FF0091","#000000","#1B00FF"))) %>%
  formatStyle('ORtg', color = styleInterval(c(108, 112), c("#FF0091","#000000","#1B00FF")))

#kable tables!!!
options(knitr.table.format = "html") 

finalpg1<-finalpg1[order(-finalpg1$ORtg),]

finalpg1 %>%
  mutate(
    FGA = cell_spec(FGA, "html", color = ifelse(FGA >13, "green", "red")),
    `2PFG%` = cell_spec(`2PFG%`, "html", color = ifelse(`2PFG%` >.5, "green", "red")),
    `3PFG%` = cell_spec(`3PFG%`, "html", color = ifelse(`3PFG%` >.35, "green", "red")),
    PTS = cell_spec(PTS, "html", color = ifelse(PTS >18, "green", "red")),
    AST = cell_spec(AST, "html", color = ifelse(AST >5, "green", "red")),
    STL = cell_spec(STL, "html", color = ifelse(STL >1.2, "green", "red")),
    RSB = cell_spec(RSB, "html", color = ifelse(RSB >6, "green", "red")),
    `AST/TOV` = cell_spec(`AST/TOV`, "html", color = ifelse(`AST/TOV` >1.6, "green", "red")),
    ORtg = cell_spec(ORtg, "html", color = ifelse(ORtg >110, "green", "red"))
 )%>%
  select(Player,FGA,`2PFG%`,`3PFG%`, PTS, AST,STL,RSB,`AST/TOV`,ORtg)%>%
  kable(format = "html", escape = F)%>%
  kable_styling(full_width = F)

