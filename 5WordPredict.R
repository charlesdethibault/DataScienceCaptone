
#Predict next word Function takes in the input variable from user and predicts the next word
predictNextWord <- function(input){
          
          #Cleaning the input
          wordInput <- cleanInput(input)
          #Getting the number of words in the input
          wordCount  <- sapply(gregexpr("[A-z]\\W+", wordInput), length) + 1L
          #reduce wordcount to 4 and estimate predict 5 grams
          if(wordCount>2){
                    wordInput <- paste(c(word(wordInput,-2:-1) ),collapse=" ")
                    wordInput_ <- gsub(" ","_", wordInput)          
                    result <- dt3gramsred[base==wordInput_]$prediction
                    #if nothing found go to next NGram
          } else {
                    wordInput <- paste(c(word(wordInput,-1:-1) ),collapse=" ")
                    wordInput_ <- gsub(" ","_", wordInput)          
                    result <- dt2gramsred[base==wordInput_]$prediction
                    
          }
          
          
return(result)        
} 



#Cleaning input to extract specific words
cleanInput <- function(text){
          textInput <- tolower(text)
          textInput <- removePunctuation(textInput)
          textInput <- removeNumbers(textInput)
          textInput <- str_replace_all(textInput, "[^[:alnum:]]", " ")
          textInput <- stripWhitespace(textInput)
          return(textInput)
}
          

                    