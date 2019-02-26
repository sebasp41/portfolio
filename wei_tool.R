library(rvest)
library(tidyr)
library(tidyverse)
library(dplyr)
library(DT)
library(kableExtra)
library(knitr)
#assigning urls to vars
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
#proper scraping of each url, translating into dataframes
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
#scrape and reorganization of nbadraft bigboard
url<-"https://www.nbadraft.net/ranking/bigboard"
mfl <- url %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="content-area"]/div/table') %>%
  html_table()
mfl <- mfl[[1]]
mlf<-mfl[,3:6]
mlf$Pos<-sub("/.*", "", mlf$Pos)
#convert columns from scrapes into numeric
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
#appending dataframe of each scrape into one data frame
brcapeall <- rbind(brcape, brcape1, brcape2,brcape3,brcape4, brcape5, brcape6,brcape7,brcape8,brcape9,
                   brcape10, brcape11, brcape12,brcape13,brcape14, brcape15, brcape16,brcape17)
#dropping all players that have an NA / dropping extra, unneeded rows
final<-brcapeall %>% drop_na()
#Required maths for necessary stats
#Assist to Turnover ratio, per game
final$`AST/TOV`<-final$AST/final$TOV
#Assists + Steals + Blocks
final$ASB<-final$AST+final$STL+final$BLK
#Rebounds + Steals + Blocks
final$RSB<-final$TRB+final$STL+final$BLK
#Steals + Blocks
final$SB<-final$STL+final$BLK
#two point field goal percentage
final$`2PFG%`<-final$`2P`/final$`2PA`
#three point field goal percentage
final$`3PFG%`<-final$`3P`/final$`3PA`
#finding players in final from scraped nbadraft.net list
final1<-final[final$Player %in% mlf$Player,]
#selecting necessary columns needed
final2<- final1[, c("Player","FGA","2PFG%","3PFG%","PTS","AST","TRB","STL","BLK","ASB","RSB","SB","AST/TOV","ORtg")]
#rounding to 2 decimal places
final2<-final2 %>% mutate_if(is.numeric, ~round(., 2))
#merging nbadraft list and final2 by Player
final3<-merge(final2, mlf, by="Player")
#reordering columns
final3<-final3[,c(1,17,15,16,2:14)]
#creating tables for each position
finalpg<-subset(final3, Pos=="PG")
  finalpg1 <- subset(finalpg, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, AST, STL, RSB, `AST/TOV`, ORtg))
finalsg<-subset(final3, Pos=="SG")
  finalsg1 <- subset(finalsg, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, STL, RSB, `AST/TOV`, ORtg))
finalsf<-subset(final3, Pos=="SF")
  finalsf1 <- subset(finalsf, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, ASB, `AST/TOV`, ORtg))
finalpf<-subset(final3, Pos=="PF")
  finalpf1 <- subset(finalpf, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, TRB, SB, `AST/TOV`, ORtg))
finalc<-subset(final3, Pos=="C")
  finalc1 <- subset(finalc, select=c(Player, FGA, `2PFG%`,`3PFG%`, PTS, TRB, BLK, `AST/TOV`, ORtg))
##sort each table by ORtg, descending####
finalpg1<-finalpg1[order(-finalpg1$ORtg),]
finalsg1<-finalsg1[order(-finalsg1$ORtg),]
finalsf1<-finalsf1[order(-finalsf1$ORtg),]
finalpf1<-finalpf1[order(-finalpf1$ORtg),]
finalc1<-finalc1[order(-finalc1$ORtg),]
##csv writing and reading for md page####
write.csv(finalpg1, "/Users/sebastianpycior/sebasportfolio/content/post/fpg1.csv")
write.csv(finalsg1, "/Users/sebastianpycior/sebasportfolio/content/post/fsg1.csv")
write.csv(finalsf1, "/Users/sebastianpycior/sebasportfolio/content/post/fsf1.csv")
write.csv(finalpf1, "/Users/sebastianpycior/sebasportfolio/content/post/fpf1.csv")
write.csv(finalc1, "/Users/sebastianpycior/sebasportfolio/content/post/fc1.csv")
fpg1<-read.csv("/Users/sebastianpycior/sebasportfolio/content/post/fpg1.csv")
fsg1<-read.csv("/Users/sebastianpycior/sebasportfolio/content/post/fsg1.csv")
fsf1<-read.csv("/Users/sebastianpycior/sebasportfolio/content/post/fsf1.csv")
fpf1<-read.csv("/Users/sebastianpycior/sebasportfolio/content/post/fpf1.csv")
fc1<-read.csv("/Users/sebastianpycior/sebasportfolio/content/post/fc1.csv")
##Renaming the columns for each pos####
fpg1o = c("Player", "FGA", "X2PFG.","X3PFG.", "PTS", "AST","STL","RSB", "AST.TOV", "ORtg")
fpg1n = c("Player", "FGA", "2FG%","3FG%", "PTS", "AST","STL","RSB", "A:T", "ORtg")
fsg1o = c("Player", "FGA", "X2PFG.","X3PFG.","PTS","STL","RSB", "AST.TOV", "ORtg")
fsg1n = c("Player", "FGA", "2FG%","3FG%", "PTS","STL","RSB", "A:T", "ORtg")
fsf1o = c("Player", "FGA", "X2PFG.","X3PFG.", "PTS", "ASB","AST.TOV","ORtg")
fsf1n = c("Player", "FGA", "2FG%","3FG%", "PTS", "ASB","A:T", "ORtg")
fpf1o = c("Player", "FGA", "X2PFG.","X3PFG.", "PTS", "TRB", "SB", "AST.TOV", "ORtg")
fpf1n = c("Player", "FGA", "2FG%","3FG%", "PTS","TRB", "SB", "A:T", "ORtg")
fc1o = c("Player", "FGA", "X2PFG.","X3PFG.", "PTS", "TRB", "BLK", "AST.TOV", "ORtg")
fc1n = c("Player", "FGA", "2FG%","3FG%", "PTS", "TRB","BLK", "A:T", "ORtg")
fpg1 %>% rename_at(vars(fpg1o), ~ fpg1n)
fsg1 %>% rename_at(vars(fsg1o), ~ fsg1n)
fsf1 %>% rename_at(vars(fsf1o), ~ fsf1n)
fpf1 %>% rename_at(vars(fpf1o), ~ fpf1n)
fc1 %>% rename_at(vars(fc1o), ~ fc1n)
#dropping first columns of each table
fpg1 <- fpg1[,-1,drop=FALSE]
fsg1 <- fsg1[,-1,drop=FALSE]
fsf1 <- fsf1[,-1,drop=FALSE]
fpf1 <- fpf1[,-1,drop=FALSE]
fc1 <- fc1[,-1,drop=FALSE]
#writing final csvs
write.csv(fpg1, "/Users/sebastianpycior/sebasportfolio/content/post/fpg2.csv")
write.csv(fsg1, "/Users/sebastianpycior/sebasportfolio/content/post/fsg2.csv")
write.csv(fsf1, "/Users/sebastianpycior/sebasportfolio/content/post/fsf2.csv")
write.csv(fpf1, "/Users/sebastianpycior/sebasportfolio/content/post/fpf2.csv")
write.csv(fc1, "/Users/sebastianpycior/sebasportfolio/content/post/fc2.csv")