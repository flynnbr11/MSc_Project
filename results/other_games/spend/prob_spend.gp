set datafile separator ","
set style line 1 lc 1 lt 1 pt 7 lw 2
set style line 2 lc 10 lt 1 pt 7 lw 2
set style line 3 lc 3 lt 1 pt 7 lw 2
set style line 4 lc 4 lt 1 pt 7 lw 2
set style line 5 lc 6 lt 1 pt 7 lw 2 
set style line 6 lc -1 lt 1 pt 7 lw 2
set style line 7 lc 7 lt 1 pt 7 lw 2
set style line 8 lc 8 lt 1 pt 7 lw 2
set style line 9 lc 9 lt 1 pt 7 lw 2
set style line 10 lc 10 lt 1 pt 7 lw 2
set style line 11 lc 11 lt 1 pt 7 lw 2
set style line 12 lc 12 lt 1 pt 7 lw 2
set style line 13 lc 13 lt 1 pt 7 lw 2
set style line 14 lc 14 lt 1 pt 7 lw 2

set term png
set yrange[0:30]
set xlabel "Probability Threshold" 
set ylabel "F1 Score"
set key ins vert
set key top right
set arrow from 50, graph 0 to 50, graph 1 nohead
set output 'f_v_prob.png' 
file = 'all.csv'
plot \
file u 1:7 w l ls 6 title "Game A", \
file u 1:3 w l ls 2 title "B", \
file u 1:4 w l ls 3 title "C", \
file u 1:5 w l ls 4 title "D", \
file u 1:6 w l ls 5 title "E", \
#file u 1:10 w l ls 9 title columnheader, \
# file u 1:9 w l ls 10 title columnheader, \
# file u 1:8 w l ls 7 title columnheader, \

