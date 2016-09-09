#' This script sets the values to be used to generate a logistic regression model. 
#' model_type determines whether the model predicts long-term players or spenders, 
#' and if it is built in vertica or R. 
user_metrics_table <- strwrap(paste("measure_v4.user_metrics_", env_id, sep=""), simplify=T,width=1e5) # name of the table to pull data from
reg_table <- strwrap(paste(schema, ".regression_", env_id, "_table", sep=""), simplify=T,width=1e5) # name of the table which will be built.
output_dir <- "results_directory"   # where to put results, within thesis/outputs/. Ensure this directory exists before running

## What type of model to build
### 1 : Vertica Longterm prediction
### 2 : Vertica Spender prediction
### 3 : Vertica/R Hybrid Longterm prediction
### 4 : Vertica/R Hybrid Spender prediction
model_type <- 4


#' Which game to build on
#'Known useful games are : 2880, 139, 2187, 4120, 4318, 4429, 2527,  2718
env_id <- 2880

#' Feature Selection.
#' Sets 1-10 are predefined.
#' To manually choose features, enter setid<-0 and input variables in feature_selection.R
setid <- 8

#' For time based model, alter dates of training and test set timeframes. 
training_start_date = "2016-01-01"
training_end_date = "2016-03-30"
test_start_date = "2016-04-01"
test_end_date = "2016-06-30"



#' Change the cutoff threshold for what counts as a long-term player. 
#' Automatically runs a for loop over longterm_low to longter_high
source("model_parameters.R") # set values based on chosen model type

#' Vary probability at which positive case predicted
#' For standard logisitc regression, set both limits to 50
#' Otherwise, run in loop
prob_low <- 0
prob_high <- 100

longterm_low <- 6
longterm_high <- 10
if( build_spend_model == 1 || build_hybrid_spend == 1) {
  longterm_cutoff <- round( (longterm_low + longterm_high )/2 )
}

#' Cutoff for how many days count as "early" behaviour
early_behaviour_num_days = 2

#' Weighting of positive cases for hyrbrid modelling: 
k <- 5

#' Factor by which sensitivity is more important than precision for F_beta score
beta = 2 

source("feature_selection.R")