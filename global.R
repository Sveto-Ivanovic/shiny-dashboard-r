library(shiny)
library(bslib)
library(ggplot2)
library(shinyjs)
library(shinydashboard)
library(readxl)
library(rmarkdown)
library(reactable)
library(dplyr)
library(flextable)
library(openxlsx)
source("functions/utilis/colorToHex.R")



data_dir <- "dataset"

csv_files <- list.files(path = data_dir, pattern = "\\.csv$", full.names = TRUE)

loaded_datasets <- lapply(csv_files, read.csv)

names(loaded_datasets) <- tools::file_path_sans_ext(basename(csv_files))


set_flextable_defaults(
  font.family = "Arial", font.size = 10, 
  border.color = "gray", big.mark = "")
