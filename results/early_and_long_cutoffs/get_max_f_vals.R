require(sqldf)
setwd("/home/brian/thesis/outputs/new_early")

model_type <- "longTermPlayer" # or longTermPlayer

f_vals <- data.frame()
for(early_cut in 1:5){ 
  early <- as.character(early_cut)
  input_file <- paste("hybrid_", model_type,"_set_8_early_", early, "_game_2880_output.csv", sep="")
  dat <- read.csv(input_file)
  ind <- 1
  for (lt in 6:14){
    qry <- paste("SELECT F1_Score FROM dat WHERE X LIKE '% ", lt," ;%' AND X NOT LIKE '%random%' ", sep="")
    f1 <- sqldf(qry)
    f1[is.na(f1)] <- 0
    f_vals[early_cut ,ind] <- max(f1)
    ind <- ind + 1
  }
}
colnames(f_vals) <- 6:14
write.csv(f_vals, "f_vals_by_long_cut.csv")

f_vals_spend <- data.frame()
for(early_cut in 1:5){ 
  early <- as.character(early_cut)
  model_type <- "spender"
  input_file <- paste("hybrid_", model_type,"_set_8_early_", early, "_game_2880_output.csv", sep="")
  dat <- read.csv(input_file)
  ind <- 1
  qry <- paste("SELECT F1_Score FROM dat WHERE X NOT LIKE '%random%' ", sep="")
  f1 <- sqldf(qry)
  f1[is.na(f1)] <- 0
  f_vals_spend[early_cut ,ind] <- max(f1)
  ind <- ind + 1
}
colnames(f_vals_spend)<-1
write.csv(f_vals_spend, "f_vals_spend.csv")
