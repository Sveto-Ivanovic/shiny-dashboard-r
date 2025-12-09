sidebar_statistics_ui <- function(id, loaded_datasets) {
  
  ns <- NS(id)
  
  layout_sidebar(
    sidebar = sidebar(
      width = 250,
      
      selectInput(ns("selectStatisticsDataset"), 
                  "Select dataset:", 
                  choices = names(loaded_datasets), 
                  selected = names(loaded_datasets)[1]),
      
      accordion(
        id = ns("sidebar_accordion"),
        open = FALSE,
        multiple = TRUE,
        
        accordion_panel(
          title = "Line plots",
          icon = icon("arrow-trend-down"),
          value = "processplot",
          
          selectInput(ns("xselectionaxis1"), "X Axis:", c()),
          selectInput(ns("yselectionaxis1"), "Y Axis:", c(), multiple = TRUE),
          actionButton(ns("renderMultiLinePlot"), "Render Plot")
        ),
        
        accordion_panel(
          title = "Aggregation & Bar",
          icon = icon("chart-column"),
          value = "processplot2",
          
          selectInput(ns("category2"), "Category:", c()),
          selectInput(ns("measure2"), "Measure:", c()),
          selectInput(ns("aggregate2"), "Aggregation Type:", 
                      c("Average","Sum", "Count", "Max", "Min"), 
                      selected = "Average"),
          actionButton(ns("renderBarAndTable"), "Aggregate")
        )
      )
    ),
    
    card(plotOutput(ns("generatedPlot"), click = "plot_click")),
    layout_column_wrap(
      card(plotOutput(ns("generatedBarPlot"), click = "plot_click")),
      card(dataTableOutput(ns("generatedDataTable")))
    )
  )
}











