# clean the place
rm(list=ls())
load("dt2gramsred.Rda")
load("dt3gramsred.Rda")
load("dt4gramsred.Rda")
load("dt5gramsred.Rda")
load("dt6gramsred.Rda")

#transform datasets as datatable
dt2gramsred <- data.table(dt2gramsred)
dt3gramsred <- data.table(dt3gramsred)
dt4gramsred <- data.table(dt4gramsred)
dt5gramsred <- data.table(dt5gramsred)
dt5gramsred <- data.table(dt6gramsred)

## note that max frequency is not required anymore because we
## have reduced the tables to max frequnecies only, if we do not reduce the table we would need
## it as we would have many results

##this prodives the whole line, 
dt2gramsred[base=="a"]#[which.max(frequency)]
## this provides the prediction only
dt2gramsred[base=="glory"]$prediction#[which.max(frequency)]
#Trigram find prediction with word "a_lot"
dt3gramsred[base=="a_lot"]#[which.max(frequency)]


# the function

## the first step is to clean the data

#create a test set
test <- rbind(c("The guy^ 5 ##, in *** front"))
#create function to clean data and trail on test
cleanInput <- function(text){
          textInput <- tolower(text)
          textInput <- removePunctuation(textInput)
          textInput <- removeNumbers(textInput)
          textInput <- str_replace_all(textInput, "[^[:alnum:]]", " ")
          textInput <- stripWhitespace(textInput)
          return(textInput)
}
# log the clean imput 
cleantest <- cleanInput(test)
# count number of words ( here 4 )
count <- sapply(gregexpr("[A-z]\\W+", cleantest), length) + 1L
# structure as Ngrams
cleantest_ <- gsub(" ","_", cleantest)
#something to find with 5 grams?
dt5gramsred[base==cleantest_] # empty normal it does not exist, so we need to move to 4 grams
# something with 4 grams?( guy_in_front)
library(stringr) # for word formula
last <- paste(c(word(cleantest,-3:-1) ),collapse=" ") # that choose the three last words 
last
cleantest_ <- gsub(" ","_", last)
dt4gramsred[base==cleantest_] 
# something with 3 grams?(in_front)
last <- paste(c(word(cleantest,-2:-1) ),collapse=" ") # that choose the two last words 
last
cleantest_ <- gsub(" ","_", last)
dt3gramsred[base==cleantest_] 
# something with 2 grams?(front)
last <- paste(c(word(cleantest,-1:-1) ),collapse=" ") # that choose the last word
last
cleantest_ <- gsub(" ","_", last)
dt2gramsred[base==cleantest_]


# what if we use the the top outcomes
load("dt2grams.Rda")
dt2grams <- data.table(dt2grams)
sortdt2grams <- dt2grams[order(-frequency),] 
last <- paste(c(word(cleantest,-1:-1) ),collapse=" ")
cleantest_ <- gsub(" ","_", last)
head(sortdt2grams[base==cleantest_],5)# 5 most frequent



# using package ANLP

install.packages("ANLP")
library(ANLP)

ModelList <- dt2grams
predict_Backoff("the person",ModelList)
