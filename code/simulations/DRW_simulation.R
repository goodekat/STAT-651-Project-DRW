## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for DRW simulation for the mean

# Source in the moving block bootstrap sample function
source("./code/functions/DRW.R")
source("./code/functions/genMA_irr.R")
# Set a seed
set.seed(200)



# Number of Monte Carlo replicates
M <- 1

# Number of bootstrap samples
K <- 1000

# Create empty vectors to store the bootstrap variances and results in
mean_var <- numeric(M)
mean_res <- numeric(M)
med_var <- numeric(M)
med_res <- numeric(M)

# Perform the simulation for the mean
for (j in 1:M){
  
  # Set seed
  set.seed(j)
  
  # Generate the irregular data
  dataMA <- genMA_irr(n = 400, parm = c(-1, 0.7))
  
  xbar <- numeric(K)
  med <- numeric(K)
  
  # record length of X
  n <- length(dataMA$X)

  for (i in 1:K) {
    W <- DRW_bootstrap(X = dataMA$X, t = dataMA$t, l = 5, D)
    # calculate bootstrap mean
    xbar[i] <- sum(W*X)
    # median
    Index <- order(X)
    med[i] <- X[which(cumsum(W[Index])>=0.5)[1]]
  }
  
  mean_var[j] <- n*sqrt(n*var(xbar))
  mean_res[j] <- quantile(xbar, probs = 0.025) <= 0 & 0 <= quantile(xbar,probs = 0.975)
  med_var[j] <- n*sqrt(n*var(med))
  med_res[j] <- quantile(xbar, probs = 0.025) <= -0& 0 <= quantile(xbar,probs = 0.975)
}



# Proportion of times 0 falls in the 95% bootstrap confidence interval
sum(mean_res) / M
sum(med_res) / M

# MSE for variance of the sampling distribution of the mean
sum(((mean_var)/sqrt(0.002454288)/400/20-1))^2 / M
sum(((med_var)/sqrt(0.004135431)/400/20-1))^2 / M


t<-seq(-5,5,.01)
dis.mmb<-t
for(i in 1:length(t)){
  dis.mmb[i]<- length(med[med<= t[i]])/1000}
plot(t,dis.mmb,lty=3,lwd=2)

t <- seq(-5,5,.01)
dis <- t
for(i in 1:length(t)){
  dis[i]<- length(medians[medians<= t[i]])/1000}
lines(t,dis,lty=3,lwd=2)

t<-seq(-5,5,.01)
dis.mmb<-t
for(i in 1:length(t)){
  dis.mmb[i]<- length(xbar[xbar<= t[i]])/1000}
plot(t,dis.mmb,lty=3,lwd=2)

t <- seq(-5,5,.01)
dis <- t
for(i in 1:length(t)){
  dis[i]<- length(means[means<= t[i]])/1000}
lines(t,dis,lty=3,lwd=2)

