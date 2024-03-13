# Define ANSI escape codes for colors
colors <- list(
  red = "\033[31m",
  green = "\033[32m",
  yellow = "\033[33m",
  blue = "\033[34m",
  magenta = "\033[35m",
  cyan = "\033[36m",
  reset = "\033[0m"
)

# Function to print colored text
print_colored <- function(text, color) {
  cat(paste0(colors[[color]], text, colors$reset))
}


# Staionarity test
testStationarity <- function(data) {
  if (missing(data)) {
    print_colored("Please provide the data\n", "cyan")
    print_colored("testStationary(data) \n")
    return(NULL)
  } else {
    adf_test <- adf.test(data)
    pp_test <- pp.test(data)
    kpss_test <- kpss.test(data)
    
    results <- data.frame(
      'ADF Statistic' = adf_test$statistic,
      'ADF p-value' = adf_test$p.value, "\n",
      'PP Statistic' = pp_test$statistic,
      'PP p-value' = pp_test$p.value,"\n",
      'KPSS Statistic' = kpss_test$statistic,
      'KPSS p-value' = kpss_test$p.value
    )
    
    #print(results)
    
    adf_stationary <- adf_test$p.value < 0.05
    pp_stationary <- pp_test$p.value < 0.05
    kpss_stationary <- kpss_test$p.value > 0.05
    
    stationary <- adf_stationary & pp_stationary & kpss_stationary
    
    if (stationary) {
      print_colored("The series is stationary.\n \n", "green")
    } else {
      cat("The series is not stationary.\n \n", "red")
    }
    
    print(list(adf_test = adf_test, pp_test = pp_test, kpss_test = kpss_test, stationary = stationary))
  }
}

testStationarity()
testStationarity(c(1,2,23, 323,234,2))



