## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for moving block boostrap simulation for the mean
  
# Source in the moving block bootstrap sample function
source("./code/functions/mbbsample.R")

# Number of Monte Carlo replicates
M <- 2000

# Number of bootstrap samples
K <- 1000

# Create empty vectors to storing the bootstrap results for means
# and medians
mean_var <- numeric(M)
mean_res <- numeric(M)
median_var <- numeric(M)
median_res <- numeric(M)

# Perform the simulation for the mean
for (j in 1:M){
  
  # Set seed
  set.seed(j)
  
  # Generate an irregular data sample
  dataMA <- genMA_irr(n = 400, parm = c(-1, 0.7))
  
  # Create empty vectors 
  xbar <- numeric(K)
  med <- numeric(K)
  
  # Obtain block bootstrap samples and compute the means and medians
  for (i in 1:K) {
    sample <- mbbsample(data = dataMA$X, b = 10)
    xbar[i] <- mean(sample)
    med[i] <- median(sample)
  }
  
  # Compute the varianes of the bootstrap means and medians 
  mean_var[j] <- var(xbar)
  median_var[j] <- var(med)
  
  # Determine whether the true mean/median is in the bootstrap 95% confidence interva
  mean_res[j] <- quantile(xbar[j], probs = 0.025) <= 0 & 0 <= quantile(xbar[j], probs = 0.975)
  median_res[j] <- quantile(xbar[j], probs = 0.025) <= -0.188 & -0.188 <= quantile(xbar[j], probs = 0.975)

}

# Proportion of times 0 falls in the 95% bootstrap confidence interval for the mean
sum(mean_res) / M

# Proportion of times -0.188 falls in the 95% bootstrap confidence interval for the median
sum(median_res) / M

# Normalized MSE for variance of the mean
(1 / M) * sum(((() / ()) - 1)^2)

