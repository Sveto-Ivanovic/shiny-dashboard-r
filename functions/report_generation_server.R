report_generation_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    report_rendered <- reactiveVal(FALSE)
    report_params <- reactiveVal(NULL)
    
    get_excel_df <- reactive({
      file <- input$file1
      
      req(file)
      ext <- tools::file_ext(file$datapath)
      
      if (!ext %in% c("xls", "xlsx")) {
        runjs("alert('Warning: unsupported extension. Please choose xls and xlsx.')")
        return(NULL)
      }
      
      read_excel(file$datapath)
    })
    
    
    observe({
      data <- get_excel_df()
      req(data)
      
      numerical_col_names <- names(data)[sapply(data, is.numeric)]
      all_names <- names(data)
      
      updateSelectInput(
        session,
        "category3",
        choices = c(all_names),
        selected = tail(all_names, 1)
      )
      updateSelectInput(
        session,
        "measure3",
        choices = c(numerical_col_names),
        selected = tail(numerical_col_names, 1)
      )
    })
    
    observeEvent(input$renderReport, {
      data <- get_excel_df()
      
      category <- isolate(input$category3)
      measure <- isolate(input$measure3)
      aggregation_type <- isolate(input$aggregate3)
      
      formula_representation_of_columns = as.formula(paste0("`", measure, "` ~ `", category, "`"))
      
      grouped_dataframe <- switch(
        aggregation_type,
        "Average" = aggregate(
          formula_representation_of_columns,
          data = data,
          FUN = mean
        ),
        "Max" = aggregate(
          formula_representation_of_columns,
          data = data,
          FUN = max
        ),
        "Min" = aggregate(
          formula_representation_of_columns,
          data = data,
          FUN = min
        ),
        "Sum" = aggregate(
          formula_representation_of_columns,
          data = data,
          FUN = sum
        ),
        "Count" = aggregate(
          formula_representation_of_columns,
          data = data,
          FUN = length
        )
      )
      
      sorted_df <- arrange(grouped_dataframe, .data[[measure]])
      top5 <- slice_head(sorted_df, n = 5)
      
      params = list(
        df = grouped_dataframe,
        biggest_5_column_names =  top5[[category]],
        biggest_5_column_values = top5[[measure]]
      )
      
      report_params(params)
      report_rendered(TRUE)
      
      temp_html <- tempfile(fileext = ".html")
      
      rmarkdown::render(
        "reports/TestReport1.Rmd",
        output_file = temp_html,
        params = params,
        envir = new.env()
      )
      
      file.copy(temp_html, "www/temp.html", overwrite = TRUE)
      
      output$reportUI <- renderUI({
        tags$iframe(
          src = "temp.html",
          width = "100%",
          height = "1700px",
          style = "border: none;"
        )
      })
      
      shiny::outputOptions(output, "reportUI", suspendWhenHidden = FALSE)
    })
    
    output$saveReportWord <- downloadHandler(
      filename = function() {
        paste0("report_", format(Sys.Date(), "%Y%m%d"), ".docx")
      },
      
      content = function(file) {
        req(report_rendered())
        
        params <- report_params()
        req(params)
        
        print("TRY")  # This should now print
        
        showNotification("Generating Word document...", id = "word_gen", 
                         type = "message", duration = NULL)
        
        tryCatch({
          rmarkdown::render(
            input = "reports/TestReport1.Rmd",
            output_format = "word_document",
            output_file = file,  # Render directly to the file parameter
            params = params,
            envir = new.env(),
            quiet = TRUE
          )
          
          removeNotification("word_gen")
          showNotification("Word document generated successfully!", 
                           type = "message", duration = 3)
          
        }, error = function(e) {
          removeNotification("word_gen")
          showNotification(paste("Error generating Word document:", e$message), 
                           type = "error", duration = 10)
          print(e)
        })
    })
    
    
    
  })
}