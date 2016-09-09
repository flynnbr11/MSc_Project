#' Evaluate the most recent version of the R/Vertica hybrid model.
#' Take a result set for each probability threshold 

index <- length(tp_list)

sens_auroc <- vector()
spec_auroc <- vector()

for( x in prob_low:prob_high) {
  y <- 0.01*x  
  index <- index + 1
  test_set$odds <- exp(test_set$log_odds)
  test_set$probs <- ( (test_set$odd) / (1+ test_set$odds) )
  test_set$prediction <- ifelse(test_set$probs > y, 1, 0)
  tp <- sum(test_set[target]==1 & test_set$prediction==1, na.rm=TRUE)
  tn <- sum(test_set[target]==0 & test_set$prediction==0, na.rm=TRUE)
  fp <- sum(test_set[target]==0 & test_set$prediction==1, na.rm=TRUE)
  fn <- sum(test_set[target]==1 & test_set$prediction==0, na.rm=TRUE)
  acc <- (tp+tn)/(tp+tn+fp+fn)
  prec <- (tp)/(tp+fp)
  sens <- tp/(tp+fn)
  spec <- tn/(tn + fp)
  f1_value <- (2*prec*sens)/(prec + sens)
  f_beta <- ( (1+beta*beta)*(prec*sens) )/( (beta*beta*prec) + sens )
  
  ### replace below with single call to update_metrics_vectors ? 
  precision_list[index] <- 100*prec
  sensitivity_list[index] <- 100*sens
  specificity_list[index] <-100*spec
  one_minus_spec[index] <- 100* (1 - spec)
  accuracy_list[index] <- 100*acc
  f1_list[index] <- 100*f1_value
  f_beta_list[index] <- 100*f_beta
  tp_list[index] <- tp
  fn_list[index] <-fn
  fp_list[index] <-fp
  tn_list[index] <-tn
  probability_values[index] <- y
  longterm_cutoff_values[index] <- longterm_cutoff
  sens_auroc[x+1] <- sensitivity_list[index]
  spec_auroc[x+1] <- one_minus_spec[index]
}

