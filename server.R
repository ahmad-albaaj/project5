library(DT)
library(readr)
library(dplyr)
library(gapminder)

server <- function(input, output) {
    setwd("/cloud/project/data")
    gapminder <- reactive({ infile <- input$gapminder_C.csv
    if (is.null(infile)) {return(NULL)  } 
    read.csv(infile$data, header = TRUE)
    })
 
    output$year <- renderUI({
      selectizeInput('year', 'Year', 
                     choices =c("2007", unique(gapminder()$year)),selected = 2007)
    } )
    
    subsetYear <- eventReactive(input$year,{
      return(gapminder()[gapminder()$year == input$year,names(gapminder())])  
    } )
    
    
    output$continent <- renderUI({
      selectizeInput('continent', 'Continent', 
                     choices = c("All", unique(gapminder()$continent)),selected = "All")
    })
    
    
    subset2 <- eventReactive(input$continent,{
      return(if(input$continent=="All") {subsetCont <- subsetYear()}
             else{subsetCont <- subsetYear()[subsetYear()$continent == input$continent,]})
    })
    
    output$slider <- renderUI({
      if(is.null(subset2()) ) {
        sliderInput("slider", label = "Max number of table entries", 
                    min = 1, max=1704, value = 1704)} else 
                      sliderInput("slider", label = "Max number of table entries", 
                                  min = 1, max=nrow(subset2()), value = nrow(subset2())) 
    })
    
    output$gapminderCSV_output <- downloadHandler(
      filename = function() {
        return("gapminder_out.csv")
      },
      content = function(fileOut) {
        write.csv(gapminder(), fileOut)
      }
    )
    
    output$table_gapminder <- DT::renderDataTable({
      if (is.null(subset2()) ) {mytable <- gapminder()} 
      else  mytable <- subset2()
      datatable(mytable,
                options = list(scrollX = TRUE, lengthChange = TRUE))
    })

}   
    