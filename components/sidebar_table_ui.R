sidebar_table_ui <- function(id, loaded_datasets) {
  ns <- NS(id)
  
  layout_sidebar(
    sidebar = sidebar(
      width = 250,
      
      selectInput(
        ns("selectedDataset"),
        label = "Choose dataset",
        choices = names(loaded_datasets),
        selected = names(loaded_datasets)[1]
      ),
      selectInput(
        ns("selectedType"),
        label = "Choose types",
        choices = c("all", "number", "text"),
        selected = "all"
      )
    ),
    
    card(
      card_header("Select dataset:"),
      dataTableOutput(ns("tableOutput1"))
    )
  )
}