/* Oneway ANOVA model, can be used for all contrasts */

data {
  int<lower=0> N;      // number of samples
  int<lower=0> P;      // number of parameters
  matrix[N, P] X;      // design matrix
  vector[N] time;      // response variable
}

parameters{
  vector[P] b;
  real<lower=0> sigma;
}


model{
  // priors
  b ~ normal(0 , 1000);
  sigma ~ normal(0, 100);  

  // likelihood
  time ~ normal( X*b , sigma );
}
