#' Rebuild reg_table and user_id selection only when the dates/features/game_id/early_cutoff have been changed

source("global_vars.R") #should already be loaded when called but included so this script can run indepdendently

new_dates <- as.data.frame(c(training_start_date, training_end_date, test_start_date, test_end_date))
new_features <- as.data.frame(c(user_features, numeric_user_features, session_features, numeric_session_features))

old_dates <- read.table("outputs/most_recent_dates.txt")
old_features <- read.table("outputs/most_recent_features.txt")

old_early_cutoff <- read.table("outputs/most_recent_early_cutoff.txt")
new_early_cutoff <- early_behaviour_num_days

old_game_id <- read.table("outputs/most_recent_game_id.txt")
new_game_id <- env_id

if( length(setdiff(old_dates, new_dates)) != 0 || length(setdiff(new_dates, old_dates)) != 0 
    || length(setdiff(old_game_id, new_game_id)) != 0 ) {
  recreate_user_id_tables <- 1
} else { recreate_user_id_tables <- 1} ## take this out 


#' Rebuild reg_table when the feature list OR dates have been changed

if( length(setdiff(old_features, new_features)) != 0 || length(setdiff(new_features, old_features)) != 0 
    || length(setdiff(old_dates, new_dates)) != 0 || length(setdiff(new_dates, old_dates)) != 0 
    || length(setdiff(old_early_cutoff, new_early_cutoff)) !=0 
    || length(setdiff(old_game_id, new_game_id)) != 0 ) { 
  rebuild_reg_table <- 1 
} else { rebuild_reg_table <- 1}

#' Save the features/dates which were used to build the most recent table to check against in next iteration
write.table(new_features, "outputs/most_recent_features.txt")
write.table(new_dates, "outputs/most_recent_dates.txt")
write.table(old_early_cutoff, "outputs/most_recent_early_cutoff.txt")
write.table(new_game_id, "outputs/most_recent_game_id.txt")
