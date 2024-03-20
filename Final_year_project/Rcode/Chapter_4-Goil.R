# Import modules
library(readxl)
library(tseries)
library(ggplot2)
library(forecast)
library(quantmod) # Package for volatility
library(trend)
library(nortest)

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
diesel_ts <- ts(Diesel, start=year_start, frequency=freq)
super_ts <- ts(Super, start=year_start, frequency=freq)

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

# ... Trend analysis test
mk.test(diesel_train)
sens.slope(diesel_train)

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

calculate_criterion <- function(models, criterion = "AIC") {
  min_criterion <- Inf; best_model <- NULL
  
  for (i in seq_along(models)) {
    # Extract criterion value
    crit_value <- if (criterion == "AIC") AIC(models[[i]]) else BIC(models[[i]])
    # Update minimum criterion value and best model
    if (crit_value < min_criterion) {
      min_criterion <- crit_value; best_model <- models[[i]]
    }
  }
  return(best_model)
}

# Competing models for diesel
md_auto <- auto.arima(diesel_train)
md_1 <- Arima(diesel_train, order=c(2,2,2), method="ML")
md_2 <- Arima(diesel_train, order=c(3,2,1), method="ML")
md_3 <- Arima(diesel_train, order=c(0,2,1), method="ML")
md_4 <- Arima(diesel_train, order=c(1,2,0), method="ML")
md_5 <- Arima(diesel_train, order=c(2,2,1), method="ML")
md_6 <- Arima(diesel_train, order=c(1,2,2), method="ML")
md_7 <- Arima(diesel_train, order=c(2,2,0), method="ML")
md_8 <- Arima(diesel_train, order=c(0,2,2), method="ML")
md_9 <- Arima(diesel_train, order=c(1,2,1), method="ML")
md_10 <- Arima(diesel_train, order=c(2,2,3), method="ML")
md_11 <- Arima(diesel_train, order=c(3,2,2), method="ML")
md_12 <- Arima(diesel_train, order=c(2,2,4), method="ML") # Best
md_13 <- Arima(diesel_train, order=c(4,2,2), method="ML")
md_14 <- Arima(diesel_train, order=c(2,2,5), method="ML")
md_15 <- Arima(diesel_train, order=c(5,2,2), method="ML")

diesel_fit <- md_12

md_models <- list(md_auto, md_1, md_2, md_3, md_4, md_5, md_6, md_7, md_8, md_9, md_10, md_11, md_12, md_13, md_14, md_15)
md_low_AIC <- calculate_criterion(md_models, criterion = "AIC")
md_low_BIC <- calculate_criterion(md_models, criterion = "BIC")

# Competing models for Super
ms_auto <- auto.arima(super_train); ms_auto
ms_1 <- arima(super_train, order=c(1,1,0), method="ML")
ms_2 <- arima(super_train, order=c(0,1,1), method="ML")
ms_3 <- arima(super_train, order=c(1,1,1), method="ML")
ms_4 <- arima(super_train, order=c(2,1,0), method="ML")
ms_5 <- arima(super_train, order=c(0,1,2), method="ML")
ms_6 <- arima(super_train, order=c(2,1,1), method="ML")
ms_7 <- arima(super_train, order=c(1,1,2), method="ML")
ms_8 <- arima(super_train, order=c(2,1,2), method="ML")
ms_9 <- arima(super_train, order=c(3,1,0), method="ML")
ms_10 <- arima(super_train, order=c(0,1,3), method="ML")
ms_11 <- arima(super_train, order=c(3,1,1), method="ML")
ms_12 <- arima(super_train, order=c(1,1,3), method="ML") # best
ms_13 <- arima(super_train, order=c(3,1,2), method="ML")
ms_14 <- arima(super_train, order=c(2,1,3), method="ML")
ms_15 <- arima(super_train, order=c(3,1,3), method="ML")

super_fit <- ms_12

ms_models <- list(ms_auto, ms_1, ms_2, ms_3, ms_4, ms_5, ms_6, ms_7, ms_8, ms_9, ms_10, ms_11, ms_12, ms_13, ms_14, ms_15)
ms_low_AIC <- calculate_criterion(ms_models, criterion = "AIC")
ms_low_BIC <- calculate_criterion(ms_models, criterion = "BIC")

# --------------------------------------------------
# Model Diagnostics
# --------------------------------------------------
# Residuals check
checkresiduals(diesel_fit)
checkresiduals(super_fit)

# Normality test
# diesel_residuals <- residuals(diesel_fit)
# super_residuals <- residuals(super_fit)
# 
# shapiro.test(diesel_residuals)
# ad.test(diesel_residuals)



# --------------------------------------------------
# Model Evaluation
# --------------------------------------------------


# --------------------------------------------------
# Forecasting
# --------------------------------------------------

# ... Diesel forecast
diesel_forecast_values <- forecast(diesel_fit, h=length(diesel_test))

plot(diesel_forecast_values, main = "Forecast of Diesel Prices", xlab = "Time", ylab = "Price", col=diesel_col, lwd=2.5)
lines(diesel_ts, col="maroon", lwd=1.2) 
legend("topleft", legend = c("Forecast price", "Diesel price"), col = c(diesel_col, "maroon"), lty = c(1, 2))

# Here

# --------------------------------------------------
# 
# --------------------------------------------------







