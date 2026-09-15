# Data Modelling – Statistical Modelling and Integer-Valued Time Series Analysis

**Module:** Data Modelling
**Project Type:** Individual Coursework

## Project Overview

This individual coursework applies statistical modelling techniques using R across different types of data and modelling problems.

The project covers Generalized Linear Models (GLM), Generalized Linear Mixed Models (GLMM), integer-valued time-series modelling using an INAR(1) process, alternative thinning methods, and GARCH modelling.

## Analysis Covered

### 1. Generalized Linear Models (GLM) and Generalized Linear Mixed Models (GLMM)

The first part applies Poisson GLM and GLMM methods to count data.

The analysis includes:

* Data inspection and exploratory analysis
* Poisson GLM specification and fitting
* Assessment of overdispersion
* GLM diagnostic analysis
* Poisson GLMM with subject-level random effects
* Comparison of GLM and GLMM using AIC and log-likelihood
* Fixed-effect comparison
* Visualisation of subject-level random effects
* Comparison of observed and predicted values
* Interpretation of model results

### 2. Integer-Valued Time Series Modelling

The second part focuses on the simulation and modelling of an INAR(1) process for count-valued time-series data.

The analysis includes:

* Simulation of an INAR(1) process
* Binomial thinning
* Negative Binomial innovations
* Covariate generation
* ACF and PACF analysis
* Parameter estimation
* Interpretation of estimated parameters
* Alternative Poisson thinning
* Comparison of the effects of different thinning operators

### 3. Autoregressive and GARCH Processes

The coursework also examines autoregressive and GARCH processes, focusing on the difference between modelling conditional mean and conditional variance.

The analysis includes:

* Autoregressive dependence
* GARCH(1,1) modelling
* Model fitting using R
* Interpretation of volatility persistence
* Model diagnostic assessment
* Comparison of AR/INAR and GARCH approaches for count time-series data

## Methodology

The overall workflow involved:

1. Inspecting and exploring the data
2. Selecting appropriate statistical models
3. Simulating and fitting models in R
4. Assessing model assumptions and diagnostics
5. Comparing model performance
6. Estimating and interpreting model parameters
7. Visualising model results
8. Drawing conclusions from the analyses

## Tools and Techniques

* **R**
* **RStudio**
* Generalized Linear Models (GLM)
* Generalized Linear Mixed Models (GLMM)
* Poisson regression
* Random-effects modelling
* INAR(1) modelling
* Binomial and Poisson thinning
* Negative Binomial modelling
* ACF and PACF
* GARCH(1,1)
* Model diagnostics
* Model comparison
* Statistical simulation
* Data visualisation

## Repository Contents

```text
data-modelling/
│
├── Data_Modelling_Final_Coursework.pdf
├── Question_1_GLM_GLMM.R
├── Question_2_INAR_GARCH.R
└── README.md
```

### Files

**`Data_Modelling_Final_Coursework.pdf`**
Completed coursework report containing the statistical analyses, model results, visualisations, diagnostics, interpretations, and conclusions.

**`Question_1_GLM_GLMM.R`**
R code for Question 1, covering data inspection, exploratory analysis, GLM and GLMM fitting, model diagnostics, model comparison, random-effects analysis, and prediction comparison.

**`Question_2_INAR_GARCH.R`**
R code for Question 2, covering INAR(1) simulation, ACF/PACF analysis, parameter estimation, alternative Poisson thinning, and GARCH(1,1) modelling.

## Skills Demonstrated

* Statistical modelling
* Count-data analysis
* Generalized linear modelling
* Mixed-effects modelling
* Integer-valued time-series modelling
* Time-series analysis
* Statistical simulation
* Model estimation and comparison
* Model diagnostics
* R programming
* Data visualisation
* Statistical interpretation

## Note

This repository contains the completed coursework report and the two R code files used for the analyses. Original assignment questions, student identification details, and source datasets are not included.
