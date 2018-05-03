## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for running moving block boostrap simulations for 
## the mean and median with MA and AR processes

# Libraries 
library(dplyr)

# Source in the functions for performing the simulations
source("./code/functions/mbbMAsim.R")
source("./code/functions/mbbARsim.R")

## ------------------------------------------------------------------
## MA Simulation
## ------------------------------------------------------------------

# MA simulation with 500 Monte Carlo replicates and save the time
start_time <- Sys.time()
resMA <- lapply(1:10, FUN = mbbMAsim, n = 400, M = 500, K = 1000)
end_time <- Sys.time()
timeMA <- end_time - start_time

# Convert the results into a dataframe
resMA <- plyr::ldply(resMA, data.frame)
resMA <- resMA %>% rename(blocksize = .id)

# Export the data frame of results
write.csv(resMA, "./data/resMA.R", row.names = FALSE)

## ------------------------------------------------------------------
## AR Simulation
## ------------------------------------------------------------------

# AR simulation with 500 Monte Carlo replicates and save the time
start_time <- Sys.time()
resAR <- lapply(1:10, FUN = mbbARsim, n = 400, M = 500, K = 1000)
end_time <- Sys.time()
timeAR <- end_time - start_time

# Convert the results into a dataframe
resAR <- plyr::ldply(resAR, data.frame)
resAR <- resAR %>% rename(blocksize = .id)

# Export the data frame of results
write.csv(resAR, "./data/resAR.R", row.names = FALSE)

## ------------------------------------------------------------------
## Export times
## ------------------------------------------------------------------

# Export the times it took to run the simulations in a data frame
write.csv(data.frame(MA = timeMA, AR = timeAR), "./data/mbbtimes.csv", row.names = FALSE)
