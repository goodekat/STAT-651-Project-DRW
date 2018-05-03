## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for running moving block boostrap simulations for 
## the mean and median with MA and AR processes

# Source in the functions for performing the simulations
source("./code/functions/mbbMAsim.R")
source("./code/functions/mbbARsim.R")

# MA simulation with 500 Monte Carlo replicates and save the time
start_time <- Sys.time()
resMA <- lapply(1:10, FUN = mbbMAsim, n = 400, M = 500, K = 1000)
end_time <- Sys.time()
timeMA <- end_time - start_time

# AR simulation with 500 Monte Carlo replicates and save the time
start_time <- Sys.time()
resAR <- lapply(1:10, FUN = mbbARsim, n = 400, M = 500, K = 1000)
end_time <- Sys.time()
timeAR <- end_time - start_time
