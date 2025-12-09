report_generator_ui <- function(id) {
  
  ns <- NS(id)
  
  layout_sidebar(
    sidebar = sidebar(
      width = 250,
      
      fileInput(ns("file1"), "Choose Excel File", 
                accept = c(".xls", ".xlsx")),
      
      accordion(
        id = ns("report_accordion"),
        open = FALSE,
        multiple = TRUE,
        
        accordion_panel(
          title = "Generate Report",
          icon = icon("file-code"),
          value = "processreport",
          
          selectInput(ns("category3"), "Category:", c()),
          selectInput(ns("measure3"), "Measure:", c()),
          selectInput(ns("aggregate3"), "Aggregation Type:", 
                      c("Average","Sum", "Count", "Max", "Min"), 
                      selected = "Average"),
          actionButton(ns("renderReport"), "Render Report")
        ),
        
        accordion_panel(
          title = "Download Report",
          icon = icon("file-code"),
          value = "downloadreport",
          
          downloadButton(ns("saveReportWord"), "Save report as Word")
        )
      )
    ),
    
    uiOutput(ns("reportUI"))
  )
}