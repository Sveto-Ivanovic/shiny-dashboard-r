source("components/sidebar_table_ui.R")
source("components/statistics_generator_ui.R")

ui <- page_navbar(
  theme = navigation_bar_theme,
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "main_app.css?v=2")),
  nav_panel("Tables",  sidebar_table_ui("sidebar-table-choice", loaded_datasets)),
  nav_panel("Statistics", sidebar_statistics_ui("statistics", loaded_datasets)),
  title = "Menu",
  id = "page",
)
