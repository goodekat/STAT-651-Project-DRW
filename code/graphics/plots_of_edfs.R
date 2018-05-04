## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for creating plots of edfs

# Set the sample size
n = 400  

# Set the number of Monte Carlo replicates
M = 1

# Set the number of bootstrap samples
K = 1000

# Set the number of blocks/bandwidth
b = 10

## ----------------------------------------------------------------
## MBB with MA data
## ----------------------------------------------------------------

# Source in the moving block bootstrap sample function
source("./code/functions/mbbsample.R")
source("./code/functions/genMAirr.R")

# Perform the simulation for the mean
for (j in 1:M){
  
  # Set seed
  set.seed(j)
    
  # Generate an irregular data sample
  dataMA <- genMAirr(n = n, parm = c(-1, 0.7))
    
  # Create empty vectors
  mbb_ma_xbar <- numeric(K)
  mbb_ma_med <- numeric(K)
    
  # Obtain block bootstrap samples and compute the means and medians
  for (i in 1:K) {
    sample <- mbbsample(data = dataMA$X, b = b)
    mbb_ma_xbar[i] <- mean(sample)
    mbb_ma_med[i] <- median(sample)
  }

}

## -----------------------------------------------------------------
## Plots of Empirical Distributions
## -----------------------------------------------------------------
  
t <- seq(-2, 2, .01)
dis.mmb <- t
for(i in 1:length(t)){
  dis.mmb[i] <- length(mbb_ma_med[mbb_ma_med <= t[i]]) / 1000
}
plot(t, dis.mmb, lty = 3, lwd = 2)
  
  
  