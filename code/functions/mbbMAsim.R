## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Function for moving block boostrap simulation for the 
## mean and median with MA time series data

mbbMAsim <- function(n, M, K, b){
  
  # Inputs
  # n: sample size for time series with no missing data
  # M: number of Monte Carlo replicates
  # K: number of bootstrap samples
  # b: number of blocks
  
  # Source in the moving block bootstrap sample function
  source("./code/functions/mbbsample.R")
  source("./code/functions/genMAirr.R")
  
  # Create empty vectors to storing the bootstrap results for means
  # and medians
  mean_sd <- numeric(M)
  mean_res <- numeric(M)
  median_sd <- numeric(M)
  median_res <- numeric(M)
  
  # Create an empty vector to store the length of the data
  nj <- numeric(M)
  
  # Perform the simulation for the mean
  for (j in 1:M){
    
    # Set seed
    set.seed(j)
    
    # Generate an irregular data sample
    dataMA <- genMAirr(n = n, parm = c(-1, 0.7))
    
    # Save the length of the data
    nj[j] <- length(dataMA$X)
    
    # Create empty vectors
    xbar <- numeric(K)
    med <- numeric(K)
    
    # Obtain block bootstrap samples and compute the means and medians
    for (i in 1:K) {
      sample <- mbbsample(data = dataMA$X, b = b)
      xbar[i] <- mean(sample)
      med[i] <- median(sample)
    }
    
    # Compute the varianes of the bootstrap means and medians 
    mean_sd[j] <- sd(xbar)
    median_sd[j] <- sd(med)
    
    # Determine whether the true mean/median is in the bootstrap 95% confidence interval
    mean_res[j] <- quantile(xbar, probs = 0.025) <= 0 & 0 <= quantile(xbar, probs = 0.975)
    median_res[j] <- quantile(med, probs = 0.025) <= -0.188 & -0.188 <= quantile(med, probs = 0.975)
    
  }
  
  # Create a data frame with the bootstrap CI coverage and the normalized MSE for 
  # the mean and median
  results <- data.frame(coverage_mean = sum(mean_res) / M,
                        coverage_median = sum(median_res) / M,
                        MSE_mean = (1 / M) * sum(((sqrt(nj) * mean_sd) - (sqrt(n) * 0.050))^2),
                        MSE_median = (1 / M) * sum(((sqrt(nj) * median_sd) - (sqrt(n) * 0.064))^2),
                        norm_MSE_mean = (1 / M) * sum((((nj * sqrt(nj) * mean_sd) / 
                                                          (n * sqrt(n) * 0.050)) - 1)^2),
                        norm_MSE_median = (1 / M) * sum((((nj * sqrt(nj) * median_sd) / 
                                                            (n * sqrt(n) * 0.064)) - 1)^2))
  
  # Return the data frame of results
  return(results)
  
}
