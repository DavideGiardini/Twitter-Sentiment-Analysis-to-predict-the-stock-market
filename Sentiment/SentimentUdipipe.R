setwd("./lemmatized data")

library(dplyr)
options(dplyr.summarise.inform = FALSE)
library(tm)
library(stringr)
library(udpipe)


marche <- c("ZAL", "NESN", "NVAX", "BAYN", "BYND", "GE")

# Apertura dizionari e intensificatori
load("./modifiers.rdata")


for (i in marche) {
  # Open lemmatized data
  addr <- paste("lemm", i, sep = "_")
  addr <- paste(addr, "RData", sep = ".")
  addr <- paste(".", addr, sep = "/")
  load(addr)
  
  # sentiment computation
  sentUOp <- txt_sentiment(lemmCV,term = "lemma",
                           polarity_terms = dOpenR_EN,
                           polarity_negators = polarityShifter_EN,
                           polarity_amplifiers = intensifier_EN,
                           polarity_deamplifiers = weakener_EN)
  
  # Building polG
  polG <- as.data.frame(sentUOp$overall$sentiment_polarity)
  colnames(polG) <- "sentiment"
  polG$text <- tw$text
  polG$created_at <- tw$created_at
  
  # Building tabpolG
  tabpolG <- polG %>%
    group_by(as.Date(created_at)) %>%
    summarise(n.tweet = n(), score=sum(sentiment))
  
  # Saving
  addr_s <- paste("sent", i, sep = "_")
  addr_s <- paste(addr_s, "RData", sep = ".")
  addr_s <- paste("./Sentiment UdPipe", addr_s, sep = "/")
  save(polG, tabpolG, file = addr_s)
  
}
