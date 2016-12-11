library(rstan)
library(labstats) # data set from here
library(lattice)

options(mc.cores = parallel::detectCores())


# select data from the first experiment only
bennett <- subset(Bennett1964, subset=experiment==1, -experiment)

# make litter a factor
bennett$litter <- factor(bennett$litter)

# plot
xyplot(weight~group, data=bennett, groups=litter,
	type=c("g","p","a"), col="black",
	xlab="", ylab="", main="")


# compare with frequentist analysis
summary(lm(weight ~ litter + group, data=bennett))

# obtain the design matrix
X <- model.matrix(~ litter + group, data=bennett)


d <- list(N = nrow(bennett),
          P = ncol(X),
          X = X,
          weight = bennett$weight)
          

m1 <- stan("RBD1.stan", iter=5000,  seed=123, 
           data=d)

m1
