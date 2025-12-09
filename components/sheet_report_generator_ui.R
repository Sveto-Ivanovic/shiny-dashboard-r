sheet_report_generator_ui <- function(id){
  ns <- NS(id)
  
  card(
    accordion(
      id=ns("accordion_wraper_3"),
      multiple = FALSE,
      accordion_panel("Select Excel File:",
                      icon = icon("file-code"),
                      value = "choseDataset2",
                      fileInput(ns("file2"), "Choose Excel File", 
                                accept = c(".xls", ".xlsx")),
                      ),
      accordion_panel("Aggregate:",
                      icon = icon("calculator"),
                      value = "aggregate4",
                      selectInput(ns("category5"), "Category:", c()),
                      selectInput(ns("measure5"), "Measure:", c()),
                      selectInput(ns("aggregate5"), "Aggregation Type:", 
                                  c("Average","Sum", "Count", "Max", "Min"), 
                                  selected = "Average"),
      ),
      accordion_panel("Custom Operations:",
                      icon = icon("calculator"),
                      value = "calc4",
                      actionButton(ns("addEx"), "Add Expression"),
                      actionButton(ns("removeEx"), "Remove Expression"),
                      uiOutput(ns("uiOutputOperator"))
                      ),
      accordion_panel("Download Report:",
                      icon = icon("download"),
                      value = "download4",
                      downloadButton(ns("saveReportExcel"), "Download Excel Report")
      )
      
    )
  )
  
  
  
  
  
}