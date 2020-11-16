#Preliminaries
#---------------------------------------------------------
rm(list = ls())
library("mvtnorm")
setwd("/Users/raz/Dropbox/14.31 edX Building the Course/Problem Sets/PSET 6")

real_theta <- 5
sample_size <- 100
number_simulations <- 100000

simulations1 <- matrix(runif(sample_size*number_simulations, max = real_theta), 
                      nrow = number_simulations)


estimator_mean <- 2*apply(simulations1, 1, mean)
estimator_median <- 2*apply(simulations1, 1, median)

p1 <- hist(estimator_mean, breaks = 100)
p2 <- hist(estimator_median, breaks = 100)
range <- range(p1$mids, p2$mids )
p1$counts = p1$density
p2$counts = p2$density

pdf("histogram1.pdf")
plot( p1, col=rgb(1,0,0,1/4), main = " ", xlim = range, xlab = "values", ylab = "density")
plot( p2, col=rgb(0,0,1,1/4), add = TRUE)  
dev.off()

sample_size <- 1000
number_simulations <- 100000

simulations2 <- matrix(runif(sample_size*number_simulations, max = real_theta), 
                       nrow = number_simulations)

estimator_mean <- 2*apply(simulations2, 1, mean)

p3 <- hist(estimator_mean, breaks = 100)
p3$counts = p3$density

xrange <- range(p1$mids, p3$mids)
yrange <- range(p1$counts, p3$counts)

pdf("histogram2.pdf")
plot( p1, col=rgb(1,0,0,1/4), main = " ", xlim = xrange, ylim = yrange, xlab = "values", ylab = "density")
plot( p3, col=rgb(0,0,1,1/4), add = TRUE)  
dev.off()