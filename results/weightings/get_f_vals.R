require(sqldf)
dir <- "/home/brian/thesis/outputs/weightings_set_8/spender"
setwd(dir)
files<-list.files(dir, pattern="*output*")
#k <- 1
all <- data.frame(matrix(nrow=101))
for(k in c(1,2,5,10)) { 
  file <- paste("hybrid_spender_set_8_early_2_game_2880_k_",k,"_output.csv", sep="")
  
  dat <- read.csv(file)
  qry <- strwrap(
    paste(
      "SELECT  F1_Score
          FROM dat
          WHERE
            X NOT LIKE '%random%'
          ; "
    ), simplify=T, width=1e4)
  
  f1s <- sqldf(qry)
  f1s[is.na(f1s)] <- 0
  game_val <- as.character(k)
  all[game_val] <- f1s
}
write.csv(all, "f_vals.csv")
