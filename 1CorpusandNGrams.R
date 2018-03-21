# SUMMARY
# 1. Creation of the sample which size is dictacted by N
# 2. Merge different cources to create one main file
# 3. Clean the file
# 4. Create Ngrams
# 5. Save NGrams

# clear data
rm(list=ls())

#set size
N = 70000

#connection to  data
setwd("D:/GoogleDrive/onlinecourse/R/20180101swiftkey/Coursera-SwiftKey/final/en_US")
list.files("D:/GoogleDrive/onlinecourse/R/20180101swiftkey/Coursera-SwiftKey/final/en_US")
# adress each file
connection_twitter <- file("en_US.twitter.txt", "r")
connection_blogs <- file("en_US.blogs.txt", "r")
connection_news <- file("en_US.news.txt", "r")

# load files
blogs <- readLines(connection_blogs)
news <- readLines(connection_news)
twitter <- readLines(connection_twitter)
close(connection_twitter,connection_news,connection_blogs)

sample_blogs <- sample(1:length(blogs), N , replace = FALSE)
sample_blogs <- blogs[sample_blogs]

sample_news <- sample(1:length(news), N , replace = FALSE)
sample_news <- news[sample_news]

sample_twitter <- sample(1:length(twitter), N , replace = FALSE)
sample_twitter <- twitter[sample_twitter]
#use qdap for blogs ans news
library(qdap)
data_sample <- c(sample_blogs, sample_news) 
#create data sample
data_sample <- sent_detect(data_sample)
# use loop for twitter
tw <- c(NULL)
for(i in 1:length(sample_twitter)){
          tw_eve <- sent_detect(sample_twitter[i])
          tw <- c(tw, tw_eve)
}
# add twitter to data sample
data_sample <- c(data_sample, tw)

# Remove NON-ASCII Characters
for(i in 1:length(data_sample)){
          row <- data_sample[i]
          row_1 <- iconv(row, "latin1", "ASCII", sub = "")
          data_sample[i] <- row_1
}
saveRDS(data_sample, "data_sample.rds")
#create Ngrams with minimum count
library("quanteda", lib.loc="~/R/win-library/3.4")

#OneGram <- dfm(data_sample, ngrams=1, remove_numbers=TRUE,remove_punct=TRUE, remove_symbols=TRUE,remove_separators = TRUE,remove_twitter=TRUE, remove_hyphens=TRUE)
#OneGram <- dfm_trim(OneGram, min_count = 5)
#OneGramVect <- sort(colSums(OneGram),decreasing=TRUE)

TwoGram <- dfm(data_sample, ngrams=2, remove_numbers=TRUE,remove_punct=TRUE, remove_symbols=TRUE,remove_separators = TRUE,remove_twitter=TRUE, remove_hyphens=TRUE)
TwoGram <- dfm_trim(TwoGram, min_count = 2)
TwoGramVect <- sort(colSums(TwoGram),decreasing=TRUE)

ThreeGram <- dfm(data_sample, ngrams=3, remove_numbers=TRUE,remove_punct=TRUE, remove_symbols=TRUE,remove_separators = TRUE,remove_twitter=TRUE, remove_hyphens=TRUE)
ThreeGram <- dfm_trim(ThreeGram, min_count = 2)
ThreeGramVect <- sort(colSums(ThreeGram),decreasing=TRUE)

FourGram <- dfm(data_sample, ngrams=4, remove_numbers=TRUE,remove_punct=TRUE, remove_symbols=TRUE,remove_separators = TRUE,remove_twitter=TRUE, remove_hyphens=TRUE)
FourGram <- dfm_trim(FourGram, min_count = 2)
FourGramVect <- sort(colSums(FourGram),decreasing=TRUE)

FiveGram <- dfm(data_sample, ngrams=5, remove_numbers=TRUE,remove_punct=TRUE, remove_symbols=TRUE,remove_separators = TRUE,remove_twitter=TRUE, remove_hyphens=TRUE)
FiveGram <- dfm_trim(FiveGram, min_count = 2)
FiveGramVect <- sort(colSums(FiveGram),decreasing=TRUE)

SixGram <- dfm(data_sample, ngrams=6, remove_numbers=TRUE,remove_punct=TRUE, remove_symbols=TRUE,remove_separators = TRUE,remove_twitter=TRUE, remove_hyphens=TRUE)
SixGram <- dfm_trim(SixGram, min_count = 2)
SixGramVect <- sort(colSums(SixGram),decreasing=TRUE)

# Save Ngrams
setwd("D:/GoogleDrive/onlinecourse/R/20180101swiftkey")
#saveRDS(OneGram, "OneGram.rds")
saveRDS(TwoGram, "TwoGram.rds")
saveRDS(ThreeGram, "ThreeGram.rds")
saveRDS(FourGram, "FourGram.rds")
saveRDS(FiveGram, "FiveGram.rds")
saveRDS(SixGram, "SixGram.rds")
# Clear all data and load saved data
rm(list=ls())
#OneGram <- readRDS(file= "OneGram.rds")
TwoGram <- readRDS(file= "TwoGram.rds")
ThreeGram <- readRDS(file= "ThreeGram.rds")
FourGram <- readRDS(file= "FourGram.rds")
FiveGram <- readRDS(file= "FiveGram.rds")
SixGram <- readRDS(file= "SixGram.rds")


# with 10,000 items we have 2gram 40,150 obs, 3gram,618621, 4gram 656141,5gram 619508, 6grans 571933
# it is better to have more data and then keep lower number of items by having a limited number of frequencies
