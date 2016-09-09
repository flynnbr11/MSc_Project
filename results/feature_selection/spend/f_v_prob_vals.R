require(sqldf)
setwd("/home/brian/thesis/outputs/feature_selection/spend/early1")

struct <- matrix()

set_num <- 1
for(set_num in 1:10) {
  file_name <- paste("hybrid_spender_set_", set_num, "_early_1_output.csv", sep="")
  dat <- as.data.frame(read.csv(file_name))
  
  qry <- "SELECT F1_Score FROM dat WHERE X NOT LIKE '%random%'" 
  f1_vals <- sqldf(qry)
  f1_vals[is.na(f1_vals)] <- 0 
  set_name <- as.character(set_num)
  struct[set_name] <- f1_vals
}

df <- as.data.frame(struct)
df['prob'] <- 0:(nrow(df)-1)

f1_by_set <- df[, !(names(df) %in% 'NA.')]
write.csv(f1_by_set, "f1_by_set.csv")

