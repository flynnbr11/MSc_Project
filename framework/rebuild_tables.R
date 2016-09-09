source("should_tables_rewrite.R") # reg_table only needs to rewrite if the basis features have changed so check that
source("build_reg_model.R") # to rewrite trainnig/test table queires with new longterm_cutoff

# Queries from sample.R
if(recreate_user_id_tables == 1 ) {
  try(dbSendUpdate(gacon, delete_split_table))
  try(dbSendUpdate(gacon, create_split_table))
}

#' Put useful features of players into one table 
#' Queries from build_reg_table.R
if(rebuild_reg_table == 1) { # only need to rewrite tables for new feature set; in should_tables_rewrite.R
  try(dbSendUpdate(gacon,deleteOldTable))
  try(dbSendUpdate(gacon,rebuildTable))
}

source("build_training_test_tables.R")
