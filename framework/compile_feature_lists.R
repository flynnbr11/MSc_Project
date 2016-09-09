#' Take selected features from feature_selection.R 
#' and generate several lists needed in other scripts. 

remove_trailing_characters <- function(input_string, num_to_cut) {
  input_string <- substr(input_string, 1, nchar(input_string)-num_to_cut)
}

source("global_vars.R")
user_features_to_extract <- ""
u_user_features_to_extract <- ""
user_features_list <- list()
for (x in user_features) {
  user_features_to_extract <- paste(user_features_to_extract, x, ", ")
  u_user_features_to_extract <- paste(u_user_features_to_extract, " u.", x, ",", sep="")
  if(!(x %in% exclude_user_features)){
    user_features_list <- c(x, user_features_list)
  }
}

session_features_to_extract <- ""
o_session_features_to_extract <- ""
session_features_list <- list()
for (x in session_features){
  session_features_to_extract <- paste(session_features_to_extract, x, ", ")
  o_session_features_to_extract <- paste(o_session_features_to_extract, " o.", x, ", ", sep="")
  if(!(x %in% exclude_session_features)){
    session_features_list <- c(x, session_features_list)
  }
}

train_model_on_all <- ""
predict_on_all <- ""
numeric_summaries <- "" 
u_numeric_summaries <- "" 
numeric_user_features_list <- list()
for (x in numeric_user_features) {
  numeric_summaries <- paste(numeric_summaries, "case when ", x, " is null then 0 else ", x , " end as Summary_", x, ", ",sep="") 
  u_numeric_summaries <- paste(u_numeric_summaries, "u.Summary_", x, ", ", sep="")
  train_model_on_all <- paste(train_model_on_all, " 'Summary_", x, "', ", sep="" )
  if( !(x %in% exclude_numeric_features_list)) {
    numeric_user_features_list <- c(numeric_user_features_list, paste("Summary_", x, sep=""))
    predict_on_all <- paste(predict_on_all, " Summary_", x, ", ", sep="" )
  }
}

first_day_sums <- ""
first_day_extract <- ""
early_sums <- ""
early_extract <- ""
numeric_session_features_list <- list()
for (x in numeric_session_features) {
  first_day_sums <- paste(first_day_sums, "sum(", x, ") as first_day_",x, ", ", sep="" )
  first_day_extract <- paste( first_day_extract, "f.first_day_", x, ", ", sep="")
  early_sums <- paste(early_sums, "sum(", x, ") as early_",x, ", ", sep="" )
  early_extract <- paste( early_extract, "t.early_", x, ", ", sep="")
  train_model_on_all <- paste(train_model_on_all, " 'first_day_", x, "', 'early_", x, "', ", sep="" )

  if(x %in% first_day_only){
    predict_on_all <- paste(predict_on_all, " first_day_", x, ", ", sep="" )
    numeric_session_features_list <- c(numeric_session_features_list, paste("first_day_", x, sep=""))
  } else if( x %in% early_only){
    predict_on_all <- paste(predict_on_all, " early_", x, ", ", sep="" )
    numeric_session_features_list <- c(numeric_session_features_list, paste("early_", x, sep=""))
  }
  else if(!(x %in% exclude_numeric_session_features_list) ) {
    predict_on_all <- paste(predict_on_all, " first_day_", x, ", early_", x, ", ", sep="" )
    numeric_session_features_list <- c(numeric_session_features_list, paste("first_day_", x, sep=""), paste("early_", x, sep=""))
  }
  
}

## Remove trailing commas 
user_features_to_extract <- remove_trailing_characters(user_features_to_extract, 2)
u_user_features_to_extract <- remove_trailing_characters(u_user_features_to_extract, 1)
train_model_on_all <- remove_trailing_characters(train_model_on_all, 2)
predict_on_all<- remove_trailing_characters(predict_on_all, 2)
numeric_summaries <- remove_trailing_characters(numeric_summaries, 2)
u_numeric_summaries<- remove_trailing_characters(u_numeric_summaries, 2)
session_features_to_extract <- remove_trailing_characters(session_features_to_extract, 2)
o_session_features_to_extract <- remove_trailing_characters(o_session_features_to_extract, 2)
first_day_sums<- remove_trailing_characters(first_day_sums, 2)
first_day_extract<- remove_trailing_characters(first_day_extract, 2)
early_sums<- remove_trailing_characters(early_sums, 2)
early_extract<- remove_trailing_characters(early_extract, 2)
