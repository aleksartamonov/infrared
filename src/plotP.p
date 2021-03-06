#! /usr/bin/gnuplot -persist
# Gnuplot script file for plotting data in files "tau.dat","P-to-tau.dat"

set terminal postscript eps enhanced
set style line 1 lt 1 pt 7
set xlabel 'lambda'
set ylabel 'P/tau'
set xrange [3:25]
set output '../plots/P-to-tau.eps'
plot ('../P/P-to-tau_1.dat') u 1:2 w lines  title "P(lambda)/tau(lambda) for alpha = pi/2",\
	 ('../P/P-to-tau_2.dat') u 1:2 w lines  title " alpha = pi/3",\
	 ('../P/P-to-tau_3.dat') u 1:2 w lines  title "alpha = pi/4",\
     ('../P/P-to-tau_4.dat') u 1:2 w lines  title "alpha = pi/6",\
     ('../P/P-to-tau_5.dat') u 1:2 w lines  title "alpha = pi/12",\
	 ('../P/P-to-tau_6.dat') u 1:2 w lines  title "alpha = pi/18"

