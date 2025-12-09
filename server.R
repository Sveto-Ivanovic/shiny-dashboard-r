source("functions/table_choice_server.R")
source("functions/calculate_statistics_1_server.R")
source("functions/calculate_statistics_0_select_dataset.R")
source("functions/calculate_statistics_2_aggregation_server.R")
source("functions/report_generation_server.R")
source("functions/sheet_report_server.R")


server <- function(input, output, session) {
  sharedDataset <- statisticsDatasetManager("statistics", loaded_datasets)
  table_choice_server("sidebar-table-choice", loaded_datasets)
  statistics_1_manager("statistics", sharedDataset)
  statistics_2_manager("statistics", sharedDataset)
  report_generation_server("report")
  sheet_report_server("sheet")
  
}