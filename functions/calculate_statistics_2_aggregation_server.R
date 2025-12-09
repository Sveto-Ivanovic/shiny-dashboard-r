statistics_2_manager <- function(id, shared_dataset) {
  moduleServer(id, function(input, output, session) {
    
    observe({
      
      data <- shared_dataset()
      
      numerical_col_names <- names(data)[sapply(data, is.numeric)]
      all_names <- names(data)
      
      updateSelectInput(session, "category2", choices=c(all_names), selected = tail(all_names,1))
      updateSelectInput(session, "measure2", choices=c(numerical_col_names), selected = tail(numerical_col_names,1))
    })
    
    observeEvent(input$renderBarAndTable, {
      data <- isolate(shared_dataset())
      
      category <- isolate(input$category2)
      measure <- isolate(input$measure2)
      aggregation_type <- isolate(input$aggregate2)
      
      formula_representation_of_columns = as.formula(paste(measure, "~", category))
      
      grouped_dataframe <- switch(
        aggregation_type,
        "Average"=aggregate(formula_representation_of_columns, data = data, FUN = mean),
        "Max"=aggregate(formula_representation_of_columns, data = data, FUN = max),
        "Min"=aggregate(formula_representation_of_columns, data = data, FUN = min),
        "Sum"=aggregate(formula_representation_of_columns, data = data, FUN = sum),
        "Count"=aggregate(formula_representation_of_columns, data = data, FUN = length)
      )
      
      
        
      
      output$generatedBarPlot <- renderPlot({
        ggplot(grouped_dataframe, aes_string(x=category, y=measure)) + 
        geom_bar(stat = "identity")
      })
      
      output$generatedDataTable <- renderDataTable({grouped_dataframe}, options = list(pageLength=10))
      
    })
    
  })
}