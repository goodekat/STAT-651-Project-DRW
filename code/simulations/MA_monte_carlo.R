## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for computing Monte Carlo approximation to the 
## variance of the MA time series 

# Set a seed
set.seed(200)

# Generate the irregular data
dataMA <- genMA_irr(n = 400, parm = c(-1, 0.7))

