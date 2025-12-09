statistics_1_manager <- function(id, shared_dataset) {
  moduleServer(id, function(input, output, session) {
    
    observe({
      
      data <- shared_dataset()
      
      numerical_col_names <- names(data)[sapply(data, is.numeric)]
      
      updateSelectInput(session, "xselectionaxis1", choices=c(numerical_col_names), selected = tail(numerical_col_names,1))
      updateSelectInput(session, "yselectionaxis1", choices=c(numerical_col_names), selected = tail(numerical_col_names,1))
      
      
    })
   
    observeEvent(input$renderMultiLinePlot, {
        data <- isolate(shared_dataset())
        
        xcolname <- isolate(input$xselectionaxis1)
        ycolnames <- isolate(input$yselectionaxis1)
      
        output$generatedPlot <- renderPlot({
          
          if (is.null(input$yselectionaxis1) || length(input$yselectionaxis1) == 0) {
            runjs("alert('Warning: No y axis columns were selected!')")
            return(NULL)
          }
          

          p <- ggplot(data, aes_string(x = xcolname))
          
          for(col in ycolnames){
            p<-p + geom_line(aes_string(y=col, color = shQuote(col)), linetype="solid")
          }
          
          p + theme_minimal() + labs(color = "Variable")
          
          
        })
    })
    
  })
}