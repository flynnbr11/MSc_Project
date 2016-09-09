require(sqldf)
setwd("/home/brian/thesis/outputs/feature_selection/churn/results")

useful_feature <- "F1_Score"
plot_dir <- "set_plots" # directory to place plots in wrt working directory
f1_scores <- data.frame()

set_number <- 1
for(set_number in 1:10) {
  set_str <- as.character(set_number)
  results_set <- paste("hybrid_longTermPlayer_set_", set_str, "_early_3_output.csv", sep="")
  input <- read.csv(results_set)
  for(lt in 4:16) {
    qry1 <- paste("SELECT X FROM input  WHERE X LIKE '%_ ", lt, "_;%' AND X NOT LIKE '%random%'", sep="")
    qry2 <- paste("SELECT ", useful_feature, "   FROM input  WHERE X LIKE '%_ ", lt, "_;%' AND X NOT LIKE '%random%' ", sep="")
    f1_col <- ""
    f1_col <- as.data.frame(sqldf(qry2))
    f1_col[is.na(f1_col)] <- 0
    max_f1 <- max(f1_col)
    
    f1_scores[set_number, lt-3] <- max_f1
  }
}
colnames(f1_scores) <- 4:16
trans <- as.data.frame(t(f1_scores))
write.csv(f1_scores, "f1_max.csv")
write.csv(trans, "f1_trans.csv")
