#' Generate random predictions for comparison to predictive models. 
#' 1. At the rate of occurance of the target variable in the test set.
#' 2. At a rate of 50%. 

training_set <- dbGetQuery(gacon, "SELECT * FROM log_regression_training_table")
test_set <- dbGetQuery(gacon, "SELECT * FROM log_regression_test_table")

rate <- sum(training_set[target]==1)/( sum(training_set[target]==1) + sum(training_set[target]==0))

test_set$random <- runif(nrow(test_set), 0, 1)
test_set$random_rate <- ifelse(test_set$random <= rate, 1, 0)
test_set$random_50 <- ifelse(test_set$random <= 0.5, 1, 0)

index <- length(precision_list) 

for (random_column in c("random_rate", "random_50")) {
  index <- index + 1 
  random_tp <- sum(test_set[target]==1 & test_set[random_column]==1, na.rm=TRUE)
  random_tn <- sum(test_set[target]==0 & test_set[random_column]==0, na.rm=TRUE)
  random_fp <- sum(test_set[target]==0 & test_set[random_column]==1, na.rm=TRUE)
  random_fn <- sum(test_set[target]==1 & test_set[random_column]==0, na.rm=TRUE)
  
  random_acc <- (random_tp+random_tn)/(random_tp+random_tn+random_fp+random_fn)
  random_prec <- (random_tp)/(random_tp+random_fp)
  random_sens <- random_tp/(random_tp+random_fn)
  random_spec <- random_tn/(random_tn + random_fp)
  random_f1_value <- (2*random_prec*random_sens)/(random_prec + random_sens)
  random_f_beta <- ( (1+beta*beta)*(random_prec+random_sens) )/( (beta*beta*random_prec) + random_sens )
  
  precision_list[index] <- 100*random_prec
  sensitivity_list[index] <- 100*random_sens
  specificity_list[index] <- random_spec
  one_minus_spec[index] <- 100*(1 - random_spec)
  accuracy_list[index] <- 100*random_acc
  f1_list[index] <- 100*random_f1_value
  f_beta_list[index] <- 100*random_f_beta 
  tp_list[index] <- random_tp
  fn_list[index] <-random_fn
  fp_list[index] <-random_fp
  tn_list[index] <-random_tn
  probability_values[index] <- random_column
  longterm_cutoff_values[index] <- longterm_cutoff
}
