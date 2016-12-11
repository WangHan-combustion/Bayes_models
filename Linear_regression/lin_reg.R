library(rstan)
library(labstats) # data set from here


options(mc.cores = parallel::detectCores())


# plot data
par(las=1)
plot(time.immob ~ dose, data=fluoxetine, xlim=c(-10, 250),
     ylim=c(0, 220), ylab="Time immobile (s)", xlab="Dose (mg/L)")


d <- list(N = nrow(fluoxetine),
          time = fluoxetine$time.immob,
          dose = fluoxetine$dose)


m1 <- stan("lin_reg1.stan", iter = 5000, seed=123,
           data=d)

m1

