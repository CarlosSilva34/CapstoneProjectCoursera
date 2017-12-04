suppressWarnings(library(tm))
suppressWarnings(library(stringr))
suppressWarnings(library(shiny))


quadgram <- readRDS("quadgram.RData");
trigram <- readRDS("trigram.RData");
bigram <- readRDS("bigram.RData");
mesg <<- ""


# For Prediction is used the Back Off Algorithm.
# Quadgram is first used, if it's not found, back off to Trigram and then to Bigram.
# If no Bigram is found, back off to the most common word with highest frequency 'the' is returned.

Pred <- function(x) {
        xcl <- removeNumbers(removePunctuation(tolower(x)))
        xstr <- strsplit(xcl, " ")[[1]]
        if (length(xstr)>= 3) {
                xstr <- tail(xstr,3)
                if (identical(character(0),head(quadgram[quadgram$unigram == xstr[1] & quadgram$bigram == xstr[2] & quadgram$trigram == xstr[3], 4],1))){
                        Pred(paste(xstr[2],xstr[3],sep=" "))
                }
                else {mesg <<- "4-gram used for next word prediction."; head(quadgram[quadgram$unigram == xstr[1] & quadgram$bigram == xstr[2] & quadgram$trigram == xstr[3], 4],1)}
        }
        else if (length(xstr) == 2){
                xstr <- tail(xstr,2)
                if (identical(character(0),head(trigram[trigram$unigram == xstr[1] & trigram$bigram == xstr[2], 3],1))) {
                        Pred(xstr[2])
                }
                else {mesg<<- "3-gram used for next word prediction."; head(trigram[trigram$unigram == xstr[1] & trigram$bigram == xstr[2], 3],1)}
        }
        else if (length(xstr) == 1){
                xstr <- tail(xstr,1)
                if (identical(character(0),head(bigram[bigram$unigram == xstr[1], 2],1))) {mesg<<-"Not found. Most common word 'the' is returned."; head("the",1)}
                else {mesg <<- "2-gram used for next word prediction."; head(bigram[bigram$unigram == xstr[1],2],1)}
        }
}


shinyServer(function(input, output) {
        output$pred <- renderPrint({
                result <- Pred(input$inputString)
                output$mesg2 <- renderText({mesg})
                result
        });
        
        output$mesg1 <- renderText({
                input$inputString});
}
)