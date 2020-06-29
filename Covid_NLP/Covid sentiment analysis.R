
#  Install Requried Packages
#installed.packages("SnowballC")
#installed.packages("tm")
#installed.packages("twitteR")
#installed.packages("syuzhet")


library("NLP")
library("twitteR")
library("syuzhet")
library("tm")
library("SnowballC")
library("stringi")
library("topicmodels")
library("syuzhet")
library("ROAuth")
library("ggplot2")
library("base64enc")

packages <- c("twitteR", "openssl")
### checking if packages are already installed and installing if not
for(i in packages){
  if(!(i %in% installed.packages()[, "Package"])){
    install.packages(i)
  }
  library(i, character.only = TRUE) ## load packages
}


## Twitter API credentials
consumer_key <- ''
consumer_secret <- ''
access_token <- ''
access_secret <- ''
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

## Get tweets with covid_19 hastag
tweets_covid <- searchTwitter("#covid_19", n=5000,lang = "en")

#Write dataframe into an Excel file for analysis
library(xlsx)
write.xlsx(tweets_covid, "filePath", sheetName="Sheet1", col.names=TRUE, row.names=TRUE, append=FALSE)

## Convert tweets to dataframe
covid_tweets <- twListToDF(tweets_covid)
### Extract tweet as text
covid_text<- covid_tweets$text

## Preprocess text
### Convert all text to lower case
covid_text<- tolower(covid_text)
### Replace blank space (“rt”)
covid_text <- gsub("rt", "", covid_text)
### Replace @UserName
covid_text <- gsub("@\\w+", "", covid_text)
### Remove punctuation
covid_text <- gsub("[[:punct:]]", "", covid_text)
### Remove links
covid_text <- gsub("http\\w+", "", covid_text)
### Remove tabs
covid_text <- gsub("[ |\t]{2,}", "", covid_text)
### Remove blank spaces at the beginning
covid_text <- gsub("^ ", "", covid_text)
### Remove blank spaces at the end
covid_text <- gsub(" $", "", covid_text)
### Remove carriage returns and new lines
covid_text <- gsub("[\r\n]", "", covid_text)
### Remove stop words
stopWords <- stopwords("en")
covid_text <- unlist(covid_text)[!(unlist(covid_text) %in% stopWords)]



## Senitment Analysis
mysentiment_covid <- get_nrc_sentiment((covid_text))

Sentimentscores_covid <-data.frame(colSums(mysentiment_covid[,]))


ggplot(data=Sentimentscores_covid,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of what people are tweeting about Covid-19")

### Summarise Sentiment to Positive & Negative
positive <- c(0)
negative <- c(0)
for(i in 1:nrow(Sentimentscores_covid)) {
  if(Sentimentscores_covid[i, 1] %in% c('joy', 'trust', 'positive')) {
    positive <- positive + Sentimentscores_covid[i, 2]
  }
  else {
    negative <- negative + Sentimentscores_covid[i, 2]
  }
}

simple_sentiment_covid <- data.frame(sentiments=c("positive", "negative"), scores=c(positive, negative))

ggplot(data=simple_sentiment_covid,aes(x=sentiments,y=scores))+geom_bar(aes(fill=sentiments),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of what people are tweeting about Covid-19")
