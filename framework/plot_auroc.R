#' From \link{http://stats.stackexchange.com/questions/145566/how-to-calculate-area-under-the-curve-auc-or-the-c-statistic-by-hand}
#' Used to calculate Area Under ROC Curve, auroc

plot_visual <- 1 # Change to 1 to visualise plot
plot_name <- paste("roc_plots/ROC_longterm_", longterm_cutoff, "_", model_name, ".jpg", sep="") 

if(plot_visual == 1) {
  jpeg(plot_name)
  plot(spec_auroc, sens_auroc, type="b", xlim=c(0,100), ylim=c(0,100), lwd=1.5,
       xlab="1 − Specificity", ylab="Sensitivity", col="black")
  grid()
  abline(0,1, col="red", lty=2)
  dev.off()
}

sp <- spec_auroc/100
sen <- sens_auroc/100
height = (sen[-1]+sen[-length(sen)])/2
width = -diff(sp) # = diff(rev(omspec))
auroc <- sum(height*width)

auroc_val <-list(setid, early_behaviour_num_days, longterm_cutoff, paste("Set number: ", setid, sep=""), paste("Early cutoff :", early_behaviour_num_days), paste("Longterm cutoff: ", longterm_cutoff), auroc)   
#auroc_values <- rbind(auroc_values, auroc_val)
auroc_file <- paste("outputs/",output_dir, "/auroc_churn.csv", sep="")

if(build_hybrid_churn==1){
  write.table(auroc_val, auroc_file, sep=",", append=T, col.names=F, row.names=F)
}
