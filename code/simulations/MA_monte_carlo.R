## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for computing Monte Carlo approximation to the 
## variance of the mean and median of the MA time series 
## (with no missing observations)

# Set the number of Monte Carlo simulations
M <- 10000

# Create empty vectors for saving the means and medians
means <- numeric(M)
medians <- numeric(M)

for(i in 1:M){
  
  # Generate the regular MA data
  dataMA <- genMA(n = 400, parm = c(-1, 0.7))
  
  # Save the mean and median
  means[i] <- mean(dataMA)
  medians[i] <- median(dataMA)
  
}

# Monte Carlo approximations to the mean and median of 
# the MA time series
mean(means)
mean(medians)

# Monte Carlo approximations to the variance of the mean
# and median of the MA time series
var(means)
var(medians)
