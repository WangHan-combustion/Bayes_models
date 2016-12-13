/* Oneway ANOVA "cell means" model */

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
  b ~ normal(140 , 100);  // the grand mean is 140
  sigma ~ normal(0, 100);  

  // likelihood
  time ~ normal( X*b , sigma );
}

generated quantities{
  real diff80_v_0;
  real diff160_v_0;
  real diff240_v_0;
  real diff240_v_80;

  // calculate all comparisons of interest
  diff80_v_0 = b[2] - b[1];     // lowest vs. control
  diff160_v_0 = b[3] - b[1];    // medium vs. control
  diff240_v_0 = b[4] - b[1];    // highest vs. control
  diff240_v_80 = b[4] - b[2];   // lowest vs. highest
}
