# Import modules
library(readxl)
library(tseries)
library(ggplot2)
library(forecast)
library(quantmod) # Package for volatility

# --------------------------------------------------
# Data collection
# --------------------------------------------------
# Read data
data_path <- "//mac/Home/Documents/_Typesetting/Final_year_project/Rcode/Datasource/Goil.xlsx"
goil_data <- read_excel(data_path)
attach(dataframe)


# --------------------------------------------------
# Data Preprocessing
# --------------------------------------------------
missing_values <- sum(is.na(goil_data$Diesel)) + sum(is.na(goil_data$Super))

# ... Convert data to time series object

# ... Visualize data


# --------------------------------------------------
# Splitting Data into Training and Testing Sets
# --------------------------------------------------
# ... Splitting Data into Training and Testing Sets

# --------------------------------------------------
# Exploratory Data Analysis (EDA)
# --------------------------------------------------
# ... Summary statistics

# ... Stationarity

# ... Differencing


# --------------------------------------------------
# Calculate Volatility
# --------------------------------------------------


# --------------------------------------------------
# Correlation
# --------------------------------------------------

# ... Acf plot


# ... Pacf plot


# --------------------------------------------------
#  Model Selection
# --------------------------------------------------


# --------------------------------------------------
# Model Fitting
# --------------------------------------------------
# ... Fit the selected model(s) to the training data.


# --------------------------------------------------
# Model Evaluation
# --------------------------------------------------

# ... Assess model accuracy

# ... Evaluate prediction accuracy.


# --------------------------------------------------
# Forecasting
# --------------------------------------------------


# --------------------------------------------------
# 
# --------------------------------------------------



