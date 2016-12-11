/* Simple linear regression model */

data {
  int<lower=0> N;
  vector[N] time;
  vector[N] dose;
}

parameters{
  real b0;
  real b1;
  real<lower=0> sigma;
}


model{
  b0 ~ normal(140, 100);  
  b1 ~ normal(0, 100);  
  sigma ~ normal(0, 100);  

  time ~ normal(b0 + b1*dose, sigma);
}
