#' Use the training/test tables built in vertica to build a logistic regression model in R.
#' Categorical variables are encoded as factors here. 

source("rebuild_tables.R")

train <- dbGetQuery(gacon, "SELECT * FROM log_regression_training_table")
test <- dbGetQuery(gacon, "SELECT * FROM log_regression_test_table")

factor_variables <- c("region", user_features, session_features )
train[factor_variables] <- as.data.frame(apply(train[factor_variables],2,as.factor))
test[factor_variables] <- as.data.frame(apply(test[factor_variables],2,as.factor))


features <- ""
if(include_region == 1) {
  features_list <- c(user_features_list, session_features_list, numeric_user_features_list, numeric_session_features_list, "region")
} else{
  features_list <- c(user_features_list, session_features_list, numeric_user_features_list, numeric_session_features_list)
}

for ( f in features_list) {
  features <- paste(f, "+", features)
}
features <- remove_trailing_characters(features, 2)

if( (training_start_date == test_start_date) && (training_end_date == test_end_date) ){
	#' If model to be trained and tested on same dates, 
	#' merge all data and subsample randomly to get training/test sets. 
	all_data <- merge(test, train, all=TRUE)
	all_data[factor_variables] <- as.data.frame(apply(all_data[factor_variables],2,as.factor))
	smp_size <- floor(0.5*nrow(all_data))
	set.seed(123)
	train_ind <- sample(seq_len(nrow(all_data)), size=smp_size)
	training_set <- all_data[train_ind,]
	test_set <- all_data[-train_ind, ] # use these as training and test sets to train/test on same time period
	
} else {
	#' Otherwise just take the train/test dataframes directly
	training_set <- train # can change this to a subset of all_data instead
	test_set <- test
}

#' If there are factors in test set not present in training set, set them to 0
for(f in factor_variables){
  unknown_levels <- which(!(test_set[,f] %in% levels(training_set[,f])))
  if(length(unknown_levels) > 0) {
    test_set[unknown_levels, f] <- NA
  }
}

#' Weight positive cases by k, set in global_vars.R
weightings <- ifelse(training_set[target]==1, k, 1)
to_fit <- paste(target, " ~ ", features)

#' Fit a general linear model
model <- glm(to_fit, data=training_set, family=binomial(link="logit"), weights=weightings)
#' Add results of log reg model to test data - i.e. the log odds calculated
test_set$log_odds <- predict(model, newdata=test_set)
model_summary <- summary.glm(model)$coefficients # do this just after its constructed in the individual models
