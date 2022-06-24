# imposto cartella di lavoro
setwd("./1. Lemmatized data")

library(dplyr)
library(ggplot2)
library(tm)
library(syuzhet)

marche <- c("AAPL","GOOGL", "NKE", "NESN", "NVAX", "BAYN", "BYND")
for (i in marche){
  # Open the lemmatized data
  addr <- paste("lemm", i, sep = "_")
  addr <- paste(addr, "RData", sep = ".")
  addr <- paste(".", addr, sep = "/")
  load(addr)
  
  # Sentiment with function get_sentiment
  sentS <- get_sentiment(tw$txtLL)
  polG <- as.data.frame(sentS)
  polG$text <- tw$text
  polG$created_at <- tw$created_at
  polG$day <- as.Date(tw$created_at)
  # Building a table with the info we need
  tabpolG <- polG %>%
    group_by(day) %>%
    summarise(n.tweet = n(), score=sum(sentS))
  tabpolG
  
  # Saving
  addr_s <- paste("sent", i, sep = "_")
  addr_s <- paste(addr_s, "RData", sep = ".")
  addr_s <- paste(".", addr_s, sep = "/")
  save(polG, tabpolG, file = addr_s)
  rm(polG, tabpolG, tw, txtLemV)
}

# sentiment su tweet giornali con metodo syuzhet e dizionario nrc italiano corretto

