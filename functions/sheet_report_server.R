
sheet_report_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    ######
    number_of_additions <- reactiveVal(value = 0)
    past_state_params <- reactiveValues(expressions = list(),
                                        current_num_expressions = 0)
    ######
    # Observer event for addition
    observeEvent(input$addEx, {
      if (number_of_additions() >= 5) {
        runjs("alert('You excided the number of expressions: limit 5.')")
        return(NULL)
      }
      number_of_additions(number_of_additions() + 1)
    })
    
    ######
    # Observer event for substraction
    observeEvent(input$removeEx, {
      if (number_of_additions() <= 0) {
        runjs("alert('No expressions exist. Num: 0.')")
        return(NULL)
      }
      number_of_additions(number_of_additions() - 1)
    })
    
    #####
    # Modifiy old states based on click change
    observeEvent(number_of_additions(), {
      min_num <- min(number_of_additions(),
                     past_state_params$current_num_expressions)
      print(min_num)
      if (min_num > 0) {
        for (i in 1:min_num) {
          past_state_params$expressions[[i]] <- isolate({
            list(
              col = input[[paste0("text_input_col_", i)]],
              row = input[[paste0("text_input_row_", i)]],
              bg_color = input[[paste0("select_input_bg_color_", i)]],
              font_color = input[[paste0("select_font_input_color_", i)]],
              text = input[[paste0("text_input_text_", i)]]
              
            )
          })
        }
      }
      past_state_params$current_num_expressions <- number_of_additions()
    })
    
    ######
    # Render inputs based on addition or substraction
    output$uiOutputOperator <- renderUI({
      #check if we have 0 expressions
      if (past_state_params$current_num_expressions == 0) {
        past_state_params$expressions = list()
        return(NULL)
      }
      
      lapply(1:past_state_params$current_num_expressions, function(i) {
        ns <- session$ns
        expr <- if(length(past_state_params$expressions)>=i && !is.null(past_state_params$expressions[[i]])) past_state_params$expressions[[i]] else NULL 
        card(
          style = "max-height: 500px; overflow: visible;",
          textInput(
            ns(paste0("text_input_col_", i)),
            "Column Number:",
            value = if (is.null(expr))
              ""
            else
              expr$col,
            placeholder = "Enter col number..."
          ),
          textInput(
            ns(paste0("text_input_row_", i)),
            "Row Number:",
            value = if (is.null(expr))
              ""
            else
              expr$row,
            placeholder = "Enter row number..."
          ),
          selectInput(
            ns(paste0("select_input_bg_color_", i)),
            "Select BG Color:",
            selected = if (is.null(expr))
              "white"
            else
              expr$bg_color,
            choices = c(
              "red",
              "blue",
              "green",
              "lightblue",
              "lightgreen",
              "yellow",
              "orange",
              "pink",
              "purple",
              "magenta",
              "white",
              "black"
            )
          ),
          selectInput(
            ns(paste0("select_font_input_color_", i)),
            "Select Font Color:",
            selected = if (is.null(expr))
              "black"
            else
              expr$font_color,
            choices = c(
              "red",
              "blue",
              "green",
              "lightblue",
              "lightgreen",
              "yellow",
              "orange",
              "pink",
              "purple",
              "magenta",
              "white",
              "black"
            )
          ),
          textInput(
            ns(paste0("text_input_text_", i)),
            "Value:",
            value = if (is.null(expr))
              ""
            else
              expr$text,
            placeholder = "Enter value..."
          )
        )
      })
    })
    
    # Part for the aggregation table
    report_rendered <- reactiveVal(FALSE)
    report_params <- reactiveVal(NULL)
    
    # Get selected dataset, excel file
    get_excel_df <- reactive({
      file <- input$file2
      
      req(file)
      ext <- tools::file_ext(file$datapath)
      
      if (!ext %in% c("xls", "xlsx")) {
        runjs("alert('Warning: unsupported extension. Please choose xls and xlsx.')")
        return(NULL)
      }
      
      read_excel(file$datapath)
    })
    
    ######
    # modify select inputs so that they contain columns
    observe({
      data <- get_excel_df()
      req(data)
      
      numerical_col_names <- names(data)[sapply(data, is.numeric)]
      all_names <- names(data)
      
      updateSelectInput(
        session,
        "category5",
        choices = c(all_names),
        selected = tail(all_names, 1)
      )
      updateSelectInput(
        session,
        "measure5",
        choices = c(numerical_col_names),
        selected = tail(numerical_col_names, 1)
      )
    })
    
    ######
    output$saveReportExcel <- downloadHandler(
      filename = function() {
        paste0("report_sheet_", format(Sys.Date(), "%Y%m%d"), ".xlsx")
      },
      
      content = function(file) {
        data <- get_excel_df()
        
        category <- isolate(input$category5)
        measure <- isolate(input$measure5)
        aggregation_type <- isolate(input$aggregate5)
        
        # backticks are included because column names can have spaces and that causes error for formula
        formula_representation_of_columns <- as.formula(paste0("`", measure, "` ~ `", category, "`"))
        
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
        
        # we got our data frame for excel here
        sorted_df <- arrange(grouped_dataframe, desc(.data[[measure]]))
        
        # Create a new workbook and add a sheet
        wb <- createWorkbook()
        
        # add sheet
        addWorksheet(wb, "First Sheet")
        
        # write the sheet
        writeDataTable(
          wb,
          "First Sheet",
          x = sorted_df,
          xy = c("A", 1),
          rowNames = TRUE,
          tableStyle = "TableStyleLight9",
          headerStyle = createStyle(textRotation = 45)
        )
        
        # now we need custom fields from the other inputs
        # go through expressions
        for (i in  1:past_state_params$current_num_expressions) {
          
          text_val <- input[[paste0("text_input_text_", i)]]
          col_val <- input[[paste0("text_input_col_", i)]]
          row_val <- input[[paste0("text_input_row_", i)]]
          bg_color <- input[[paste0("select_input_bg_color_", i)]]
          font_color <- input[[paste0("select_font_input_color_", i)]]
          
          if (is.null(text_val) || text_val == "" || 
              is.null(col_val) || col_val == "" || 
              is.null(row_val) || row_val == "") {
            next
          }
          
          custom_style <- createStyle(
            fontColour = col2hex(font_color,"black"),
            fgFill = col2hex(bg_color,"white")
          )
          
          if (grepl("^=", text_val)) {
            # for formulas
            writeFormula(
              wb,
              "First Sheet",
              x = text_val,
              xy = c(col_val, row_val)
            )
          } else {
            # for plain text
            writeData(
              wb,
              "First Sheet",
              x = text_val,
              xy = c(col_val, row_val)
            )
          }
          
          addStyle(wb,"First Sheet", style=custom_style, cols=col_to_num(col_val), rows=col_to_num(row_val))
          
        }
        
        saveWorkbook(wb, file, overwrite = TRUE)
        
        
      })
    
  })
}