library(rstan)
library(labstats) # data set from here


options(mc.cores = parallel::detectCores())


# plot data
par(las=1)
plot(time.immob ~ dose, data=fluoxetine, xlim=c(-10, 250),
     ylim=c(0, 220), ylab="Time immobile (s)", xlab="Dose (mg/L)")


# convert dose into an unordered factor
fluoxetine$dose <- factor(fluoxetine$dose)


# ---------------------------------------------------------------
# Cell means model, with one mean estimated for each group

X1 <- model.matrix(~ 0 + dose, data=fluoxetine)

d1 <- list(N = nrow(fluoxetine),
           P = ncol(X1),
           X = X1,
           time = fluoxetine$time.immob)


# frequentist analysis
summary(lm(time.immob ~ 0 + dose, data=fluoxetine))


m1 <- stan("anova1.stan", iter = 5000, seed=123,
           data=d1)

m1



# ---------------------------------------------------------------
# Use default "treatment" contrasts, where each dose is compared to
# the zero-dose control group

X2 <- model.matrix(~ dose, data=fluoxetine)

d2 <- list(N = nrow(fluoxetine),
           P = ncol(X2),
           X = X2,
           time = fluoxetine$time.immob)


# frequentist analysis
summary(lm(time.immob ~ dose, data=fluoxetine))


m2 <- stan("anova2.stan", iter = 5000, seed=123,
           data=d2)

m2



# ---------------------------------------------------------------
# Use "sum-to-zero" contrasts

X3 <- model.matrix(~ dose, data=fluoxetine,
                   contrasts.arg=list(dose="contr.sum"))

d3 <- list(N = nrow(fluoxetine),
           P = ncol(X3),
           X = X3,
           time = fluoxetine$time.immob)


# frequentist analysis
summary(lm(time.immob ~ dose, data=fluoxetine,
           contrasts=list(dose="contr.sum")))


# can use the same model file as above
m3 <- stan("anova2.stan", iter = 5000, seed=123,
           data=d3)

m3



# ---------------------------------------------------------------
# Treat dose as an ordered categorical factor

X4 <- model.matrix(~ dose, data=fluoxetine,
                   contrasts.arg=list(dose="contr.poly"))

d4 <- list(N = nrow(fluoxetine),
           P = ncol(X4),
           X = X4,
           time = fluoxetine$time.immob)


# frequentist analysis
summary(lm(time.immob ~ dose, data=fluoxetine,
           contrasts=list(dose="contr.poly")))


# can use the same model file as above
m4 <- stan("anova2.stan", iter = 5000, seed=123,
           data=d4)

m4 # b[2] is the linear trend
