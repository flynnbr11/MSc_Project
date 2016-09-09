set datafile separator ","
set style line 1 lc 1 lt 1 pt 7 lw 2 ps 2

set term png
set xrange[1:5]
set xtics 1,1,5
set ytics 18,1,22
set yrange[18:22]
set xlabel "Early Behaviour Cutoff" 
set ylabel "F1 Score"
set key ins vert
set key top right
set arrow from 50, graph 0 to 50, graph 1 nohead
set output 'f_v_early_spend.png' 
file = 'f_vals_spend.csv'
plot \
file u 1:2 w linespoints ls 1 title "Spender Model", \

