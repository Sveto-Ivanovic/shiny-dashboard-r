library(shiny)
library(bslib)
library(ggplot2)
library(shinyjs)

data_dir <- "dataset"

csv_files <- list.files(path = data_dir, pattern = "\\.csv$", full.names = TRUE)

loaded_datasets <- lapply(csv_files, read.csv)

names(loaded_datasets) <- tools::file_path_sans_ext(basename(csv_files))

