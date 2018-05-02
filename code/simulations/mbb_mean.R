## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for moving block boostrap simulation for the mean
  
# Source in the moving block bootstrap sample function
source("./code/functions/mbbsample.R")

# Set a seed
set.seed(200)



# Number of Monte Carlo replicates
M <- 2000

# Number of bootstrap samples
K <- 1000

# Create empty vectors to store the bootstrap variances and results in
var <- numeric(M)
res <- numeric(M)

# Perform the simulation for the mean
for (j in 1:M){
  
  # Set seed
  set.seed(j)
  
  # Generate the irregular data
  dataMA <- genMA_irr(n = 400, parm = c(-1, 0.7))
  
  xbar <- numeric(K)
  med <- numeric(K)
  
  for (i in 1:K) {
    sample <- mbbsample(data = dataMA$X, b = 10)
    xbar[i] <- mean(sample)
    med[i] <- median(sample)
  }
  mean_var[j] <- var(xbar)
  mean_res[j] <- quantile(xbar[j], probs = 0.025) <= 0 & 0 <= quantile(xbar[j]), probs = 0.975)
  mean_var[j] <- var(med)
  mean_res[j] <- quantile(xbar[j], probs = 0.025) <= -0. & 0 <= quantile(xbar[j]), probs = 0.975)
}

# Proportion of times 0 falls in the 95% bootstrap confidence interval
sum(res) / M

# MSE for variance of the sampling distribution of the mean
sum((var - (1 / 250))^2) / M
