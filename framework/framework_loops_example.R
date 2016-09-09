#' This script is the same as framework.R, but includes example positioning 
#' of for loops used to generate mass data for evaluation. 
#' To run loops, comment out the setting of the appropriate variable 
#' in global_vars.R, or else the loop will be overruled by that setting

#' This script builds and evaluates a logistic regression model by calling 
#' on other R scripts. 
#' All variable parameters can be changed in global_vars.R.
library(DBI)
library(rJava)
library(RJDBC)
setwd("/home/brian/thesis")

#' Need credentials to access vertica. Then set driverclass and classPath to appropriate locations.  
source("vertica_user_name.R") # hold username and password rather than having them here and uploading to git
vDriver = JDBC(driverClass="com.vertica.jdbc.Driver", classPath="vertica-jdbc-7.2.3-0.jar")
gacon = dbConnect(vDriver, "jdbc:vertica://109.169.65.105:5433/dd", user_name, pass)

#avail_games <- c(2880, 139, 2187, 4120, 4318, 4429, 2527,  2718)
#  for(env_id  in avail_games){
# for (setid in  c(1,3,6)) { 
#     for(model_type in c(3:3)){
      timer_start <- proc.time()
      source("global_vars.R") # Sets feature sets; game id and other variable parameters
      source("compile_feature_lists.R") # Formats feature sets to pass into SQL queries
      source("declare_metric_vectors.R") # Empty vectors used for evaluation of model
      
      source("sample.R") # Choose equal sample of user id's to be used during model
			source("build_reg_table.R") # Prepare SQL queries for building regression table
      source("make_predictions.R") # Prepare SQL queries to evaluate model

      if(build_spend_model == 1 ) { 
      	source("vertica_model.R") # Submit SQL queries to Vertica to build and evaluate model
        source("update_metrics_vectors.R") # Store evaluation metrics 
        source("random.R") # adds random predictions to compare the generated predictions to
      }
      
      if(build_churn_model == 1 ) {
      	for(longterm_cutoff in longterm_low:longterm_high) { # can generate different results depending on def of long term
      	  source("vertica_model.R")
      	  source("update_metrics_vectors.R")
      	  source("random.R")
		    }
      }
      
      if(build_hybrid_churn == 1 ) {
        for(longterm_cutoff in longterm_low:longterm_high) { 
            source("hybrid_model.R")
            source("hybrid_metrics.R")
            source("random.R") 
          #source("plot_auroc.R")
        }
        colnames(auroc_values) <- c("Features", "Longterm", "AUROC")
      }
      
      if(build_hybrid_spend == 1) {
          source("hybrid_model.R")
          source("hybrid_metrics.R")
          source("random.R") 
      }
      timer_end <- proc.time()
      model_time <- timer_end - timer_start
      
      source("analysis_summaries.R") # Analyse model and output results (only works for R?)
      source("export_results.R") # Save results to CSV
#    }
    feature_set <- as.data.frame(c(paste("Set number: ",setid, sep=""), paste("early : ", early_behaviour_num_days, sep=""), features_list))
    write.table(feature_set, paste("outputs/", output_dir, "/feature_sets.csv", sep=""), col.names=F, row.names=F, append=T, sep=",")
#  }
#}

dbDisconnect(gacon)
