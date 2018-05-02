## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Function for generate bootstrap sample using DRW

# library needed library
library('MASS')

DRW_bootstrap=function(X,l=5){
  # sample size
  n=length(X)
  
  # calucate (i-j)/d
  I=matrix(rep(1:n,n),ncol=n)
  J=matrix(rep(1:n,each=n),ncol=n)
  D=(I-J)/l
  
  # evaluate using bartlett window function
  K=1-abs(D)
  K[K<0]=0
  
  # generate Y(t), Z(t) and W(t) in the paper
  Y=mvrnorm(n=1,mu=rep(0,n),Sigma=K)
  Z=(Y+sqrt(1+sqrt(2)))^2
  W=Z/sum(Z)
  
  # generate bootstrap sample with weighted probability
  sample(X,replace=TRUE,prob=W)
}
