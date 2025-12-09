statisticsDatasetManager <- function(id, loaded_datasets) {
  moduleServer(id, function(input, output, session) {
    
    # Reactive dataset
    dataset <- reactive({
      req(input$selectStatisticsDataset)
      loaded_datasets[[input$selectStatisticsDataset]]
    })
    
    # Return the reactive directly
    dataset
  })
}
