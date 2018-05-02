## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Function for simulating an AR process

# Function written by Nordman for generating an AR time series
genAR <- function(n, parm, mu = 0, B = 500){
  
  ## n is the sample size
  ## parm is a vector of p AR parameters phi1,...,phip (order matters)
  ## mu is the mean of process, default is 0
  ## B is burn-in length, B=500 is default, B>p must hold
  
  p <- length(parm)
  
  #### set your distribution here
  ####
  
  M <- B + n
  
  e <- rnorm(M)
  #e <- rchisq(M, 1) - 1
  #e <- rbinom(M,1, .5) - .5
  
  y <- e
  
  for(i in (p + 1):M){
    s <- 0
    for(j in 1:p){
      s <- s + (parm[j]*y[i-j])
    }
    y[i] <- e[i] + s
  }
  
  y <- y[(B+1):M] + mu
  
  return(y)
}