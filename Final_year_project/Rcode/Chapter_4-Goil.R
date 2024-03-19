# Import modules
library(readxl)
library(tseries)
library(ggplot2)
library(forecast)

# Read data
data_path <- "//mac/Home/Documents/_Typesetting/Final_year_project/Rcode/Datasource/Goil.xlsx"
dataframe <- read_excel(data_path)
View(dataframe)