sidebar_statistics_ui <- function(id, loaded_datasets) {
  
  ns <- NS(id)
  
  header <- dashboardHeader(disable = TRUE)
  
  sidebar <- dashboardSidebar(
    sidebarMenu(
      menuSubItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      
    )
  )
  
  body <- dashboardBody()
  
  dashboardPage(header, sidebar, body)

}
