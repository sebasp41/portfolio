library(tidyverse)
library(stringr)
library(tidytext)
library(tidyr)
library(ggplot2)
library(devtools)
library(dplyr)
library(quanteda)
library(stm)
library(scales)


mein_kampf_raw<- read.delim("/Users/sebastianpycior/sebasportfolio/mk_tm/mein.txt")
colnames(mein_kampf_raw)[colnames(mein_kampf_raw)=="MEIN.KAMPF"] <- "text"
mein_kampf_tibble<-as_tibble(mein_kampf_raw)


mein_kampf <- mein_kampf_tibble %>%
  mutate(story = ifelse(str_detect(text, "CHAPTER"),
                        text,
                        NA)) %>%
  fill(story) %>%
  filter(story != "MEIN KAMPF") %>%
  mutate(story = factor(story, levels = unique(story)))
##renaming factors#######
levels(mein_kampf$story)[levels(mein_kampf$story)=="3767"] <- "CHAPTER I    IN THE HOME OF MY PARENTS"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3768"] <- "CHAPTER II   YEARS OF STUDY AND SUFFERING IN VIENNA"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3769"] <- "CHAPTER III  POLITICAL REFLECTIONS ARISING OUT OF MY SOJOURN IN VIENNA"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3770"] <- "CHAPTER IV   MUNICH"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3771"] <- "CHAPTER V    THE WORLD WAR"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3772"] <- "CHAPTER VI   WAR PROPAGANDA"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3773"] <- "CHAPTER VII  THE REVOLUTION"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3774"] <- "CHAPTER VIII THE BEGINNING OF MY POLITICAL ACTIVITIES"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3775"] <- "CHAPTER IX   THE GERMAN LABOUR PARTY"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3776"] <- "CHAPTER X    WHY THE SECOND REICH COLLAPSED"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3777"] <- "CHAPTER XI   RACE AND PEOPLE"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3778"] <- "CHAPTER XII  THE FIRST STAGE IN THE DEVELOPMENT OF THE GERMAN NATIONAL SOCIALIST LABOUR PARTY"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3779"] <- "CHAPTER XIII    WELTANSCHAUUNG AND PARTY"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3780"] <- "CHAPTER XIV   THE STATE"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3781"] <- "CHAPTER XV  CITIZENS AND SUBJECTS OF THE STATE"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3782"] <- "CHAPTER XVI   PERSONALITY AND THE IDEAL OF THE PEOPLE`S STATE"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3783"] <- "CHAPTER XVII    WELTANSCHAUUNG AND ORGANIZATION"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3784"] <- "CHAPTER XVIII   THE FIRST PERIOD OF OUR STRUGGLE"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3785"] <- "CHAPTER XIV  THE CONFLICT WITH THE RED FORCES"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3786"] <- "CHAPTER XX THE STRONG IS STRONGEST WHEN ALONE"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3787"] <- "CHAPTER XXI   FUNDAMENTAL IDEAS REGARDING THE NATURE AND ORGANIZATION OF THE STORM TROOPS"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3788"] <- "CHAPTER XXII   THE MASK OF FEDERALISM"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3789"] <- "CHAPTER XXIII   PROPAGANDA AND ORGANIZATION"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3790"] <- "CHAPTER XXIV  THE PROBLEM OF THE TRADE UNIONS"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3791"] <- "CHAPTER XXV THE GERMAN POST-WAR POLICY OF ALLIANCES"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3792"] <- "CHAPTER XXVI  GERMANY'S POLICY IN EASTERN EUROPES"
levels(mein_kampf$story)[levels(mein_kampf$story)=="3793"] <- "CHAPTER XXVII   THE RIGHT TO SELF-DEFENCE"

write.table(mein_kampf, file = "mein_kampf_curated.txt", sep = "\t", row.names = FALSE)

mkc<-read.table("mein_kampf_curated.txt", header = TRUE, stringsAsFactors = FALSE)
mkc$story <- as.factor(mkc$story)


mkc<-as_tibble(mkc)

mkc_common <- c("german", "germany","people")

tidy_mkc <- mkc %>%
  mutate(line = row_number()) %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)%>%
  filter(!word %in% mkc_common)

#tf_idf####
mkc_tf_idf <- tidy_mkc %>%
  count(story, word, sort = TRUE) %>%
  bind_tf_idf(word, story, n) %>%
  arrange(-tf_idf) %>%
  group_by(story) %>%
  top_n(10) %>%
  ungroup

mkc_tf_idf %>%
  mutate(word = reorder_within(word, tf_idf, story)) %>%
  ggplot(aes(word, tf_idf, fill = story)) +
  geom_col(alpha = 0.8, show.legend = FALSE) +
  facet_wrap(~ story, scales = "free", ncol = 3) +
  scale_x_reordered() +
  coord_flip() +
  theme(strip.text=element_text(size=11)) +
  labs(x = NULL, y = "tf-idf",
       title = "Highest tf-idf words in Mein Kampf chapters",
       subtitle = "Chapter level focus on fascist elements")

#real topic modelling####

mkc_dfm <- tidy_mkc %>%
  count(story, word, sort = TRUE) %>%
  cast_dfm(story, word, n)

mkc_sparse <- tidy_mkc %>%
  count(story, word, sort = TRUE) %>%
  cast_sparse(story, word, n)

mkc_topic_model <- stm(mkc_dfm, K = 10, 
                   verbose = FALSE, init.type = "Spectral")

mkc_beta <- tidy(mkc_topic_model)

mkc_beta %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  mutate(topic = paste0("Topic ", topic),
         term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(term, beta, fill = as.factor(topic))) +
  geom_col(alpha = 0.8, show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free_y") +
  coord_flip() +
  scale_x_reordered() +
  labs(x = NULL, y = expression(beta),
       title = "Highest word probabilities for each topic",
       subtitle = "Different words are associated with different topics")

mkc_gamma <- tidy(mkc_topic_model, matrix = "gamma",                    
                 document_names = rownames(mkc_dfm))

ggplot(mkc_gamma, aes(gamma, fill = as.factor(topic))) +
  geom_histogram(alpha = 0.8, show.legend = FALSE) +
  facet_wrap(~ topic, ncol = 3) +
  labs(title = "Distribution of document probabilities for each topic",
       subtitle = " ",
       y = "Number of Chapters", x = expression(gamma))

mkc_gamma %>% 
  mutate(document = factor(document, levels = rev(unique(document)))) %>%
  group_by(document) %>%
  top_n(1) %>%
  ungroup %>%
  ggplot(aes(document, gamma, label = document, fill = as.factor(topic))) +
  geom_col() +
  geom_text(aes(document, 0.01), hjust = 0,
            color = "white", size = 2.5) +
  scale_y_continuous(expand = c(0,0),
                     labels = percent_format()) +
  coord_flip() +
  theme_minimal() +
  theme(axis.text.y=element_blank()) +
  labs(x = NULL, y = expression(gamma), fill = "Topic")
