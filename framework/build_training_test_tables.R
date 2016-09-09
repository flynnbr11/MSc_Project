#' Generate training and test subsets of regression table (first delete previous ones)
#' This calls queries written in build_reg_model.R

try(dbSendUpdate(gacon, drop_training))
try(dbSendUpdate(gacon, drop_test))
try(dbSendUpdate(gacon,log_regression_training_table))
try(dbSendUpdate(gacon,log_regression_test_table))
