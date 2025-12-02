sidebar_table_ui <- function(id, loaded_datasets) {
  ns <- NS(id)
  
  page_sidebar(
    title = "Select dataset:",
    useShinyjs(),
    sidebar = sidebar(
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
    dataTableOutput(ns("tableOutput1"))
  )
}
