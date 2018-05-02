
source("./code/functions/mbbsim.R")

mbbsim(n = 400, M = 2000, K = 1000, b = 10)

lapply(1:10, FUN = mbbsim, n = 400, M = 2, K = 1000)