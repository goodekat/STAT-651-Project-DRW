## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Function for simulating irregular MA time series data

genMAirr <- function(n, parm, mu = 0){
  
  # Source in Nordman's functions for generating MA time processes
  source("./code/functions/genMA.R")
  
  # Generate MA process
  X_ma <- genMA(n, parm, mu)
  
  # Create variable for time of observation
  t <- 1:n
  
  # Compute weights
  weights <- sin(pi * (1:n) / n)
  
  # Compute binomial random varibles that determine missing values
  Z <- rbinom(n, 1, weights)
  
  # Put observations, time, and missingness indicator
  data <- data.frame(X = X_ma, t = t, keep = Z) 
  
  # Subset data to only have non-missing values
  data <- subset(data, data$keep == 1)
  
  # Return the irregular MA data
  return(data[,1:2])
  
}

