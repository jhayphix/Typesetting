
# Imports modules
library(readxl)
library(tseries)
library(ggplot2)
library(forecast)

# --------------------------------------------------
# Modules
# --------------------------------------------------
colors <- list(
  red = "\033[31m",green = "\033[32m",yellow = "\033[33m",
  blue = "\033[34m",white = "\033[97m",cyan = "\033[36m",
  reset = "\033[0m"
)
print_colored <- function(text, color) {
  cat(paste0(colors[[color]], text, colors$reset))
}
hline <- function(color="cyan"){
  type_dash <- "-------------*********-----------------"
  print_colored(type_dash, color); cat("\n")
}
URTest <- function (data) {
  hline(); print(adf.test(data))
  hline(); print(pp.test(data))
  hline(); print(kpss.test(data))
}

# --------------------------------------------------
# Read data
# --------------------------------------------------
data_path <- "//mac/Home/Documents/_Typesetting/Final_year_project/Rcode/Datasource/Petroleum.xlsx"
data_frame <- read_excel(data_path)
#attach(data_frame)


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
URTest(gasoline)
URTest(gasoil)


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
URTest(gasoline_diff)



