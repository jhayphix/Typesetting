# Imports modules
library(readxl)
library(tseries)
library(ggplot2)
library(forecast)
library(seastest)

# --------------------------------------------------
# Root
# --------------------------------------------------
root_path <- ""

source("//mac/Home/Documents/_Typesetting/Final_year_project/Rcode/Rscripts/module.R")

# --------------------------------------------------
# Read data
# --------------------------------------------------

data_path <- "//mac/Home/Documents/_Typesetting/Final_year_project/Rcode/Datasource/Petroleum.xlsx"
data_frame <- read_excel(data_path)
attach(data_frame)


# --------------------------------------------------
# Original Series
# --------------------------------------------------

# Read original series
gasoline <- ts(Gasoline, start=c(2000,1), frequency=1)
gasoil <- ts(Gasoil, start=c(2000,1), frequency=1)

# Plot original series
plot(gasoline, main="Plot of Gasoline Series", ylab="Gasoline", xlab="Years", lwd=2, col="blue")
plot(gasoline, main="Plot of Gasoline Series", ylab="Gasoil", xlab="Years", lwd=2, col="maroon")

# Check for stationarity
adf.test(gasoline)
pp.test(gasoline)
kpss.test(gasoline)  # Gasoline not stationary

adf.test(gasoil)
pp.test(gasoil)
kpss.test(gasoil) # Gasoil not stationary


# --------------------------------------------------
# Difference Series
# --------------------------------------------------
# Read differenced series
gasoline_diff <- diff(gasoline)
gasoil_diff <- diff(gasoil)

# Plot differenced series
plot(gasoline_diff, main="Plot of Differenced Gasoline Series", ylab="Gasoline", xlab="Years", lwd=2, col="blue")
plot(gasoil_diff, main="Plot of Differenced Gasoil Series", ylab="Gasoil", xlab="Years", lwd=2, col="maroon")

# Check for stationarity
adf.test(gasoline_diff)
pp.test(gasoline_diff)
kpss.test(gasoline_diff)  # Gasoline not stationary

adf.test(gasoil_diff)
pp.test(gasoil_diff)
kpss.test(gasoil_diff) # Gasoil not stationary






