# Understanding the shiny-dashboard-r Project

This document provides a comprehensive overview of the `shiny-dashboard-r` project, a Shiny application for data visualization and reporting. The following guide is tailored for **Ubuntu 22.04** and is intended as a learning experience to understand the structure and functionality of this R-based web application.

## Project Overview

The `shiny-dashboard-r` repository contains a modular and well-structured Shiny application. This application is designed to load CSV datasets, perform statistical analysis, and generate reports in both Microsoft Word and Excel formats. The user interface is organized into multiple tabs, providing a clear and intuitive workflow for users.

The project demonstrates best practices in Shiny development, such as modularization of UI and server components, use of `renv` for a reproducible R environment, and custom theming to enhance the application's appearance.

### Key Features

The application offers the following key features:

| Feature | Description |
|---|---|
| **Data Loading** | The application can load and process multiple CSV files from a designated `dataset` directory. |
| **Interactive Tables** | Users can view and select from the loaded datasets, which are presented in an interactive table format. |
| **Statistical Analysis** | The application provides tools for performing statistical calculations and aggregations on the selected data. |
| **Report Generation** | Users can generate and download reports in both Microsoft Word (.docx) and Excel (.xlsx) formats. |
| **Customizable UI** | The user interface is built with a custom theme and is organized into a multi-tab layout for ease of navigation. |

## Getting Started on Ubuntu 22.04

To get the application running on your local machine, you will need to install the necessary prerequisites and then download the project files.

### Prerequisites

Before running the application, you need to have R and several system libraries installed. The `README.md` file in the repository provides a starting point for the necessary dependencies.

First, install R on your system. You can follow the official instructions on the [R Project website](https://cran.r-project.org/).

Next, open an R session and install the `webshot` package and its dependency, PhantomJS:

```R
install.packages("webshot")
webshot::install_phantomjs()
```

Then, you will need to install several system libraries that are required by the R packages used in this project. Open a terminal and run the following commands:

```bash
sudo apt-get update
sudo apt-get install libcairo2-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libharfbuzz-dev libfribidi-dev libwebp-dev
```

The project also uses a number of R packages for its functionality. These are listed in the `global.R` file and are managed by the `renv` package. When you first open the project in RStudio, `renv` should prompt you to install the required packages. If not, you can install them manually by running the following in an R session within the project directory:

```R
renv::restore()
```
Additionally you might need to install other system libraries that are not present here, but will be intuitive to install via warnings/errors when using ```renv::restore()```.

### Downloading and Running the Application

1.  **Download the repository:**

    You can download the project files using `git`. Open a terminal and run:

    ```bash
    git clone https://github.com/Sveto-Ivanovic/shiny-dashboard-r.git
    ```

2.  **Navigate to the project directory:**

    ```bash
    cd shiny-dashboard-r
    ```

3.  **Run the application:**

    You can run the application by opening the `ui.R`, `server.R`, or `global.R` file in RStudio and clicking the "Run App" button. Alternatively, you can run the following command in an R session from within the project directory:

    ```R
    shiny::runApp()
    ```

## Code Structure Explained

The project is organized into several files and directories, each with a specific purpose. This modular structure makes the code easier to understand, maintain, and extend.

| File/Directory | Description |
|---|---|
| `global.R` | This file is executed before the application starts. It loads all the necessary libraries and sources the initial data. |
| `ui.R` | This file defines the user interface of the application. It sets up the layout, navigation, and includes the UI components from the `components/` directory. |
| `server.R` | This file contains the server-side logic of the application. It handles user input, performs calculations, and generates the output that is displayed in the UI. |
| `components/` | This directory contains the modular UI components that are used to build the user interface. Each file in this directory defines a specific part of the UI. |
| `functions/` | This directory contains the modular server-side functions that are called from the `server.R` file. This helps to keep the server logic organized and reusable. |
| `dataset/` | This is where the application looks for CSV files to load. You can place your own CSV files in this directory to analyze them with the application. |
| `renv/` | This directory is managed by the `renv` package and contains the project's private R library. This ensures that the project uses the correct versions of the required packages. |
| `renv.lock` | This file records the exact versions of all R packages used in the project, ensuring reproducibility. |
| `www/` | This directory is for web assets such as CSS files, images, and JavaScript files. |