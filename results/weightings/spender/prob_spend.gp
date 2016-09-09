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
set yrange[0:25]
set xrange [0:100]
set xlabel "Probability Threshold" 
set ylabel "F1 Score"
set key ins vert
set key top right
set arrow from 50, graph 0 to 50, graph 1 nohead
set output 'f_v_prob.png' 
file = 'f_vals.csv'
plot \
file u 1:3 w l ls 6 title "k=1", \
file u 1:4 w l ls 2 title "2", \
file u 1:5 w l ls 3 title "5", \
file u 1:6 w l ls 4 title "10", \
