/* Randomised complete block design */

data{
  int<lower=1> N;     // number of samples
  int<lower=1> P;     // number of parameters
  matrix[N, P] X;     // design matrix
  vector[N] weight;   // response variable
}

parameters{
  vector[P] b;
  real<lower=0> sigma;
}

model{
  b ~ normal(0 , 1000);
  sigma ~ normal(0 , 100);
  weight ~ normal( X*b , sigma );
}
