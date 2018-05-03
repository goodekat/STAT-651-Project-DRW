## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Function for simulating irregular AR time series data

genARirr <- function(n, parm, mu = 0, B = 500){
  
  # Inputs
  # n: sample size for time series with no missing data
  # parm: parameters for the AR process
  # mu: mean of the process (set to 0 by default)
  # B: burn-in (set to 500 by default)
  
  # Source in Nordman's functions for generating MA time processes
  source("./code/functions/genAR.R")
  
  # Generate AR process
  X <- genAR(n, parm, mu, B)
  
  # Create variable for time of observation
  t <- 1:n
  
  # Compute weights
  weights <- sin(pi * (1:n) / n)
  
  # Compute binomial random varibles that determine missing values
  Z <- rbinom(n, 1, weights)
  
  # Put observations, time, and missingness indicator
  data <- data.frame(X = X, t = t, keep = Z) 
  
  # Subset data to only have non-missing values
  data <- subset(data, data$keep == 1)
  
  # Return the irregular MA data
  return(data[,1:2])
  
}

