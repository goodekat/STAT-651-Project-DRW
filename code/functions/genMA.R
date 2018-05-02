## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Function for simulating a MA process

# Function written by Nordman for generating a MA time series
genMA <- function(n, parm, mu = 0){
  
  ## n is the sample size
  ## parm is a vector of q MA parameters theta1,...,thetaq (order matters)
  ## mu is the mean of process, default is 0
  
  q <- length(parm)
  
  #### set your distribution here
  M <- q + n
  
  #e <- rnorm(M)
  e <- rchisq(M,1) - 1
  #e <- rbinom(M,1,.5) - .5
  
  y <- e
  
  for(i in (q+1):M){
    s <- 0
    for(j in 1:q){
      s <- s + (parm[j]*e[i-j])
    }
    y[i] <- y[i] + s
  }
  
  y <- y[(q + 1):M] + mu
  
  return(y)
}