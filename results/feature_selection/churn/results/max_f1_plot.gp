set datafile separator ","
set style line 4 lc 4 lt 1  pt 1 lw 2 ps 3
set style line 5 lc -1 lt 1  pt 2 lw 2 ps 2
set style line 6 lc 1 lt 1  pt 7 lw 2 ps 1
set style line 8 lc 3 lt 1  pt 2 lw 2 ps 3

set style line 10 lc -1 lt 1 pt 1 ps 3 lw 2

set term png
set output "max_f1.png" 
set xrange[4:16]
set yrange[55:80]
set xlabel "Long-term Cutoff" 
set ylabel "F1 Score"
set key ins vert
set key right top
set arrow from 50, graph 0 to 50, graph 1 nohead
file = "f1_trans.csv"
plot \
file u 1:5 w linespoints ls 4 title "Set 4", \
file u 1:6 w linespoints ls 5 title "Set 5", \
file u 1:7 w linespoints ls 6 title "Set 6", \
file u 1:9 w linespoints ls 8 title "Set 8", \

#file u 1:10 w linespoints ls 6 title "Set 9", \
file u 1:4 w linespoints ls 7 title "Set 3", \
file u 1:8 w linespoints ls 8 title "Set 7", \
file u 1:3 w linespoints ls 9 title "Set 2", \
file u 1:11 w linespoints ls 10 title "Set 10", \


