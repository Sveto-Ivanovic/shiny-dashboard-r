source("functions/table_choice_server.R")

server <- function(input, output, session) {
  table_choice_server("sidebar-table-choice", loaded_datasets)
}