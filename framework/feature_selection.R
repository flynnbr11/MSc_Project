### Feature selection ###
#' There are two tables which data is taken from:
#' user_metrics; fact_user_sessions_day
#' They both have categorical and numerical data
#' Select at least one cat/num from each, otherwise queries won't work; 
#' Features can be excluded if needed. 

#' Feature sets 1-10 are defined below.
#' To manually choose features, change set_id in global_vars.R to 0 
#' and choose features in the if(set_id==0) section: 
if(setid == 0 ) { #manually choose
  include_region <- 1 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c(i) # i,j
  session_features <- c("platform") # gender..
  numeric_session_features <- c(a,b) # a,b,f,g,h
  
  exclude_user_features <- c()
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
  
  first_day_only <- numeric_session_features  # For features which should only be included as first day, not also early totals
  early_only <- c("")
}

numerical_only <- 0 # set to 1 to only include numerical (i.e for builds in vertica using chosen features)

#' features a-j are predefined and are available for Game 2880, and possibly others.
a<- "number_of_events"
b<- "total_time_ms"
d <- "fieldDeviceTypeLast"
e <- "fieldPlatformLast"
f <- "missions_started"
g <- "missions_completed" 
h <- "missions_failed"
i <- "fieldFacebookFriendsAmountCount"
j<- "fieldFreeBeeVideoWatchedFirst"


if(setid==1) {
  include_region <- 0 # set to 1 to include region in prediction
  user_features <- c("user_first_seen_date") # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a,b) # a,b,f,g,h
  
  exclude_user_features <- user_features
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 2) {
  include_region <- 0 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a,b,f,g,h) # a,b,f,g,h
  
  exclude_user_features <- user_features
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 3) {
  include_region <- 1 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a,b) # a,b,f,g,h
  
  exclude_user_features <- user_features
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 4) {
  include_region <- 0 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a,b,f,g,h) # a,b,f,g,h
  
  exclude_user_features <- c()
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 5) {
  include_region <- 1 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c(i,j) # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a,b,f,g,h) # a,b,f,g,h
  
  exclude_user_features <- user_features
  exclude_numeric_features_list <- c()
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 6) {
  include_region <- 0 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a) # a,b,f,g,h
  
  exclude_user_features <- user_features
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 7) {
  include_region <- 0 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(b) # a,b,f,g,h
  
  exclude_user_features <- user_features
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 8) {
  include_region <- 1 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a,b) # a,b,f,g,h
  
  exclude_user_features <- c()
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 9) {
  include_region <- 1 # set to 1 to include region in prediction
  user_features <- c(d) # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a,b) # a,b,f,g,h
  
  exclude_user_features <- user_features
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  else if (setid == 10) {
  include_region <- 0 # set to 1 to include region in prediction
  user_features <- c(d,e) # d,e 
  numeric_user_features <-c("daysPlayedLast7Days") # i,j
  session_features <- c("gender") # gender..
  numeric_session_features <- c(a,b,f) # a,b,f,g,h
  
  exclude_user_features <- user_features
  exclude_numeric_features_list <- numeric_user_features
  
  exclude_session_features <- session_features
  exclude_numeric_session_features_list <- c()
}  

if(early_behaviour_num_days == 1) {
  #first_day_only <- numeric_session_features  # For features which should only be included as first day, not also early totals
  first_day_only <- c()
  early_only <- c()
} else {
  first_day_only <- c()
  early_only <- c(numeric_session_features)
}  

if(numerical_only == 1) { 
  exclude_user_features <-user_features
  exclude_session_features <- session_features
}

