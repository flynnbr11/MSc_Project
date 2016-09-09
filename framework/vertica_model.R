#' Call vertica queries to generate the log reg model on vertica.

source("rebuild_tables.R") # Tables may need to be rebuilt after parameter change.  

# Build logistic regression model for long term play and spenders (first delete previous iterations)
#' From build_reg_model.R
try(dbSendQuery(gacon, delete_model))
try(dbSendQuery(gacon, build_model))

#' Evaluate models build in vertica -- apply to test data and generate metrics e.g accuracy/sensitivity
#' From make_predictions.R
try(dbSendUpdate(gacon, delete_predicted_results))
try(dbSendUpdate(gacon, predicted_results_table))
try(dbSendUpdate(gacon, delete_check_accuracy))
try(dbSendUpdate(gacon, check_accuracy_table))
try(dbSendUpdate(gacon, delete_metrics))
try(dbSendUpdate(gacon, metrics_table))

metrics <- try(dbGetQuery(gacon, get_metrics))
model_summary <- try(dbGetQuery(gacon, summary_model))
