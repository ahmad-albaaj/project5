library(shiny)
library(DT)

ui <- fluidPage(
    titlePanel("Practising with data sources and processing - challenge"),
    sidebarLayout(
              sidebarPanel(
                   fileInput("gapminder_C.csv", "Upload data", multiple = FALSE,
                             accept = c(".csv"), placeholder = "gapminder_C.csv"),
                   tags$hr(),
                   uiOutput("year"),
                   uiOutput("continent"),
                   uiOutput("slider"),                     
                   tags$hr(),
                   downloadLink(outputId = "gapminderCSV_output", label = "Download")       
        ),
        mainPanel( wellPanel(DT::dataTableOutput("table_gapminder")))
           ) 
        )
        
    

    
    
    
    # Application title
#    titlePanel("Practising with data sources and processing"),
 #   sidebarLayout(
#        sidebarPanel(   
 #           # Input: Select a file ----
  #          fileInput("gapminder_C.csv", "Upload data", multiple = FALSE,
    #                  accept = c(".csv"), placeholder = "gapminder_C.csv"),
 #           br(),
  #          uiOutput("year"),
   #         uiOutput("continent"),
   #         uiOutput("slider"),                     
  #          br(),
  #          downloadLink(outputId = "gapminderCSV_output", label = "Download")       
  #      ),
  #      mainPanel( wellPanel(DT::dataTableOutput("table_gapminder")))
 #   ) 
#)