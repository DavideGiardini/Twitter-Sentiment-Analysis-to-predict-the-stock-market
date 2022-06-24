source(file = "C:/Users/david/OneDrive/Uni/Tesi/Risorse/search_strings.R")
library(rtweet)
library(httr)
library(ggplot2)
library(gmailr)
require(scales)

twitter_token <- create_token(app = app_name,
                              consumer_key = API_key,
                              consumer_secret = API_secret_key,
                              access_token = Access_token,
                              access_secret = Access_token_secret)

headers = c(`Authorization` = sprintf('Bearer %s', Bearer_token))

count_down <- c()
count_tot <- c()
beg_down <- c()
end_down <- c()

for (i in marche) {
  # Rebuilding the name of yesterday's file based on today's date
  name_t <- paste(i, Sys.Date()-1, "csv", sep=".")
  address_t <- paste("C:/Users/david/OneDrive - Alma Mater Studiorum Università di Bologna/Tesi/DataFrames/Tweets", i, name_t, sep= "/")
  # Open yesterday's file and read the id from the last tweet that yesterday's code has downloaded
  tab <- read.csv(address_t)
  id <- sub('.','',tab[1,2])
  # Write the name of the vector as a string
  terms <- paste("str", i, sep="_")
  # Trasform the string into an obj
  terms <- eval(parse(text=terms))
  # Search
  tweets <- search_tweets(terms, n=6000, lang="en", type = "recent", include_rts = F)
  # Building the name of today's file
  name_t <- paste(i, Sys.Date(), "csv", sep=".")
  address_t <- paste("C:/Users/david/OneDrive/Uni/Tesi/DataFrames/Tweets", i, name_t, sep= "/")
  #Writing today's file
  write_as_csv(tweets, address_t)
  # Saving for the mail
  count_down[i] <- nrow(tweets)
  beg_down[i] <- min(tweets$created_at)
  end_down[i] <- max(tweets$created_at)
  
  # Wait 15 minutes for Twitter API count to reload
  if(i=="NKE"){
    Sys.sleep(60*15)
  }
  
}
