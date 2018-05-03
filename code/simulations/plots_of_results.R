
# Plots
t<-seq(-5,5,.01)
dis.mmb<-t
for(i in 1:length(t)){
  dis.mmb[i]<- length(med[med<= t[i]])/1000}
plot(t,dis.mmb,lty=3,lwd=2)