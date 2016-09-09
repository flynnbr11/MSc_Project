set datafile separator ","
set style line 1 lc 1 lt 1 pt 7 lw 2
set style line 2 lc 2 lt 1 pt 7 lw 2 
set style line 3 lc 3 lt 1 pt 7 lw 2
set style line 4 lc 4 lt 1 pt 7 lw 2
set style line 5 lc -1 lt 1 pt 7 lw 2
set style line 6 lc 1 lt 1 pt 5 lw 2
set style line 7 lc 2 lt 1 pt 5 lw 2 
set style line 8 lc 3 lt 1 pt 5 lw 2
set style line 9 lc 4 lt 1 pt 5 lw 2

set term png
set xrange[1:5]
set xtics 1,1,5
set ytics 50,5,80
set yrange[47:80]
set xlabel "Early Behaviour Cutoff" 
set ylabel "F1 Score"
set key ins vert
set key bottom right
set arrow from 50, graph 0 to 50, graph 1 nohead
set output 'f_v_early_by_long.png' 
file = 'f_vals_by_long_cut.csv'
plot \
file u 1:2 w linespoints ls 1 title "6", \
file u 1:3 w linespoints ls 2 title "7", \
file u 1:4 w linespoints ls 3 title "8", \
file u 1:5 w linespoints ls 4 title "9", \
file u 1:6 w linespoints ls 5 title "10", \
file u 1:7 w linespoints ls 6 title "11", \
file u 1:8 w linespoints ls 7 title "12", \
file u 1:9 w linespoints ls 8 title "13", \
file u 1:10 w linespoints ls 9 title "Longterm Cutoff = 14", \
