# in order to reduce time process we will keep unique base with highest frequency
load("dt2grams.Rda")
load("dt3grams.Rda")
load("dt4grams.Rda")
load("dt5grams.Rda")
load("dt6grams.Rda")

#reduction dt2
# use aggregate to create new data frame with the maxima
df.agg <- aggregate(frequency ~ base, dt2grams, max)
# then simply merge with the original
df.max <- merge(df.agg, dt2grams)
#rechange col to initial
dt2gramsred <- df.max[c("ngram","base","prediction","ngramsize","frequency")]

#reduction dt3
# use aggregate to create new data frame with the maxima
df.agg <- aggregate(frequency ~ base, dt3grams, max)
# then simply merge with the original
df.max <- merge(df.agg, dt3grams)
#rechange col to initial
dt3gramsred <- df.max[c("ngram","base","prediction","ngramsize","frequency")]

#reduction dt4
# use aggregate to create new data frame with the maxima
df.agg <- aggregate(frequency ~ base, dt4grams, max)
# then simply merge with the original
df.max <- merge(df.agg, dt4grams)
#rechange col to initial
dt4gramsred <- df.max[c("ngram","base","prediction","ngramsize","frequency")]

#reduction dt5
# use aggregate to create new data frame with the maxima
df.agg <- aggregate(frequency ~ base, dt5grams, max)
# then simply merge with the original
df.max <- merge(df.agg, dt5grams)
#rechange col to initial
dt5gramsred <- df.max[c("ngram","base","prediction","ngramsize","frequency")]

#reduction dt6
# use aggregate to create new data frame with the maxima
df.agg <- aggregate(frequency ~ base, dt6grams, max)
# then simply merge with the original
df.max <- merge(df.agg, dt6grams)
#rechange col to initial
dt6gramsred <- df.max[c("ngram","base","prediction","ngramsize","frequency")]


dt2gramsred <- data.table(dt2gramsred)
dt3gramsred <- data.table(dt3gramsred)
dt4gramsred <- data.table(dt4gramsred)
dt5gramsred <- data.table(dt5gramsred)
dt5gramsred <- data.table(dt6gramsred)

# save data.table
save(dt2gramsred,file="dt2gramsred.Rda")
save(dt3gramsred,file="dt3gramsred.Rda")
save(dt4gramsred,file="dt4gramsred.Rda")
save(dt5gramsred,file="dt5gramsred.Rda")
save(dt6gramsred,file="dt6gramsred.Rda")

#clear memory and load data.table
rm(list=ls())
load("dt2gramsred.Rda")
load("dt3gramsred.Rda")
load("dt4gramsred.Rda")
load("dt5gramsred.Rda")
load("dt6gramsred.Rda")