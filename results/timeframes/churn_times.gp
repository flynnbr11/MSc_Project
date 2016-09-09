set datafile separator ","
set style line 1 lc 1
set style line 1 lc 7 
set boxwidth 0.25
set style fill solid 
set term png
set output "churn_times.png"
set yrange [0:75]
set ylabel "F1-Score"
file = "timeframes.csv"
plot \
file using 2:xtic(1) with boxes lc 7 title "Churn Model" gap 1, \
