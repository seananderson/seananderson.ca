# Let's try imputing missing values


# now we're going to impute with Stan:

stan_model <-
'data {
  int<lower=0> N; // rows of data
  vector[N] x;
  int<lower=0> Nmissing; // number of missing values
  int missing_id[Nmissing]; // IDs of missing values
}
parameters {
  real<lower=-0.99, upper=0.99> phi;
  real<lower=0> sigma;
  real x_missing[Nmissing]; // imputed missing values
}
transformed parameters {
  vector[N] x_impute; // y with some imputed
  for (i in 1:N) {
    x_impute[i] <- x[i];
  }
  for (i in 1:Nmissing) {
    x_impute[missing_id[i]] <- x_missing[i];
  }

}
model {
  sigma ~ cauchy(0, 2.5);
  phi ~ normal(0, 2);
  for (i in 2:N) {
    x_impute[i] ~ normal(x_impute[i-1] * phi, sigma);
  }
}
'
library(rstan)
stan_missing_ar1 <- stan_model(model_code = stan_model)

x <- arima.sim(n = 100L, list(ar = 0.8, ma = 0), sd = 0.05)
missing_id <- c(50, 80)
erased <- x[missing_id]
x[missing_id] <- NA
plot(x)
x_missing <- x
x_missing[missing_id] <- 9999 # Stan can't handle NAs; give it fake data
m_missing <- sampling(
  stan_missing_ar1,
  data = list(N = length(x), x = x_missing,
    Nmissing = length(missing_id), missing_id = missing_id),
  iter = 500,
  pars = c("sigma", "x_impute", "sigma"))

imp <- apply(extract(m_missing)$x_impute[,missing_id], 2, median)
l <- apply(extract(m_missing)$x_impute[,missing_id], 2, quantile, probs = 0.1)
u <- apply(extract(m_missing)$x_impute[,missing_id], 2, quantile, probs = 0.9)
points(missing_id, imp)
segments(missing_id, l, missing_id, u)
points(missing_id, erased, col = "red")
