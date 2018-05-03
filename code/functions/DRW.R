## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Function for generate bootstrap sample using DRW

# library needed library
library('MASS')

DRW_bootstrap=function(X,t,l=5,D){
  # sample size
  n=length(X)
  
  # calucate (t_i-t_j)/d
  I <- matrix(rep(t,n),ncol=n)
  J <- matrix(rep(t,each=n),ncol=n)
  D <- (I-J)/l
  
  # evaluate using bartlett window function
  K=1-abs(D)
  K[K<0]=0
  
  # generate Y(t), Z(t) and W(t) in the paper
  Y=mvrnorm(n=1,mu=rep(0,n),Sigma=K)
  Z=(Y+sqrt(1+sqrt(2)))^2
  Z/sum(Z)
}
