require(sqldf)
setwd("/home/brian/thesis/outputs/feature_selection/churn/results")

useful_feature <- "F1_Score"
plot_dir <- "f1_plots" # directory to place plots in wrt working directory
set_number <- 3
set_str <- as.character(set_number)
results_set <- paste("hybrid_longTermPlayer_set_", set_str, "_early_3_output.csv", sep="")
input <- read.csv(results_set)
lt <- 8
multiline_plot <- matrix()
for (lt in 4:16){
  lt_col <- paste("Longterm_", lt, sep="")
  plot_name <- paste(plot_dir, "/", useful_feature, "_vs_Prob_lt_", lt, ".png", sep="")
  plot_title <- paste("F1 Score VS Probability Threshold for Longterm Cutoff = ", lt, sep="")
  qry1 <- paste("SELECT X FROM input  WHERE X LIKE '%_ ", lt, "_;%' AND X NOT LIKE '%random%'", sep="")
  qry2 <- paste("SELECT ", useful_feature, "   FROM input  WHERE X LIKE '%_ ", lt, "_;%' AND X NOT LIKE '%random%' ", sep="")

  output <- matrix()
  output['Name_Column'] <- sqldf(qry1)
  output['F1_Score'] <- sqldf(qry2)
  
  multiline_plot[lt_col] <- output['F1_Score']
  to_plot <- ""
  to_plot <- as.data.frame(output)
  to_plot['Probability_Threshold'] <- 0:nrow(to_plot)-1
  png(plot_name)
  plot(F1_Score ~ Probability_Threshold, data=to_plot, main=plot_title, type="b")
  #title(main=plot_title)
  dev.off()
}

plot_all <- as.data.frame(multiline_plot)

prob_vals <- 0:nrow(plot_all)-1

x<- 2
y <- x+4
plot_subset <- as.data.frame(plot_all[,x:y])
type_vec <- vector()
num_cols <- ncol(plot_subset)
for(i in 1:num_cols){
  type_vec[i] <- "p"
}
matplot(prob_vals, plot_subset, type=type_vec, col=1:num_cols)
legend("bottomleft", legend=colnames(plot_subset), col=1:num_cols, pch=16)

to_gnuplot <- plot_all
to_gnuplot['Probability_Threshold'] <- prob_vals
gnuplot_file <- paste(useful_feature, "_set_", set_number, "_retry.csv", sep="")
write.table(to_gnuplot, gnuplot_file)
to_gnuplot$Probability_Threshold
