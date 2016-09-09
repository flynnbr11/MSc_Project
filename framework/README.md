# deltaDNA Logistic Regression Framework
This package contains R scripts to run a logistic regression model 
to predict whether a new player is likely to become a long term player, 
or a spender, using data available to deltaDNA available on Vertica. 

Using parameters set in global_vars.R, queries are constructed in R 
and submitted to Vertica using RJDBC. 

There are then two main paths for building the model: directly in Vertica, 
or else by pulling the data from Vertica and modelling in R. Change what model_type 
is built in global_vars.R. 

To build in Vertica, more queries are constructed in R and submitted to use
inbuilt machine learning functions on Vertica (vertica_model.R). 

To build in R, data is pulled from Vertica and a GLM is run. 

## Variable Parameters
New models can be built by selecting the desired parameters in 
```
> global_vars.R
> feature_selection.R 
```
and sourcing 
```
> source("framework.R")
```
Note that at the top of framework.R, the working directory must be set to wherever this package is saved to. 
The libraries at the top of framework.R must be installed. 

### Variables which can be changed: 
* Features model is built using
** Numeric and categorical from User metrics table.
** Numeric and categorical from session records table. 
* Model Type:
** Predict whether a new player is likely to become
*** Long-term player
*** Spender
** Using: 
*** Machine learning functions offered in vertica. 
*** General linear model function in R (using data taken from Vertica). 
* Longterm cutoff: after playing for how many days is the player taken as long-term
* Early behaviour cutoff: beaviiour from how many days after signup to base model on. 
* Training timeframe: build a model using players who signed up during this timeframe.
* Testing timeframe: assess the model by making predictions on players who signup during this timeframe. 
* Environment ID: which game (environment) to build model on. 
* user_metrics table: which table to extract features from
* Probability threshold: 
** If model built in R, can choose which resultant probability to accept
** If in Vertica, default is 50% 
* Beta: For use in calculating F-beta measure (metric of supervised machine learning method). 


## Inventory
* Running framework to build new model. These are the most important to consider for building models without changing overall framework.
** global_vars.R: set all model parameters apart from features. 
** feature_selection.R: select which features are used in model.
** framework.R: calls on other scripts to organise data and build model. 
** framework_loops_example.R: shows where loops can wrap around calls in framework.R to generate mass data. Not intended to be ran. 
** vertica_user_name.R: the user's credentials must be set here so that the Vertica database can be accessed. 


* Directories: 
** outputs: for results. Has files for most recent parameters so framework can decide to build new tables or not. 
** outputs/results_directory: output CSVs are put here. directory name can be changed in global_vars.R, but must exist for framework to run.
** outputs/stats: model summaries are put here. 

* Generating models: 
** vertica_model.R
** hybrid_model.R

* Evaluating models:
** declare_metric_vectors.R 
** hybrid_metrics.R
** update_metrics_vectors.R
** export_results.R
** analysis_summaries.R

* Constructing Queries
** build_reg_model.R 
** build_reg_table.R
** compile_feature_lists.R
** make_predictions.R
** sample.R

* Submitting Queries to Vertica
** build_training_test_tables.R
** rebuild_tables.R
** (vertica_model.R also does but is listed as generating models) 

* Other: 
** random.R: add rows corresponding to random predictions to outputs.
** get_possible_features.R: generate a CSV of the available features for a given game. 
** model_parameters.R: sets the value of model_type based on value chosen in global_vars.R
** should_tables_rewrite.R: to determine whether the most recent tables built in Vertica are sufficient or should be rebuilt. 
** plot_auroc.R: used for plotting ROC curves and finding AUROC. Not used in framework currently. 
** vertica-jdbc-7.2.3-0.jar: Vertica driver to submit queries to Vertica. 


