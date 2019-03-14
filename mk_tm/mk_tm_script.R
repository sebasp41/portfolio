library(rvest)
library(tidyverse)
library(stringr)
library(text2vec)
library(tm)
library(tidytext)
library(SnowballC)
library(topicmodels)
library(gofastr)
library(RColorBrewer)
library(wordcloud)
library(reshape2)

mkurl<-read_html("http://gutenberg.net.au/ebooks02/0200601.txt")

mk_text<-mkurl %>%
  html_nodes(xpath = "/html/body/pre") %>%
  html_text()

mk_text_clean<-str_replace_all(mk_text, "[\r\n]" , "")
mk_corpus<-Corpus(VectorSource(mk_text_clean))

mk_dtm <- DocumentTermMatrix(mk_corpus, control = list(minWordLength = 3));
mk_dtm_2 <- tidy(mk_dtm)
mk_dtm_2$term <- gsub("\"", "", mk_dtm_2$term)
mk_dtm_2$term <- gsub("\'", "", mk_dtm_2$term)
mk_dtm_2$term <- gsub(",","",mk_dtm_2$term)
mk_dtm_2$term <- gsub(";","",mk_dtm_2$term)
mk_dtm_2$term <- gsub("-","",mk_dtm_2$term)
mk_dtm_2$term <- gsub("?","",mk_dtm_2$term)
mk_dtm_2$term <- gsub("\\.","",mk_dtm_2$term)
mk_dtm_2$term <- gsub("'s","",mk_dtm_2$term)

mk_dtm_3 <- mk_dtm_2 %>%
  anti_join(stop_words, by = c(term="word"))


##Word clouds#####
wordcloud(words = mk_dtm_3$term,freq = mk_dtm_3$count, min.freq = 50,colors=brewer.pal(8, "Dark2"))
mk_dtm_3 <- mk_dtm_3[order(-mk_dtm_3$count),] 

mk_sent %>%
  count(term, sentiment, sort = TRUE) %>%
  acast(term ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = brewer.pal(4, "Dark2"),
                   max.words = 700)
#frequencies####
barplot(mk_dtm_3[1:20,]$count, las = 2, names.arg = mk_dtm_3[1:20,]$term,
        col ="lightblue", main ="Most frequent words",
        ylab = "Word frequencies")


#topic modelling#####



mk_top_terms <- mk_dtm_3 %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

mk_top_terms %>%
  mutate(term = reorder(term, beta)) %>%
  ggplot(aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()




###Sentiment Analysis####
mk_sent <- mk_dtm_3 %>%
  inner_join(get_sentiments("bing"), by = c(term = "word"))

mk_sent %>%
  count(sentiment, term, wt = count) %>%
  ungroup() %>%
  filter(n >= 30) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(term = reorder(term, n)) %>%
  ggplot(aes(term, n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  ylab("Contribution to sentiment") +
  coord_flip()

