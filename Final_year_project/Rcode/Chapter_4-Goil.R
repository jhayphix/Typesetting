# Import modules
library(readxl)
library(tseries)
library(ggplot2)
library(forecast)
library(quantmod) # Package for volatility

# --------------------------------------------------
# Root
# --------------------------------------------------
# Define a list containing color groups
colors <- list(
  blue = c("blue", "skyblue", "dodgerblue", "navy"),
  green = c("green", "forestgreen", "limegreen", "darkgreen"),
  purple = c("purple", "darkorchid", 
             "mediumorchid","blueviolet"),
  red = c("red","maroon", "firebrick", "indianred", "darkred"),
  orange = c("orange", "darkorange", "orangered"),
  yellow = c("yellow", "gold", "khaki")
)
colors_def <- list(
  blue = colors$blue[3],
  red = colors$red[2]
)
diesel_col <- colors_def$blue
super_col <- colors_def$red
lwd_def <- 3

  
# --------------------------------------------------
# Data collection
# --------------------------------------------------
# Read data
data_path <- "//mac/Home/Documents/_Typesetting/Final_year_project/Rcode/Datasource/Goil.xlsx"
goil_data <- read_excel(data_path)
attach(goil_data)


# --------------------------------------------------
# Data Preprocessing
# --------------------------------------------------
missing_values <- sum(is.na(goil_data$Diesel)) + sum(is.na(goil_data$Super))

# ... Convert data to time series object
diesel <- ts(Diesel, start=c(2018, 1), frequency=12)
super <- ts(Super, start=c(2018, 1), frequency=12)

# ... Visualize data
plot(diesel, main="Time Series Plot of Diesel Prices", ylab="Price", xlab="Year", lwd=lwd_def, col=diesel_col)
plot(super, main="Time Series Plot of Super Prices", ylab="Price", xlab="Year", lwd=lwd_def, col=super_col)

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



