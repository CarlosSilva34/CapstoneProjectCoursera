
suppressPackageStartupMessages(c(
        library(shinythemes),
        library(shiny),
        library(tm),
        library(stringr),
        library(markdown),
        library(stylo)))

shinyUI(navbarPage("Coursera Data Science Capstone",
                   theme = shinytheme("united"),
                   tabPanel("Prediction",
                            HTML("<strong>Author: Carlos Silva</strong>"),
                            br(),
                            HTML("<strong>Date: 3 December 2017</strong>"),
                            br(),
                            # Sidebar
                            br(),
                            br(),
                            sidebarLayout(
                                    sidebarPanel(
                                            helpText("Enter an incomplete sentence to see the prediction for the next word"),
                                            textInput("inputString", "Enter your word / phrase:",value = ""),
                                            br(),
                                            br(),
                                            br(),
                                            br()
                                    ),
                                    mainPanel(
                                            h2("The predicted Word"),
                                            verbatimTextOutput("pred"),
                                            strong("Your sentence:"),
                                            tags$style(type='text/css', '#mesg1 {background-color: lightgrey; color: black;}'), 
                                            textOutput('mesg1'),
                                            br(),
                                            strong("Ngram prediction:"),
                                            tags$style(type='text/css', '#mesg2 {background-color: lightgrey; color: black;}'),
                                            textOutput('mesg2'),
                                            hr(),
                                            tags$style(type='text/css', '#footer_text {font-family: Verdana, Arial, Helvetica, sans-serif; color: grey;font-size:11pt;}'),
                                            HTML('<div id="footer_text">'),
                                            br(),
                                            br(),
                                            br(),
                                            "In assocation with:",
                                            br(),
                                            img(src="http://media.tumblr.com/92a71d62ace9940f8ddd540400444fc4/tumblr_inline_mppo32jFBC1qz4rgp.png", height=70, width=200),
                                            img(src="http://brand.jhu.edu/content/uploads/2014/06/university.logo_.small_.horizontal.blue_.jpg", height=100, width=200),
                                            img(src="http://cdnswiftkeycom.swiftkey.com/images/misc/logo.png", height=50, width=170),
                                            HTML('</div>')
                                            
                                            
                                    )
                            )
                            
                            
                   ),
                   tabPanel("About",
                            mainPanel(
                                    includeMarkdown("about.md")   
                            )
                   )
)
)
