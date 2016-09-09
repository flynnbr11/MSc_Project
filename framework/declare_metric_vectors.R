#' Make new empty vectors for all the values which
#' will be output as model results

precision_list <- vector()
sensitivity_list <- vector()
specificity_list <- vector()
one_minus_spec <- vector()
accuracy_list <- vector()
f1_list <- vector()
f_beta_list <- vector()
tp_list <- vector()
tn_list<- vector()
fp_list <- vector()
fn_list <- vector()
y_values <-vector()
probability_values <- vector()
longterm_cutoff_values <- vector()
auroc_values <- data.frame(Features=character(), Longterm_Cut=character(), Auroc=character())
