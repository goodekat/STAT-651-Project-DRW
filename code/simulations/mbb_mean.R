## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for moving block boostrap simulation for the mean
  
# Source in the moving block bootstrap sample function
source("./code/functions/mbbsample.R")

# Load in the data
data_AR_lambda18 <- read.csv("./data/data_AR_lambda18.csv")
data_AR_lambda36 <- read.csv("./data/data_AR_lambda36.csv")
data_MA_lambda18 <- read.csv("./data/data_MA_lambda18.csv")
data_MA_lambda36 <- read.csv("./data/data_MA_lambda36.csv")

# Number of Monte Carlo replicates
M <- 1000

# Number of bootstrap samples
K <- 1000

# Create empty vectors to store the bootstrap variances and results in
var <- numeric(M)
res <- numeric(M)

# Perform the simulation for the mean
for (j in 1:M){
  xbar <- numeric(K)
  
  for (i in 1:K) {
    sample <- mbbsample(data = data_AR_lambda18$x, b = 10)
    xbar[i] <- mean(sample)
  
    
  }
  
  var[j] <- var(xbar)
  res[j] <- quantile(xbar[j], probs = 0.025) <= 0 & 0 <= quantile(xbar[j]), probs = 0.975)
}

# Proportion of times 0 falls in the 95% bootstrap confidence interval
sum(res) / M

# MSE for variance of the sampling distribution of the mean
sum((var - (1 / 250))^2) / M
