source("components/sidebar_table_ui.R")
source("components/statistics_generator_ui.R")
source("components/report_generator_ui.R")
source("components/sheet_report_generator_ui.R")

navigation_bar_theme <- bs_theme(
  version = 5,             
  bg = "#E6FFFF",          
  fg = "#1F75FE",        
)

ui <- page_navbar(
  theme = navigation_bar_theme,
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "main_app.css?v=23")),
  nav_panel("Tables",  sidebar_table_ui("sidebar-table-choice", loaded_datasets)),
  nav_panel("Statistics", sidebar_statistics_ui("statistics", loaded_datasets)),
  nav_panel("Word Report", report_generator_ui("report")),
  nav_panel("Sheet Report", sheet_report_generator_ui("sheet")),
  title = "Menu",
  id = "page",
)

