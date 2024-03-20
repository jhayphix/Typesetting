# Import modules
library(readxl)
library(tseries)
library(ggplot2)
library(forecast)
library(quantmod) # Package for volatility

# --------------------------------------------------
# Root
# --------------------------------------------------
year_start = c(2018, 1)
year_end = c(2024, 3)
freq = 12

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
diesel_ts <- ts(Diesel, start=year_start, frequency=feq)
super_ts <- ts(Super, start=year_start, frequency=feq)

# ... Splitting Data into Training and Testing Sets
train_size <- 0.8  # 80% training data, 20% testing data
num_obs <- length(diesel_ts)
train_index <- 1:round(train_size * num_obs)
test_index <- (round(train_size * num_obs) + 1):num_obs

diesel_train <- ts(diesel_ts[train_index], start=year_start, frequency=freq)
diesel_test <- ts(diesel_ts[test_index], end=year_end, frequency=freq)

super_train <- ts(super_ts[train_index], start=year_start, frequency=freq)
super_test <- ts(super_ts[test_index], start=year_start, frequency=freq)

# ... Visualize data
plot(diesel_ts, main="Time Series Plot of Diesel Prices", ylab="Price", xlab="Year", lwd=lwd_def, col=colors$green[2], ylim = range(c(diesel_train, diesel_test)))
lines(diesel_train, lwd=lwd_def, col=diesel_col)

plot(super_ts, main="Time Series Plot of Super Prices", ylab="Price", xlab="Year", lwd=lwd_def, col=colors$green[2], ylim = range(c(super_train, super_test)))
lines(super_train, lwd=lwd_def, col=super_col)

# --------------------------------------------------
# Exploratory Data Analysis (EDA)
# --------------------------------------------------
# ... Summary statistics
summary(diesel_train)
summary(super_train)

# ... Stationarity
stationaryTest <- function(data, title=""){
  line = "\n ---------- ***** ----------- \n"
  cat(line); cat(title) ; cat(line)
  adf = adf.test(data); print(adf); cat(line)
  pp = pp.test(data); print(pp); cat(line)
  kpss = kpss.test(data); print(kpss); cat(line)
}
stationaryTest(diesel_train, "Diesel Training")
stationaryTest(super_train, "Super Training")

# ... Differencing
ndiffs(diesel_train)
ndiffs(super_train)
diesel_train_diff <- diff(diff(diesel_train))
super_train_diff <- diff(super_train)

# ... Visualize differenced data
plot(diesel_train_diff, main="Time Series Plot of Differenced Diesel Prices", ylab="Price", xlab="Year", lwd=lwd_def, col=diesel_col)
plot(super_train_diff, main="Time Series Plot of Differenced Super Prices", ylab="Price", xlab="Year", lwd=lwd_def, col=super_col)

stationaryTest(diesel_train_diff)
stationaryTest(super_train_diff)


# --------------------------------------------------
# Calculate Volatility
# --------------------------------------------------
diesel_volatility <- sd(diesel_train)
super_volatility <- sd(super_train)


# --------------------------------------------------
# Correlation
# --------------------------------------------------
acf(diesel_train_diff, main="ACF plot of Diesel Prices Series", lwd=lwd_def, col="black")

pacf(diesel_train_diff, main="PACF plot of Diesel Prices Series", lwd=lwd_def, col="black")


acf(super_train_diff, main="ACF plot of Super Prices Series", lwd=lwd_def, col=super_col)

pacf(super_train_diff, main="ACF plot of Super Prices Series", lwd=lwd_def, col=super_col)
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




