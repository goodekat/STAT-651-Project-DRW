## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for computing Monte Carlo approximation to the 
## variance of the mean and median of the MA time series 
## (with no missing observations)

# Set the number of Monte Carlo simulations
M <- 100000

## ----------------------------------------------------------
## MA Monte Carlo
## ----------------------------------------------------------

# Source in code for generating a MA time series
source("./code/functions/genMA.R")

# Create empty vectors for saving the means and medians
MAmeans <- numeric(M)
MAmedians <- numeric(M)

for(i in 1:M){
  
  # Set seed
  set.seed(i)
  
  # Generate the regular MA data
  dataMA <- genMA(n = 400, parm = c(-1, 0.7))
  
  # Save the mean and median
  MAmeans[i] <- mean(dataMA)
  MAmedians[i] <- median(dataMA)
  
}

# Monte Carlo approximations to the mean and median of 
# the MA time series
mean(MAmeans)   # -0.000
mean(MAmedians) # -0.188

# Monte Carlo approximations to the variance of the mean
# and median of the MA time series
sd(MAmeans)   # 0.050
sd(MAmedians) # 0.064

## ----------------------------------------------------------
## AR Monte Carlo
## ----------------------------------------------------------

# Source in code for generating an AR time series
source("./code/functions/genAR.R")

# Create empty vectors for saving the means and medians
ARmeans <- numeric(M)
ARmedians <- numeric(M)

for(i in 1:M){
  
  # Set seed
  set.seed(i)
  
  # Generate the regular AR data
  dataAR <- genAR(n = 400, parm = c(-0.1, 0.6))
  
  # Save the mean and median
  ARmeans[i] <- mean(dataAR)
  ARmedians[i] <- median(dataAR)
  
}

# Monte Carlo approximations to the mean and median of 
# the AR time series
mean(ARmeans)   # -0.0003
mean(ARmedians) # -0.0004

# Monte Carlo approximations to the variance of the mean
# and median of the AR time series
sd(ARmeans)   # 0.0995
sd(ARmedians) # 0.1128

