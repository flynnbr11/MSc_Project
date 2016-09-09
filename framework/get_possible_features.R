#' Generate a CSV, available_features.csv, showing what can be taken from the two tables. 

library(DBI)
library(rJava)
library(RJDBC)
setwd("/home/brian/hpc/r_model/base_script_with_branches")
source("~/hpc/vertica_user_name.R") ## hold username and password rather than having them here and uploading to git
vDriver = JDBC(driverClass="com.vertica.jdbc.Driver", classPath="~/Vertica/vertica-jdbc-7.2.3-0.jar")
gacon = dbConnect(vDriver, "jdbc:vertica://edinlin01/ga", user_name, pass)

possible_user_features <- dbGetQuery(gacon, "SELECT * FROM ", user_metrics_table, " LIMIT 1")
possible_session_features <- dbGetQuery(gacon, "SELECT * FROM measure_v4.fact_user_sessions_day LIMIT 1") 

all_features <- c(colnames(possible_user_features), colnames(possible_session_features))


features_source <- vector()
for (x in 1:length(all_features)){
  if(all_features[x] %in% colnames(possible_user_features) && all_features[x] %in% colnames(possible_session_features)){
    features_source[x] <- "Both"   
  } else if(all_features[x] %in% colnames(possible_user_features)){
    features_source[x] <- "User"   
  } else{
    features_source[x] <- "Session"   
  }
}

available_features <- as.data.frame(cbind(features_source, all_features))
colnames(available_features) <- c("Source Table", "Feature")
write.csv(available_features, "available_features.csv")

dbDisconnect(gacon)
