#' Append metrics lists with values from most recent model.

index <- length(precision_list) + 1

precision_list[index] <- metrics[1]
sensitivity_list[index] <- metrics[2]
specificity_list[index] <- metrics[3]
one_minus_spec[index] <- 100 - metrics[3]
f1_list[index] <-metrics[4]
f_beta_list[index] <-metrics[5]
accuracy_list[index] <-metrics[6]
tp_list[index] <- metrics[7]
fn_list[index] <- metrics[8]
fp_list[index] <- metrics[9]
tn_list[index] <- metrics[10]
probability_values[index] <- 0
longterm_cutoff_values[index] <- longterm_cutoff