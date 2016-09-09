#' Constructs the queries which can be called to build a logistic regression
#' model on Vertica. 

drop_training <- strwrap(paste("drop table ", schema, ".log_regression_training_table;", sep=""), simplify=T, width=1e5)
drop_test <- strwrap(paste("drop table ", schema, ".log_regression_test_table;", sep=""), simplify=T, width=1e5)

#' Makes separate training/test tables
log_regression_training_table<-strwrap(paste("
  create table ", schema, ".log_regression_training_table as (
  select 
  *,
  case
  when totalDaysPlayed > ", longterm_cutoff, " then 1
  else 0
  end as longTermPlayer,
  case
  when totalRealCurrencySpent > 0 then 1
  else 0
  end as spender
  from
  ", reg_table, "
  where 
  signup_timeframe = 'training_timeframe' limit 17500
  );
  ", sep=""),simplify=T,width=1e5)

log_regression_test_table<-strwrap(paste("
  create table ", schema, ".log_regression_test_table as (
  select 
  *,
  case
  when totalDaysPlayed > ", longterm_cutoff, " then 1
  else 0
  end as longTermPlayer,
  case
  when totalRealCurrencySpent > 0 then 1
  else 0
  end as spender
  from
  ", reg_table, "
  where 
  signup_timeframe = 'test_timeframe' limit 17500
  );
  ", sep=""),simplify=T,width=1e5)


#' Removes previous model of same name
delete_model <-strwrap(paste("  
  select
  v_ml.deleteModel('", model_name, "');
  ", sep=""),simplify=T,width=1e5)

#' Generate new model using selected features
build_model <-strwrap(paste("  
  select
  v_ml.logisticReg(
  '", model_name,"',
  ' ",schema, ".log_regression_training_table',
	'", target, "',
  ' 
  ", 
  predict_on_all                                   
  ,"
  ',
  '--epsilon=0.00001 --max_iterations=100'
  );
  ", sep=""),simplify=T,width=1e5,)

#' Summarise the model's coefficients etc.
summary_model <-strwrap(paste("  
  select
  v_ml.summarylogisticReg(
  using 
  parameters model_name = '", model_name,"',
  owner = '", user_name, "'
  );
  ", sep=""),simplify=T,width=1e5)
