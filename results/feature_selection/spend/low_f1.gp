set datafile separator ","
set style line 1 lc 1 lt 1 pt 7 lw 2
set style line 2 lc 2 lt 1 pt 7 lw 2
set style line 3 lc 3 lt 1 pt 7 lw 2
set style line 4 lc 4 lt 1 pt 7 lw 2
set style line 5 lc 5 lt 1 pt 7 lw 2
set style line 6 lc 6 lt 1 pt 7 lw 2
set style line 7 lc 7 lt 1 pt 7 lw 2
set style line 8 lc 8 lt 1 pt 7 lw 2
set style line 9 lc 9 lt 1 pt 7 lw 2
set style line 10 lc 10 lt 1 pt 7 lw 2
set style line 11 lc 11 lt 1 pt 7 lw 2
set style line 12 lc 12 lt 1 pt 7 lw 2
set style line 13 lc 13 lt 1 pt 7 lw 2
set style line 14 lc 14 lt 1 pt 7 lw 2

set term png
set output "low_f_scores_by_set.png" 
set xrange[0:100]
set yrange[0:20]
set xlabel "Probability Threshold" 
set ylabel "F1 Score"
set key ins vert
set key right top
set arrow from 50, graph 0 to 50, graph 1 nohead
file = "f1_by_set.csv"
plot \
file  u 12:2 w l ls 1 title "Set 1", \
file  u 12:3 w l ls 2 title "Set 2", \
file  u 12:5 w l ls 3 title "Set 4", \
file  u 12:7 w l ls 4 title "Set 6", \
file  u 12:8 w l ls 5 title "Set 7", \
file  u 12:11 w l ls 10 title "Set 10", \
