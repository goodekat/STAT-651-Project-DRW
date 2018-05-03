## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for running moving block boostrap simulations for the mean and median

source("./code/functions/mbbsim.R")

mbbsim(n = 400, M = 2000, K = 1000, b = 10)

res <- lapply(1:10, FUN = mbbsim, n = 400, M = 2000, K = 1000)
