#' This script only translates the user's choice of model
#' to a number of switches
#' for simplicity throughout the rest of the framework

build_churn_model <- 0
build_spend_model <- 0
build_hybrid_churn <-0
build_hybrid_spend <- 0

if(model_type == 1) {
  build_churn_model <- 1
} else if (model_type == 2) {
  build_spend_model <- 1
} else if(model_type == 3 ) { 
  build_hybrid_churn <-1
} else if(model_type == 4) {
  build_hybrid_spend <- 1
}

if(build_spend_model == 1 || build_hybrid_spend == 1) {
  target <- "spender"
}

if(build_churn_model == 1 || build_hybrid_churn == 1) {
  target <- "longTermPlayer"
} 

if(build_hybrid_spend == 1|| build_hybrid_churn == 1) {
  language <- "hybrid"
} else {
  language <- "vertica"
}

model_name <- paste(language, "_", target, sep="")
