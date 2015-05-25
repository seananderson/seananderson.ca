---
layout: post
title: Stan state-space models with missing values
subtitle: Ricker-logistic models with imputation
published: false
---



The following is some code I played with to understand imputing missing values
with ecological state-space models in Stan. I simulate some data from a
Ricker-logistic model, show how to fit a basic model in R, translate that model
to Stan, develop a Stan model to impute missing values while fitting the model,
and finally turn the model into a spate-space model by also estimating
observation error.

Stan can handle missing value imputation quite well, although the syntax to
write the models is a bit awkward because it can't handle NA values
implicitely. You have to feed it fake data and then estimate the missing values
as parameters. I couldn't find a good example of this anywhere, so I thought
I'd play with some simulated data to figure it out. 
[This thread](https://groups.google.com/forum/#!searchin/stan-users/missing/stan-users/y9BalO9ILF0/ErbERTPsFbMJ)
on the Stan mailing list got me pointed in the right direction.

Please take everything I've written with some skepticism because I've written this code very quickly and could very well have made mistakes.


```r
set.seed(1)
N <- 50         # number of time steps
x <- 1:N        # time step values
y <- rep(NA, N) # vector to hold (scaled) abundance values
y[1] <- 1       # initial scaled abundance
sigma_p <- 0.6  # process noise standard deviation
r <- 0.8        # Ricker productivity parameter
K <- 50         # Carrying capacity
# Mean-bias corrected process noise:
proc_noise <- rnorm(N, -(sigma_p^2)/2, sigma_p)

# Ricker-logistic dynamics:
ricker <- function(spawners, r, K, v_t) {
  spawners * exp(r * (1 - spawners / K) + v_t)
}

for (i in seq(1, N - 1)) {
  y[i + 1] <- ricker(y[i], r = 0.8, K = 50, v_t = proc_noise[i])
}

par(yaxs = "i", las = 1)
plot(x, y, type = "o", pch = 20, ylim = c(0, max(y) * 1.1))
```

<img src="/knitr-figs/stan-impute1-1.png" title="plot of chunk stan-impute1" alt="plot of chunk stan-impute1" width="504" style="display: block; margin: auto;" />

Let's start by looking at how we can quickly fit a Ricker-logistic model in R. We'll fit `log(R/S)` as the response and `S` as the predictor, where `R` is the recruits and `S` is the spawners. In this case, `R` and `S` are a time-shifted version of each other.


```r
plot(log(y[2:N] / y[1:(N - 1)]) ~ y[1:(N - 1)])
m1 <- lm(log(y[2:N] / y[1:(N - 1)]) ~ y[1:(N - 1)])
abline(m1)
```

<img src="/knitr-figs/stan-impute2-1.png" title="plot of chunk stan-impute2" alt="plot of chunk stan-impute2" width="504" style="display: block; margin: auto;" />

```r
coef(m1)[[1]]                # r
```

```
# [1] 0.6244809
```

```r
-coef(m1)[[1]]/coef(m1)[[2]] # K
```

```
# [1] 42.31514
```

Now, let's fit that same model in Stan:


```r
stan_model <-
'data {
  int<lower=0> N; // rows of data
  vector[N] r_obs; // observed growth rates for time t
  vector[N] Nt; // numbers at time t
}
parameters {
  real b;
  real a;
  real<lower=0> sigma_proc;
}
model {
  sigma_proc ~ cauchy(0, 5);
  a ~ cauchy(0, 5);
  b ~ cauchy(0, 5);
  r_obs ~ normal(a + b * Nt, sigma_proc);
}
generated quantities {
  real K;
  for (i in 1:N) {
    K <- -a/b;
  }
}
'
library("rstan")
stan_ricker <- stan_model(model_code = stan_model)
```


```r
r_obs <- c(NA, diff(log(y)))
m1_stan <- sampling(
  stan_ricker,
  data = list(N = length(y) - 1, r_obs = r_obs[-1], Nt = y[-length(y)]))
```


```r
print(m1_stan)
```

```
# Inference for Stan model: stan_model.
# 4 chains, each with iter=2000; warmup=1000; thin=1; 
# post-warmup draws per chain=1000, total post-warmup draws=4000.
# 
#             mean se_mean   sd  2.5%   25%   50%   75% 97.5% n_eff Rhat
# b          -0.01    0.00 0.00 -0.02 -0.02 -0.01 -0.01 -0.01  1150    1
# a           0.63    0.00 0.15  0.33  0.53  0.63  0.72  0.92  1150    1
# sigma_proc  0.52    0.00 0.05  0.42  0.48  0.51  0.55  0.63  1192    1
# K          42.60    0.09 5.62 32.38 39.16 42.29 45.65 54.86  3984    1
# lp__        7.88    0.04 1.19  4.89  7.29  8.19  8.78  9.26  1159    1
# 
# Samples were drawn using NUTS(diag_e) at Mon May 25 14:28:53 2015.
# For each parameter, n_eff is a crude measure of effective sample size,
# and Rhat is the potential scale reduction factor on split chains (at 
# convergence, Rhat=1).
```

Let's write the same model in a format that makes the time-series nature of the data clearer. This will make it easier to include missing data in the model later. We're also going to switch to working on a log scale. We'll use the variable `y` to refer to `log(abundance)` inside the Stan model.


```r
stan_model2 <-
'data {
  int<lower=0> N; // rows of data
  vector[N] y; // log(numbers) at time t
  real<lower=0> K_upper; // upper boundary on K
}
parameters {
  real<lower=0, upper=K_upper> K;
  real r;
  real<lower=0> sigma_proc;
}
model {
  sigma_proc ~ cauchy(0, 5);
  r ~ cauchy(0, 5);
  for (i in 2:N) {
   y[i] ~ normal(y[i-1] + r * (1 - exp(y[i-1]) / K), sigma_proc);
  }
}
'
stan_ricker2 <- stan_model(model_code = stan_model2)
```


```r
m2_stan <- sampling(stan_ricker2, 
  data = list(N = N, y = log(y), K_upper = max(y) * 2))
```

It's a very slightly different model because of the priors and the starting point, but we get essentially the same posterior:


```r
print(m2_stan)
```

```
# Inference for Stan model: stan_model2.
# 4 chains, each with iter=2000; warmup=1000; thin=1; 
# post-warmup draws per chain=1000, total post-warmup draws=4000.
# 
#             mean se_mean   sd  2.5%   25%   50%   75% 97.5% n_eff Rhat
# K          43.99    0.22 6.97 32.53 39.86 43.40 47.38 58.95  1033    1
# r           0.60    0.00 0.16  0.29  0.50  0.61  0.71  0.91  1292    1
# sigma_proc  0.52    0.00 0.06  0.42  0.48  0.52  0.56  0.64  1411    1
# lp__       11.19    0.05 1.44  7.53 10.63 11.58 12.20 12.76   940    1
# 
# Samples were drawn using NUTS(diag_e) at Mon May 25 14:29:17 2015.
# For each parameter, n_eff is a crude measure of effective sample size,
# and Rhat is the potential scale reduction factor on split chains (at 
# convergence, Rhat=1).
```

Now we'll introduce missing values. First, we'll write a Stan model. The
imputation part is relatively straightforward conceptually, but a bit nasty to
write out in Stan. We add `Nmissing`, which defines how many missing values we
have. We add `missing_id`, which is a vector of IDs indicating which values are
missing. For example, if the 10th and 20th values were missing then
`missing_id` would equal `c(10, 20)`. We add a vector to hold the estimated
missing values `y_missing`. We then feed all the observed data into a vector
called `y_impute` and fill in the values we need to impute with estimated
parameter values from `y_missing`. We then proceed with the same model as before.


```r
stan_model_missing <-
'data {
  int<lower=0> N; // rows of data
  vector[N] y; // log(numbers) at time t
  real<lower=0> K_upper; // upper boundary on K
  int<lower=0> Nmissing; // number of missing values
  int missing_id[Nmissing]; // IDs of missing values
}
parameters {
  real<lower=0, upper=K_upper> K;
  real r;
  real<lower=0> sigma_proc;
  real y_missing[Nmissing]; // imputed missing values
}
transformed parameters {
  vector[N] y_impute; // y with some imputed
  for (i in 1:N) {
    y_impute[i] <- y[i];
  }
  for (i in 1:Nmissing) {
    y_impute[missing_id[i]] <- y_missing[i];
  }
}
model {
  sigma_proc ~ cauchy(0, 5);
  r ~ cauchy(0, 5);
  for (i in 2:N) {
   y_impute[i] ~
     normal(y_impute[i-1] + r * (1 - exp(y_impute[i-1]) / K),
            sigma_proc);
  }
}
'
stan_ricker_missing <- stan_model(model_code = stan_model_missing)
```


```r
missing_id <- sample(seq_len(N), 4)
y_missing <- y
y_missing[missing_id] <- 9999 # Stan can't handle NAs; give it fake data
m_missing <- sampling(
  stan_ricker_missing,
  data = list(N = N, y = log(y_missing), 
    K_upper = max(y_missing[-missing_id]) * 2, 
    Nmissing = length(missing_id), missing_id = missing_id),
  iter = 4000,
  pars = c("K", "r", "sigma_proc", "y_impute"))
```

Let's plot the model output:


```r
p <- extract(m_missing)
layout(rbind(c(1, 2, 3), c(4, 4, 4)))
plot(density(p$r));abline(v = r, col = "blue", lwd = 2)
plot(density(p$K));abline(v = K, col = "blue", lwd = 2)
plot(density(p$sigma_proc));abline(v = sigma_p, col = "blue", lwd = 2)

pch <- rep(20, N)
col <- rep("black", N)
pch[missing_id] <- 21
col[missing_id] <- "blue"
plot(x, y, type = "o", pch = pch, ylim = c(0, max(y_missing[-missing_id]) * 1.1), col = col)
imputed <- exp(apply(p$y_impute, 2, median))
imputed_l <- exp(apply(p$y_impute, 2, quantile, prob = 0.1))
imputed_u <- exp(apply(p$y_impute, 2, quantile, prob = 0.9))
imputed_ll <- exp(apply(p$y_impute, 2, quantile, prob = 0.25))
imputed_uu <- exp(apply(p$y_impute, 2, quantile, prob = 0.75))
points(x[missing_id], imputed[missing_id], col = "red", pch = 21, cex = 1.5)
segments(x[missing_id], imputed_l[missing_id], 
  x[missing_id], imputed_u[missing_id], col = "red", lwd = 1)
segments(x[missing_id], imputed_ll[missing_id], 
  x[missing_id], imputed_uu[missing_id], col = "red", lwd = 2.5)
```

<img src="/knitr-figs/stan-impute3-1.png" title="plot of chunk stan-impute3" alt="plot of chunk stan-impute3" width="576" style="display: block; margin: auto;" />

Now with observation error and missing values. We can add the estimation of observation error and make this a state-space model by adding only a few lines of Stan code. We'll add `sigma_obs`, which estimates the standard deviation of observation error. We'll then add a vector `U`, which represents the unobserved 'true' states. The observation error gets modelled as normally distributed (on a log scale) around `U`.


```r
stan_model_missing_obs <-
'data {
  int<lower=0> N; // rows of data
  vector[N] y; // numbers at time t
  real<lower=0> K_upper; // upper boundary on K
  int<lower=0> Nmissing; // number of missing values
  int missing_id[Nmissing];
}
parameters {
  real<lower=0, upper=K_upper> K;
  real r;
  real<lower=0> sigma_proc;
  real<lower=0> sigma_obs;
  real y_missing[Nmissing]; // imputed missing values
  vector[N] U; // states
}
transformed parameters {
  vector[N] y_impute; // Nt with some imputed
  for (i in 1:N) {
    y_impute[i] <- y[i];
  }
  for (i in 1:Nmissing) {
    y_impute[missing_id[i]] <- y_missing[i];
  }
}
model {
  sigma_proc ~ cauchy(0, 5);
  r ~ cauchy(0, 5);
  for (i in 2:N) {
   U[i] ~
     normal(U[i-1] + r * (1 - exp(U[i-1]) / K), sigma_proc);
  }
  y_impute ~ normal(U, sigma_obs);
}
'
stan_ricker_missing_obs <- stan_model(model_code = stan_model_missing_obs)
```

We'll need to run the model for some extra iterations, because parsing out process and observation error is challenging:


```r
# add some observation error to the data:
sigma_obs <- 0.2
y_missing_obs <- y_missing * rlnorm(N, 0, sigma_obs)
m_missing_obs <- sampling(
  stan_ricker_missing_obs,
  data = list(N = N, y = log(y_missing_obs), K_upper = max(y_missing_obs[-missing_id]) * 2, 
    Nmissing = length(missing_id), missing_id = missing_id),
  iter = 6000,
  pars = c("K", "r", "sigma_proc", "sigma_obs", "y_impute", "U"))
```

And plot the output:


```r
p <- extract(m_missing_obs)
layout(rbind(c(1, 2, 3, 4), c(5, 5, 5, 5)))
plot(density(p$r));abline(v = r, col = "blue", lwd = 2)
plot(density(p$K));abline(v = K, col = "blue", lwd = 2)
plot(density(p$sigma_proc));abline(v = sigma_p, col = "blue", lwd = 2)
plot(density(p$sigma_obs));abline(v = sigma_obs, col = "blue", lwd = 2)

y_missing_obs[missing_id] <- NA
pch <- rep(20, N)
col <- rep("black", N)
pch[missing_id] <- 21
col[missing_id] <- "blue"
plot(x, y, type = "o", pch = pch, cex = 1.5, 
  ylim = c(0, max(y_missing_obs, na.rm = TRUE) * 1.1), col = "grey40")
points(x, y_missing_obs, col = "grey60", pch = 4)
U <- exp(apply(p$U, 2, median))
U_l <- exp(apply(p$U, 2, quantile, prob = 0.1))
U_u <- exp(apply(p$U, 2, quantile, prob = 0.9))
U_ll <- exp(apply(p$U, 2, quantile, prob = 0.25))
U_uu <- exp(apply(p$U, 2, quantile, prob = 0.75))

polygon(c(x, rev(x)), c(U_l, rev(U_u)), border = NA, col = "#FF000020")
polygon(c(x, rev(x)), c(U_ll, rev(U_uu)), border = NA, col = "#FF000030")
lines(x, U, col = "#FF000060", lwd = 3)
```

<img src="/knitr-figs/stan-impute5 stan-impute4-1.png" title="plot of chunk stan-impute5 stan-impute4" alt="plot of chunk stan-impute5 stan-impute4" width="576" style="display: block; margin: auto;" />

In the above, the black dots and lines are the true underlying data. The open circles were missing when the model was run. The grey crosses indicate the observed data. The red line and shaded regions indicate the posterior median, and 50% and 90% credible intervals of the estimated true abundance.
