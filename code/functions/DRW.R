library('MASS')
#### Generate data ####
source('gents.R')

X=genAR(100,0.5,sigma=1)
n=length(X)
#### Generate W ####
#Z
l=5
I=matrix(rep(1:n,each=n),ncol=n)
J=matrix(rep(1:n,n),ncol=n)
D=(I-J)/l
# should use bartlett window?
K=exp(-D^2)


#### One bootstrap sample ####
# X is the time series
# W is the W(t) is the Kernel value
generate_bootstrap=function(X,K){
  n=length(X)
  
  Y=mvrnorm(n=1,mu=rep(0,n),Sigma=K)
  Z=(Y+sqrt(1+sqrt(2)))^2
  W=Z/sum(Z)
  
  sample(X,replace=TRUE,prob=W)
}
