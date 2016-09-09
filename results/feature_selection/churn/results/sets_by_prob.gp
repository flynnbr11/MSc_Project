set datafile separator ","
set style line 1 lc 1 lt 0 pt 7
set style line 2 lc 2 lt 0 pt 7 
set style line 3 lc 3 lt 0 pt 7
set style line 4 lc 4 lt 0 pt 7
set style line 5 lc 5 lt 0 pt 7
set style line 6 lc 6 lt 1 pt 7
set style line 7 lc 7 lt 1 pt 7
set style line 8 lc 8 lt 0 pt 7
set style line 9 lc 9 lt 0 pt 7
set style line 10 lc 10 lt 0 pt 7
set style line 11 lc 11 lt 0 pt 7
set style line 12 lc 12 lt 0 pt 7
set style line 13 lc 13 lt 0 pt 7
set style line 14 lc 14 lt 0 pt 7

set term png
set output "f1_vs_prob_by_set.png" 
set xrange[0:100]
set yrange[0:100]
set xlabel "Probability Threshold" 
set ylabel "F1 Score"
set key out vert
set key right top
set arrow from 50, graph 0 to 50, graph 1 nohead
set title "F1 Score VS Probability Threshold per Feature Set"
plot "F1_Score_set_3.csv" using 16:3 w l title "Longterm = 4" ls 1, \
"F1_Score_set_3.csv" using 16:7 w l title "set 3" ls 1, \
"F1_Score_set_4.csv" using 16:7 w l title "4" ls 2, \
"F1_Score_set_5.csv" using 16:7 w l title "5" ls 3, \
"F1_Score_set_6.csv" using 16:7 w l title "6" ls 4, \
"F1_Score_set_7.csv" using 16:7 w l title "7" ls 5, \



#"F1_Score_set_3.csv" using 16:4 w l title "Longterm = 5" ls 2, \
"F1_Score_set_3.csv" using 16:5 w l title "Longterm = 6" ls 3, \
"F1_Score_set_3.csv" using 16:6 w l title "Longterm = 7" ls 4, \
"F1_Score_set_3.csv" using 16:7 w l title "Longterm = 8" ls 5, \
"F1_Score_set_3.csv" using 16:8 w l title "Longterm = 9" ls 6, \
"F1_Score_set_3.csv" using 16:9 w l title "Longterm = 10" ls 7, \
"F1_Score_set_3.csv" using 16:10 w l title "Longterm = 11" ls 8, \
"F1_Score_set_3.csv" using 16:11 w l title "Longterm = 12" ls 9, \
"F1_Score_set_3.csv" using 16:12 w l title "Longterm = 13" ls 6, \
"F1_Score_set_3.csv" using 16:12 w l title "Longterm = 14" ls 7, \
"F1_Score_set_3.csv" using 16:14 w l title "Longterm = 15" ls 8, \
"F1_Score_set_3.csv" using 16:15 w l title "Longterm = 16" ls 9, \

