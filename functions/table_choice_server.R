table_choice_server <- function(id, loaded_datasets) {
  moduleServer(id, function(input, output, session) {
    output$tableOutput1 <- renderDataTable({
      dataset <- loaded_datasets[[input$selectedDataset]]
      
      if (input$selectedType == "all") {
        dataset
      } 
      else if (input$selectedType == "number") {
        filtered_col_names <- names(dataset)[sapply(dataset, is.numeric)]
        
        if (length(filtered_col_names) == 0) {
          runjs("alert('Warning: no numeric columns found, reverting to default.')")
          updateSelectInput(session, "selectedType", selected = "all")
          dataset
        } else {
          dataset[, filtered_col_names]
        }
      } 
      else {
        filtered_col_names <- names(dataset)[sapply(dataset, is.character)]
        
        if (length(filtered_col_names) == 0) {
          runjs("alert('Warning: no text columns found, reverting to default.')")
          updateSelectInput(session, "selectedType", selected = "all")
          dataset
        } else {
          dataset[, filtered_col_names]
        }
      }
    })
  })
}