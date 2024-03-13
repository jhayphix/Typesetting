

# Staionarity test
testStat <- function(data) {
  if (missing(data)) {
    cat("Please provide the data\n")
    return(NULL)
  } else {
    adt_test <- adf.test(data)
    pp_test <- pp.test(data)
    kpss_test <- kpss.test(data)
    
    results <- data.frame(
      'ADF Statistic' = adt_test$statistic,
      'ADF p-value' = adt_test$p.value,
      'PP Statistic' = pp_test$statistic,
      'PP p-value' = pp_test$p.value,
      'KPSS Statistic' = kpss_test$statistic,
      'KPSS p-value' = kpss_test$p.value
    )
    
    print(results)
    
    adf_stationary <- adt_test$p.value < 0.05
    pp_stationary <- pp_test$p.value < 0.05
    kpss_stationary <- kpss_test$p.value > 0.05
    
    stationary <- adf_stationary & pp_stationary & kpss_stationary
    
    if (stationary) {
      cat("The series is stationary.\n")
    } else {
      cat("The series is not stationary.\n")
    }
    
    return(list(adt_test = adt_test, pp_test = pp_test, kpss_test = kpss_test, stationary = stationary))
  }
}

