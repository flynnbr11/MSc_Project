#' Combine the individual result lists, e.g. precision for each iteration of the model
#' into a single dataframe and export as a CSV.

l <- length(probability_values)
row_names <- vector()
for (a in (1:l)){
  row_names[a] <- paste("long_cut = ", longterm_cutoff_values[a], "; prob = ", probability_values[a])
}


df <- ""
df <- as.data.frame(rbind(sensitivity_list, specificity_list, one_minus_spec, precision_list, 
                           f1_list, f_beta_list, accuracy_list, tp_list, fn_list, fp_list, tn_list))
results.df <- data.frame(lapply(df, as.numeric), stringsAsFactors = FALSE)
final_results.df <- as.data.frame(t(results.df))
colnames(final_results.df) <- c("Sensitivity", "Specificity", "One_minus_Specificity", "Precision", "F1_Score","F_beta_Score", "Accuracy", "True_Positives", "False_Negatives", "False_Positives", "True_Negatives")
final_results.df['Early_cutoff'] <- early_behaviour_num_days
final_results.df['Set_number'] <- setid
final_results.df['Longterm_cutoff'] <- longterm_cutoff
final_results.df['Game_id'] <- env_id
final_results.df['Target'] <- target
rownames(final_results.df) <- row_names

output_file <- paste("outputs/", output_dir,  "/", model_name, "_set_", setid, "_early_", early_behaviour_num_days, "_game_", env_id, "_k_", k, "_output.csv", sep="")
write.csv(final_results.df, output_file)
