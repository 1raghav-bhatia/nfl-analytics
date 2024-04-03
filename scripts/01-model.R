#### Preamble ####
# Purpose: To create the Multiple linear regression model.
# Author: Raghav Bhatia 
# Date: 03 April 2024
# Contact: raghav.bhatia@mail.utoronto.ca
# License: MIT
# Pre-requisites: Have the cleaned dataset.



#### Workspace setup ####
library(boot)
library(broom.mixed)
library(collapse)
library(dataverse)
library(janitor)
library(knitr)
library(marginaleffects)
library(modelsummary)
library(rstanarm)
library(tidybayes)
library(tidyverse)
library(arrow)
library(nflverse)
library(tidymodels)

#### Read data ####
nfl_data <- read_csv("data/cleaned_data/qb_regular_season_data.csv")

### Mathematical Model ###

## \begin{align*}

##  y_i|\pi_i &\sim \mbox{Bern}(\pi_i) \\
##  \mbox{logit(}\pi_i\mbox{) } &=  \beta_0 \, + \, \beta_1 \cdot \text{gender}_i \,
##  + \, \beta_2 \cdot \mbox{education}_i \, +  \, \beta_3 \cdot \mbox{race}_i \\
##  &\quad \, + \, \beta_4 \cdot \mbox{economic outlook}_i \,
##  + \, \beta_5 \cdot \mbox{income change}_i \\
##  \beta_0 &\sim \mbox{Normal}(0, 2.5) \\
##  \beta_1 &\sim \mbox{Normal}(0, 2.5) \\
##  \beta_2 &\sim \mbox{Normal}(0, 2.5) \\
##  \beta_3 &\sim \mbox{Normal}(0, 2.5) \\
##  \beta_4 &\sim \mbox{Normal}(0, 2.5) \\
##  \beta_5 &\sim \mbox{Normal}(0, 2.5) \\
  
##  \end{align*}


### Model data ###

set.seed(853)

## EPA prediction model ##

# This glm regresses week 10-18 EPA on air_yards, sack_rate, Dakota, and weeks 1-9 EPA.

epa_predicion_model <-
  linear_reg() |>
  set_engine(engine  = "lm") |>
  fit(
    EPA_post ~ Air_Yards + Sack_Rate + Dakota + EPA_prior,
    data = nfl_data
  )


#### Save model ####

saveRDS(
  epa_predicion_model,
  file = "models/epa_predicion_model.rds"
)


