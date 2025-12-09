
# Understanding the shiny-dashboard-r Project

This document provides a comprehensive overview of the `shiny-dashboard-r` project, a Shiny application for data visualization and reporting. The following guide is tailored for **Ubuntu 22.04** and is intended as a learning experience to understand the structure and functionality of this R-based web application.

## Project Overview

The `shiny-dashboard-r` repository contains a modular and well-structured Shiny application. This application is designed to load CSV datasets, perform statistical analysis, and generate reports in both Microsoft Word and Excel formats. The user interface is organized into multiple tabs, providing a clear and intuitive workflow for users.

The project demonstrates best practices in Shiny development, such as modularization of UI and server components, use of `renv` for a reproducible R environment, and custom theming to enhance the application's appearance.

### Key Features

The application offers the following key features:

| Feature                  | Description                                                                                                      |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| **Data Loading**         | The application can load and process multiple CSV files from a designated `dataset` directory.                   |
| **Interactive Tables**   | Users can view and select from the loaded datasets, which are presented in an interactive table format.          |
| **Statistical Analysis** | The application provides tools for performing statistical calculations and aggregations on the selected data.    |
| **Report Generation**    | Users can generate and download reports in both Microsoft Word (.docx) and Excel (.xlsx) formats.                |
| **Customizable UI**      | The user interface is built with a custom theme and is organized into a multi-tab layout for ease of navigation. |

---

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

Then, install system libraries required by the R packages used in this project:

```bash
sudo apt-get update
sudo apt-get install libcairo2-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libharfbuzz-dev libfribidi-dev libwebp-dev
```

---

## Installing R Packages Using `renv.lock` (Recommended)

This project uses **renv** to ensure that all required R packages are installed with the exact versions used by the developer.

After cloning the repository (see next section), follow these steps:

### 1. Install the `renv` package (if not already installed)

```r
install.packages("renv")
```

### 2. Set your working directory to the project folder

```r
setwd("path/to/shiny-dashboard-r")
```

### 3. Restore all packages listed in `renv.lock`

```r
renv::restore()
```

What this does:

* Reads the `renv.lock` file
* Installs the exact package versions needed
* Recreates the project’s isolated R library in `renv/library/`
* Ensures full reproducibility

If any system libraries are missing, `renv` will show clear error messages.
Simply install the missing system packages via `apt`, then run:

```r
renv::restore()
```

again.

---

### Downloading and Running the Application

1. **Download the repository:**

```bash
git clone https://github.com/Sveto-Ivanovic/shiny-dashboard-r.git
```

2. **Navigate to the project directory:**

```bash
cd shiny-dashboard-r
```

3. **Install packages via renv (if not done yet):**

```r
renv::restore()
```

4. **Run the application:**

In RStudio, click **Run App**, or run this from an R session:

```r
shiny::runApp()
```

---

## Code Structure Explained

The project is organized into several files and directories, each with a specific purpose. This modular structure makes the code easier to understand, maintain, and extend.

| File/Directory | Description                                                       |
| -------------- | ----------------------------------------------------------------- |
| `global.R`     | Loaded before the app starts. Imports libraries and initial data. |
| `ui.R`         | Defines the user interface layout and components.                 |
| `server.R`     | Contains the server-side logic and reactive processes.            |
| `components/`  | Modular UI components used to build the application.              |
| `functions/`   | Modular server functions for clean, reusable logic.               |
| `dataset/`     | Contains CSV files used by the app.                               |
| `renv/`        | Managed by renv; stores the project’s isolated package library.   |
| `renv.lock`    | Defines exact package versions for reproducibility.               |
| `www/`         | Contains web assets like CSS, JavaScript, images.                 |
