## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for running moving block boostrap simulations for 
## the mean and median with MA and AR processes

# Libraries 
library(dplyr)
library(ggplot2)

# Source in the functions for performing the simulations
source("./code/functions/mbbMAsim.R")
source("./code/functions/mbbARsim.R")

## ------------------------------------------------------------------
## MA Simulation
## ------------------------------------------------------------------

# MA simulation with 500 Monte Carlo replicates and save the time
start_time <- Sys.time()
resMAmbb <- lapply(1:10, FUN = mbbMAsim, n = 400, M = 500, K = 1000)
end_time <- Sys.time()
timeMA <- end_time - start_time

# Convert the results into a dataframe
resMAmbb <- plyr::ldply(resMAmbb, data.frame)

# Add a variable for blocksize
resMAmbb$blocksize <- 1:10

# Reorder the variables
resMAmbb <- resMAmbb %>% select(blocksize, 1:6)

# Export the data frame of results
write.csv(resMAmbb, "./data/resMAmbb.csv", row.names = FALSE)

## ------------------------------------------------------------------
## AR Simulation
## ------------------------------------------------------------------

# AR simulation with 500 Monte Carlo replicates and save the time
start_time <- Sys.time()
resARmbb <- lapply(1:10, FUN = mbbARsim, n = 400, M = 500, K = 1000)
end_time <- Sys.time()
timeAR <- end_time - start_time

# Convert the results into a dataframe
resARmbb <- plyr::ldply(resARmbb, data.frame)

# Add a variable for blocksize
resARmbb$blocksize <- 1:10

# Reorder the variables
resARmbb <- resARmbb %>% select(blocksize, 1:6)

# Export the data frame of results
write.csv(resARmbb, "./data/resARmbb.csv", row.names = FALSE)

## ------------------------------------------------------------------
## Export times
## ------------------------------------------------------------------

# Export the times it took to run the simulations in a data frame
write.csv(data.frame(MA = timeMA, AR = timeAR), "./data/mbbtimes.csv", row.names = FALSE)
