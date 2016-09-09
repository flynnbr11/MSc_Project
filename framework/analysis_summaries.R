#' Generates CSV files which summarise the most recently built model.

all_data <- dbGetQuery(gacon, "SELECT * FROM log_regression_training_table UNION SELECT * FROM log_regression_test_table")
numerical <- sapply(all_data, is.numeric)
numerical_subset <- all_data[numerical] 

numerical_correlation_matrix <- cor(na.omit(numerical_subset))
numerical_covariance_matrix <- cov(na.omit(numerical_subset))

timing <- as.list(c(paste("Set number :", setid, sep=""), model_time))

summary_output_file <- paste("outputs/", output_dir ,"/", model_name, "_set_", setid, "_early_", early_behaviour_num_days, "_game_", env_id, "_summary.csv", sep="")
write.csv(model_summary, summary_output_file)
write.csv(numerical_correlation_matrix, paste("outputs/stats/correlation_matrix_set_", setid, "_early_", early_behaviour_num_days, "_game_", env_id, "_summary.csv", sep=""))
write.csv(numerical_covariance_matrix, paste("outputs/stats/covariance_matrix_set_", setid, "_early_", early_behaviour_num_days,"_game_", env_id, "_summary.csv", sep="") )

