## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for DRW simulation
rm(list = ls())
source("./code/functions/DRW.R")
source("./code/functions/genARirr.R")
library('parallel')
# Set a seed
set.seed(200)


DRW_simulation=function(M, K, l){
  ## input:
  # M: Number of Monte Carlo replicates
  # K: Number of bootstrap samples
  # l: w(t) are l-dependent
  
  # Create empty vectors to store the bootstrap variances and results in
  mean_var1 <- numeric(M)
  mean_var2 <- numeric(M)
  mean_res <- numeric(M)
  med_var1 <- numeric(M)
  med_var2 <- numeric(M)
  med_res <- numeric(M)
  
  # Perform the simulation for the mean
  for (j in 1:M){
    
    # Set seed
    set.seed(j)
    
    # Generate the irregular data
    dataMA <- genARirr(n = 400, parm =c(-0.1, 0.6))
    X=dataMA$X
    
    # Create empty vectors to store bootstrap statistics
    xbar <- numeric(K)
    med <- numeric(K)
    
    # record length of X
    n <- length(dataMA$X)
    
    for (i in 1:K) {
      W <- DRW_bootstrap(X = dataMA$X, t = dataMA$t, l = l)
      # calculate bootstrap mean
      xbar[i] <- sum(W*X)
      # median
      Index <- order(X)
      id=Index[which(cumsum(W[Index])>=0.5)[1]]
      med[i] <- X[id]
    }
    
    mean_var1[j] <- n*sqrt(n*var(xbar))
    mean_var2[j] <- sqrt(n*var(xbar))
    mean_res[j] <- quantile(xbar, probs = 0.025) <= 0 & 0 <= quantile(xbar,probs = 0.975)
    med_var1[j] <- n*sqrt(n*var(med))
    med_var2[j] <- sqrt(n*var(med))
    med_res[j] <- quantile(xbar, probs = 0.025) <= 0 & 0 <= quantile(xbar,probs = 0.975)
  }
  
  # Proportion of times 0 falls in the 95% bootstrap confidence interval
  coverage_mean <- sum(mean_res) / M
  coverage_median <- sum(med_res) / M
  
  # MSE for variance of the sampling distribution of the mean
  meanMSE_v1 <- sum(((mean_var1)/0.0995/400/20-1)^2) / M
  medianMSE_v1 <- sum(((med_var1)/0.1128/400/20-1)^2) / M
  
  meanMSE_v2 <- sum((mean_var2-0.0995*20)^2) / M
  medianMSE_v2 <- sum((med_var2-0.1128*20)^2) / M
  
  # return the results
  c(coverage_mean,coverage_median,meanMSE_v1,medianMSE_v1,meanMSE_v2,
    medianMSE_v2)
}

# conduct simulation by parallel 
result=mclapply(1:10,DRW_simulation,mc.cores=16,M=500,K=1000)
result=do.call(rbind,result)

write.csv(result, "./data/resAR_DRW.csv", row.names = FALSE)

# draw the cdf for median
# t<-seq(-5,5,.01)
# dis.mmb<-t
# for(i in 1:length(t)){
#   dis.mmb[i]<- length(med[med<= t[i]])/1000}
# plot(t,dis.mmb,lty=3,lwd=2)
# 
# t <- seq(-5,5,.01)
# dis <- t
# for(i in 1:length(t)){
#   dis[i]<- length(medians[medians<= t[i]])/1000}
# lines(t,dis,lty=3,lwd=2)
# 
# # draw the cdf for mean
# t<-seq(-5,5,.01)
# dis.mmb<-t
# for(i in 1:length(t)){
#   dis.mmb[i]<- length(xbar[xbar<= t[i]])/1000}
# plot(t,dis.mmb,lty=3,lwd=2)
# 
# t <- seq(-5,5,.01)
# dis <- t
# for(i in 1:length(t)){
#   dis[i]<- length(means[means<= t[i]])/1000}
# lines(t,dis,lty=3,lwd=2)

