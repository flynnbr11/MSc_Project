require(sqldf)
setwd("/home/brian/thesis/outputs/timeframes")

dir <- "year2"
model_type <- "longTermPlayer"
tally <- data.frame()
vec <- matrix(ncol=3, nrow=6)
ind <- 0 
v <- list()
for (dir in c("year2", "quarter2", "same2")) {
  for ( model_type in c("longTermPlayer", "spender")){
    file <- paste(dir, "/hybrid_", model_type ,"_set_8_early_2_game_2880_output.csv", sep="")
    dat <- read.csv(file)
    ind <- ind + 1
    qry <- "SELECT F1_Score FROM dat"
    f1 <- sqldf(qry)
    f1[is.na(f1)] <- 0 
    max <-max(f1)
    v <- c(dir, model_type, max)
    vec[ind,] <- v
    #tally <- rbind(tally, vec)
  }
}
colnames(tally) <- c("Time", "Model", "Max F1")
write.csv(vec, "timeframes.csv")
