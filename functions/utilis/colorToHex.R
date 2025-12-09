col2hex <- function(color_name, default_col) {
  color_map <- c(
    "red" = "#FF0000",
    "blue" = "#0000FF",
    "green" = "#00FF00",
    "lightblue" = "#ADD8E6",
    "lightgreen" = "#90EE90",
    "yellow" = "#FFFF00",
    "orange" = "#FFA500",
    "pink" = "#FFC0CB",
    "purple" = "#A020F0",
    "magenta" = "#FF00FF",
    "white" = "#FFFFFF",
    "black" = "#000000"
  )
  
  if (color_name %in% names(color_map)) {
    return(color_map[color_name])
  } else {
    return(color_map[default_col])
  }
}

col_to_num <- function(col) {
  if (grepl("^[0-9]+$", col)) {
    return(as.numeric(col))
  }
  
  if (grepl("^[A-Z]+$", toupper(col))) {
    col_upper <- toupper(col)
    
    result <- 0
    for (i in 1:nchar(col_upper)) {
      result <- result * 26 + (utf8ToInt(substr(col_upper, i, i)) - utf8ToInt("A") + 1)
    }
    return(result)
  }
  
  return(NA)
}