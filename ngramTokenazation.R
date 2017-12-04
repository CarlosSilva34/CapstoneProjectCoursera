
Corpus <- readRDS("Corpus.RData")

# function to make N grams
Ngram <- function (cp, n) {
        NgramTokenizer <- function(x) {RWeka::NGramTokenizer(x, RWeka::Weka_control(min = n, max = n))}
        ngram <- TermDocumentMatrix(cp, control = list(tokenizer = NgramTokenizer))
        ngram
}

# function to extract the N grams
ngram_df <- function (ngram) {
        ngram_m <- as.matrix(ngram)
        ngram_df <- as.data.frame(ngram_m)
        colnames(ngram_df) <- "Count"
        ngram_df <- ngram_df[order(-ngram_df$Count), , drop = FALSE]
        ngram_df
}

# Calculate N-Grams
UniGram <- Ngram(Corpus,1)
BiGram <- Ngram(Corpus,2)
TriGram <- Ngram(Corpus,3)
QuadGram <- Ngram(Corpus,4)

# Extract term-count tables from N-Grams
UniGram_df <- ngram_df(UniGram)
BiGram_df <- ngram_df(BiGram)
TriGram_df <- ngram_df(TriGram)
QuadGram_df<- ngram_df(QuadGram)

# Save data frames
bigram <- data.frame(rows=rownames(BiGram_df),count=BiGram_df$Count)
bigram$rows <- as.character(bigram$rows)
bigram_split <- strsplit(as.character(bigram$rows),split=" ")
bigram <- transform(bigram,first = sapply(bigram_split,"[[",1),second = sapply(bigram_split,"[[",2))
bigram <- data.frame(unigram = bigram$first,bigram = bigram$second,freq = bigram$count,stringsAsFactors=FALSE)
write.csv(bigram[bigram$freq > 1,],"./Shiny/bigram.csv",row.names=F)
bigram <- read.csv("./Shiny/bigram.csv",stringsAsFactors = F)
saveRDS(bigram,"./Shiny/bigram.RData")


trigram <- data.frame(rows=rownames(TriGram_df),count=TriGram_df$Count)
trigram$rows <- as.character(trigram$rows)
trigram_split <- strsplit(as.character(trigram$rows),split=" ")
trigram <- transform(trigram,first = sapply(trigram_split,"[[",1),second = sapply(trigram_split,"[[",2),third = sapply(trigram_split,"[[",3))
trigram <- data.frame(unigram = trigram$first,bigram = trigram$second, trigram = trigram$third, freq = trigram$count,stringsAsFactors=FALSE)
write.csv(trigram[trigram$freq > 1,],"./Shiny/trigram.csv",row.names=F)
trigram <- read.csv("./Shiny/trigram.csv",stringsAsFactors = F)
saveRDS(trigram,"./Shiny/trigram.RData")

quadgram <- data.frame(rows=rownames(QuadGram_df),count=QuadGram_df$Count)
quadgram$rows <- as.character(quadgram$rows)
quadgram_split <- strsplit(as.character(quadgram$rows),split=" ")
quadgram <- transform(quadgram,first = sapply(quadgram_split,"[[",1),second = sapply(quadgram_split,"[[",2),third = sapply(quadgram_split,"[[",3), fourth = sapply(quadgram_split,"[[",4))
quadgram <- data.frame(unigram = quadgram$first,bigram = quadgram$second, trigram = quadgram$third, quadgram = quadgram$fourth, freq = quadgram$count,stringsAsFactors=FALSE)
write.csv(quadgram[quadgram$freq > 1,],"./Shiny/quadgram.csv",row.names=F)
quadgram <- read.csv("./Shiny/quadgram.csv",stringsAsFactors = F)
saveRDS(quadgram,"./Shiny/quadgram.RData")