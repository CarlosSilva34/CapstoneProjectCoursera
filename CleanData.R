library(tm)
library(stringi)
library(RWeka)
library(RColorBrewer)
library(ggplot2)
library(R.utils)
library(dplyr)
library(parallel)

set.seed(1082)


path <- "C:/Users/Utilizador/Desktop/DataScience/CapstoneProject/data/final/en_US"

## Downloading the data

if (!file.exists("./data")) {
        dir.create("./data")
}
FileUrl <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"


if (!file.exists("./data/Swiftkey Dataset.zip")) {
        download.file(FileUrl, destfile = "./data/Swiftkey Dataset.zip")
}


if (!file.exists("./data/final")) {
        unzip("./data/Swiftkey Dataset.zip", exdir = "./data")
}

rm(FileUrl)


blogs <- readLines("data/final/en_US/en_US.blogs.txt", encoding="UTF-8", skipNul = TRUE)
twitter <- readLines("data/final/en_US/en_US.twitter.txt", encoding="UTF-8", skipNul = TRUE)
news <- readLines("data/final/en_US/en_US.news.txt", encoding="UTF-8", skipNul = TRUE)

set.seed(1082)

DataSample <- c(sample(blogs, length(blogs) * 0.5),
                sample(news, length(news) * 0.5),
                sample(twitter, length(twitter) * 0.5))

writeLines(DataSample, "./datasample/Datasample.txt")

corpus <- VCorpus(DirSource("./datasample"))

corpus<- tm_map(corpus, content_transformer(function(x) iconv(x, to="UTF-8", sub="byte")))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, content_transformer(removePunctuation))
corpus <- tm_map(corpus, content_transformer(removeNumbers))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, stemDocument)

saveRDS(corpus, file = "./Corpus.RData")





