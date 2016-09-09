require(sqldf)
setwd("/home/brian/thesis/outputs/feature_selection/churn/results")

set_number <- 3
set_str <- as.character(set_number)
input <- read.csv(results_set)
lt <- 8
multiline_plot <- matrix()

for(lt in 4:16){
  struct <- matrix()
  qry <- paste("select F1_Score from inp where X not like '%random%' and X like '% ", lt ," ;%' ", sep="")
  
  for(set_num in 1:10) {
    file_name <- paste("hybrid_longTermPlayer_set_", set_num, "_early_3_output.csv", sep="")
    inp <- read.csv(file_name)
    
    sqldf(qry)
    f1_vals <- sqldf(qry)
    f1_vals[is.na(f1_vals)] <- 0 
    set_name <- as.character(set_num)
    struct[set_name] <- f1_vals
  }
  
  df <- as.data.frame(struct)
  df['prob'] <- 0:(nrow(df)-1)
  
  f1_by_set <- df[, !(names(df) %in% 'NA.')]
  output_file <- paste("f1_v_prob_lt_", lt, ".csv", sep="")
  write.csv(f1_by_set, output_file)
}