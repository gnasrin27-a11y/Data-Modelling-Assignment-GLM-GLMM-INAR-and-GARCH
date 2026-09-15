# QUESTION 2(i)
# SIMULATION OF INAR(1) PROCESS

# Load packages
install.packages(c("tscount", "forecast", "tseries", "rugarch"))

library(tscount)
library(forecast)
library(tseries)
library(rugarch)

# Set seed for reproducibility
set.seed(123)

# Define parameters
n_obs <- 200        # Number of observations
alpha <- 0.45       # Thinning parameter
b0 <- 1.2           # Intercept parameter
b1 <- 0.8           # Covariate effect
overdisp <- 2       # Overdispersion parameter for Negative Binomial distribution

# Generate covariate x_t
x <- numeric(n_obs)

for(t in 1:n_obs){
  x[t] <- (-1)^t * rnorm(1)
}

# Generate conditional mean
mu <- exp(b0 + b1 * x)

# Simulate INAR(1) process
Y <- numeric(n_obs)

# Initial value
Y[1] <- rnbinom(1, size = overdisp, mu = mu[1])

for(t in 2:n_obs){

  # Binomial thinning
  thinning <- rbinom(1, size = Y[t-1], prob = alpha)

  # Negative Binomial innovations
  Rt <- rnbinom(1, size = overdisp, mu = mu[t])

  # INAR(1) equation
  Y[t] <- thinning + Rt
}

# Convert to time series object
Y_ts <- ts(Y)


# Plot Time Series

plot(Y_ts,
     main = "Simulated INAR(1) Count Time Series",
     ylab = "Counts",
     xlab = "Time",
     col = "royalblue4",
     lwd = 2)

# ACF 

acf(Y_ts,
    main = "ACF of Simulated INAR(1) Process",
    col = "steelblue4",
    lwd = 2)

# PACF

pacf(Y_ts,
     main = "PACF of Simulated INAR(1) Process",
     col = "steelblue4",
     lwd = 2)

# PARAMETER ESTIMATION

inar_fit <- tsglm(
  ts = Y_ts,
  model = list(past_obs = 1),
  xreg = x,
  link = "log",
  distr = "nbinom"
)

summary(inar_fit)

# ALTERNATIVE POISSON THINNING OPERATOR

set.seed(321)

Y_alt <- numeric(n_obs)
Y_alt[1] <- rpois(1, lambda = mu[1])

for(t in 2:n_obs){

  thinning_alt <- sum(rpois(Y_alt[t-1], lambda = alpha))
  Rt_alt <- rnbinom(1, size = overdisp, mu = mu[t])

  Y_alt[t] <- thinning_alt + Rt_alt
}

plot(ts(Y_alt),
     main = "INAR Process with Alternative Thinning",
     ylab = "Counts",
     xlab = "Time",
     col = "purple4",
     lwd = 2)

# FIT GARCH(1,1) MODEL

spec <- ugarchspec(
  variance.model = list(garchOrder = c(1,1)),
  mean.model = list(armaOrder = c(1,0)),
  distribution.model = "norm"
)

fit_garch <- ugarchfit(
  spec = spec,
  data = Y_ts
)

fit_garch