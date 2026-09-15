# Question 1
# Generalized Linear Models (GLM) and Generalized Linear Mixed Models (GLMM)

# 1. LOAD REQUIRED PACKAGES AND DATA
# Install packages 
install.packages(c(
  "MASS",
  "lme4",
  "ggplot2",
  "dplyr",
  "broom",
  "broom.mixed",
  "parameters"
))

# Load libraries for modelling and visualisation
library(MASS)
library(lme4)
library(ggplot2)
library(dplyr)
library(broom)
library(broom.mixed)
library(parameters)

# Load built-in epilepsy dataset
data(epil)

# 2. BASIC DATA INSPECTION

# Structure of dataset (variables + types)
str(epil)

# Summary statistics for all variables
summary(epil)

# Check how many observations per patient (subject balance)
table(epil$subject)

# 3. EXPLORATORY DATA ANALYSIS (EDA)

epilepsy_data <- epil

# Visualise distribution of seizure counts (response variable)
ggplot(epilepsy_data, aes(x = y)) +
  geom_histogram(bins = 30) +
  labs(title = "Distribution of Seizure Counts")

# Explore relationship between baseline seizures and outcome

ggplot(epilepsy_data, aes(x = base, y = y)) +
  geom_point() +
  geom_smooth(method = "loess") +
  labs(title = "Relationship Between Baseline and Seizure Counts")


# 4. FIT GENERALIZED LINEAR MODEL (GLM)

# Fit Poisson GLM assuming independent observations
glm_model <- glm(y ~ trt + base + age,
                 family = poisson,
                 data = epilepsy_data)

# Display GLM results
summary(glm_model)

# Compute model fit (AIC)
AIC(glm_model)

# Check for overdispersion in GLM

# Calculate Pearson residuals
glm_resid <- residuals(glm_model, type = "pearson")

# Compute dispersion statistic (important assumption check)
dispersion_index <- sum(glm_resid^2) / df.residual(glm_model)

# Display overdispersion value
dispersion_index

# 5. MODEL DIAGNOSTICS FOR GLM

# Standard diagnostic plots (residuals, leverage, etc.)
par(mfrow = c(2,2))
plot(glm_model)

# 6. FIT GENERALIZED LINEAR MIXED MODEL (GLMM)

# Fit Poisson GLMM with subject-level random intercept
glmm_model <- glmer(y ~ trt + base + age + (1 | subject),
                    family = poisson,
                    data = epilepsy_data)

# Show GLMM results
summary(glmm_model)

# Model fit statistics
AIC(glmm_model)
logLik(glmm_model)

# 7. COMPARE GLM AND GLMM

# Create comparison table for model performance
model_results <- data.frame(
  Model = c("GLM", "GLMM"),
  AIC = c(AIC(glm_model), AIC(glmm_model)),
  LogLikelihood = c(as.numeric(logLik(glm_model)),
                    as.numeric(logLik(glmm_model)))
)

# Display comparison
model_results

# 8. COMPARE FIXED EFFECTS

# Extract GLM coefficients in tidy format
model_parameters(glm_model)

# Extract GLMM coefficients in tidy format
model_parameters(glmm_model)

# 9. VISUALISE RANDOM EFFECTS (GLMM ONLY)

# Extract subject-level random effects
subject_effects <- ranef(glmm_model)$subject

# Plot random intercept variation between patients
dotchart(subject_effects[[1]],
         main = "Variation in Patient-Level Effects",
         xlab = "Random Intercept Values")

# 10. PREDICTION COMPARISON (GLM vs GLMM)

# Generate predictions from GLM
epilepsy_data$glm_pred <- predict(glm_model, type = "response")

# Generate predictions from GLMM
epilepsy_data$glmm_pred <- predict(glmm_model, type = "response")

# Compare observed vs predicted values visually

ggplot(epilepsy_data, aes(x = y)) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "grey") +
  geom_point(aes(y = glm_pred, color = "GLM"), alpha = 0.5) +
  geom_point(aes(y = glmm_pred, color = "GLMM"), alpha = 0.5) +
  labs(title = "Observed vs Predicted Seizure Counts",
       subtitle = "GLMM typically follows the 45° line more closely",
       x = "Observed Seizure Counts",
       y = "Predicted Seizure Counts") +
  scale_color_manual(values = c("GLM" = "red", "GLMM" = "blue")) +
  theme_minimal()

# 11. PARAMETER COMPARISON 

# GLM coefficient estimates
summary(glm_model)$coefficients

# GLMM coefficient estimates
summary(glmm_model)$coefficients

