# SUMMARY
# 1. Load Ngrams created with script 1CorpusandNGrams
# 2. Split the Ngram with the last word and compute the freq per NGRams
# 3. Save the data.tables

# Clear all data and load saved data
rm(list=ls())
TwoGram <- readRDS(file= "TwoGram.rds")
ThreeGram <- readRDS(file= "ThreeGram.rds")
FourGram <- readRDS(file= "FourGram.rds")
FiveGram <- readRDS(file= "FiveGram.rds")
SixGram <- readRDS(file= "SixGram.rds")

# convert dfm into data.tables, create base/predcitions, compute frequencies
library(data.table)
library(quanteda)

dt2grams <- data.table(ngram = featnames(TwoGram), keep.rownames = F, stringsAsFactors = F)
dt2grams[, base := strsplit(ngram, "_[^_]+$")[[1]], by = ngram]
dt2grams[, prediction := tstrsplit(ngram, paste(base, "_", sep = ""), fixed = T, keep = 2)[[1]], by = ngram]
dt2grams[, ngramsize := length(strsplit(ngram, "_")[[1]]), by = ngram]
dt2grams[, frequency := colSums(TwoGram)]

dt3grams <- data.table(ngram = featnames(ThreeGram), keep.rownames = F, stringsAsFactors = F)
dt3grams[, base := strsplit(ngram, "_[^_]+$")[[1]], by = ngram]
dt3grams[, prediction := tstrsplit(ngram, paste(base, "_", sep = ""), fixed = T, keep = 2)[[1]], by = ngram]
dt3grams[, ngramsize := length(strsplit(ngram, "_")[[1]]), by = ngram]
dt3grams[, frequency := colSums(ThreeGram)]

dt4grams <- data.table(ngram = featnames(FourGram), keep.rownames = F, stringsAsFactors = F)
dt4grams[, base := strsplit(ngram, "_[^_]+$")[[1]], by = ngram]
dt4grams[, prediction := tstrsplit(ngram, paste(base, "_", sep = ""), fixed = T, keep = 2)[[1]], by = ngram]
dt4grams[, ngramsize := length(strsplit(ngram, "_")[[1]]), by = ngram]
dt4grams[, frequency := colSums(FourGram)]

dt5grams <- data.table(ngram = featnames(FiveGram), keep.rownames = F, stringsAsFactors = F)
dt5grams[, base := strsplit(ngram, "_[^_]+$")[[1]], by = ngram]
dt5grams[, prediction := tstrsplit(ngram, paste(base, "_", sep = ""), fixed = T, keep = 2)[[1]], by = ngram]
dt5grams[, ngramsize := length(strsplit(ngram, "_")[[1]]), by = ngram]
dt5grams[, frequency := colSums(FiveGram)]

dt6grams <- data.table(ngram = featnames(SixGram), keep.rownames = F, stringsAsFactors = F)
dt6grams[, base := strsplit(ngram, "_[^_]+$")[[1]], by = ngram]
dt6grams[, prediction := tstrsplit(ngram, paste(base, "_", sep = ""), fixed = T, keep = 2)[[1]], by = ngram]
dt6grams[, ngramsize := length(strsplit(ngram, "_")[[1]]), by = ngram]
dt6grams[, frequency := colSums(SixGram)]

# save data.table
save(dt2grams,file="dt2grams.Rda")
save(dt3grams,file="dt3grams.Rda")
save(dt4grams,file="dt4grams.Rda")
save(dt5grams,file="dt5grams.Rda")
save(dt6grams,file="dt6grams.Rda")

#clear memory and load data.table
#rm(list=ls())
load("dt2grams.Rda")
load("dt3grams.Rda")
load("dt4grams.Rda")
load("dt5grams.Rda")
load("dt6grams.Rda")

