#' Queries to build new tables in vertica to evaluate the vertica model.

delete_predicted_results <-strwrap(paste("  
	drop
	table
	predictedResults;
"),simplify=T,width=1e5)


predicted_results_table <-strwrap(paste("  
	create
	table
	predictedResults as(
	select
	user_id,
	", target, "
	,
	v_ml.predictlogisticReg(
	", 
	predict_on_all                            
	,"
	using parameters model_name = '", model_name, "',
	owner = '", user_name, "'
	) as prediction
	from
	log_regression_test_table
	);
", sep=""),simplify=T,width=1e5)

delete_check_accuracy <-strwrap(paste("  
	drop
	table
	check_accuracy;
"),simplify=T,width=1e5)

check_accuracy_table <-strwrap(paste("  
	create
		table
		check_accuracy as(
			with preliminary_table as(
				select
				case
				when ", target, " = 1 then 1
				else 0
				end as actual,
				case
				when prediction = 1 then 1
				else 0
				end as pred
				from
				predictedResults
			) 
			select
			case
				when actual = pred then 1 
				else 0
			end as correct,
			case
				when actual != pred then 1
				else 0
			end as incorrect,
			case
				when actual = 1 and pred = 1 then 1
				else 0
			end as true_positive,
			case
				when actual = 1 and pred = 0 then 1
				else 0
			end as false_negative,
			case
				when actual = 0 and pred = 1 then 1
				else 0
			end as false_positive,
			case
				when actual = 0 and pred = 0 then 1
				else 0
			end as true_negative
			from
			preliminary_table
			);
", sep=""),simplify=T,width=1e5)

delete_metrics <-strwrap(paste("  
	drop
	table
	metrics;
"),simplify=T,width=1e5)

metrics_table <-strwrap(paste("  
	create
	table
	metrics as(
	select
	100 *(
	sum( correct ) /(
	sum( correct ) + sum( incorrect )
	)
	) as accuracy,
	100 *(
	sum( true_positive ) /(
	sum( true_positive ) + sum( false_positive )
	)
	) as precision,
	100 *(
	sum( true_negative ) /(
	sum( true_negative ) + sum( false_positive )
	)
	) as specificity,
	100 *(
	sum( true_positive ) /(
	sum( true_positive ) + sum( false_negative )
	)
	) as sensitivity,
	sum( correct ) as total_correct,
	sum( incorrect ) as total_incorrect,
	sum( true_positive ) as total_true_positive,
	sum( true_negative ) as total_true_negative,
	sum( false_positive ) as total_false_positive,
	sum( false_negative ) as total_false_negative
	from
	check_accuracy
	);
",sep=""),simplify=T,width=1e5)

get_metrics <-strwrap(paste("  
	select
	precision,
	sensitivity,
	specificity,
	((2*precision*sensitivity)/(precision + sensitivity) ) as f_score,
	( ( (1 + (", beta, " *", beta, ") )*precision*sensitivity)/((precision*", beta, "*", beta, ") + sensitivity) ) as f_beta,
	accuracy,
	total_true_positive,
	total_false_negative,	
	total_false_positive,
	total_true_negative
	from
	metrics;
", sep=""),simplify=T,width=1e5)
