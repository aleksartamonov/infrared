#! /usr/bin/gnuplot -persist
# Gnuplot script file for plotting data in files "tau.dat","P-to-tau.dat"

set terminal postscript eps enhanced
set style line 1 lt 1 pt 7
set xlabel 'lambda'
set ylabel 'Tau / Tau (3mkm)'
set xrange [3:25]
set output '../plots/tau.eps'
plot ('../tau/tau_1.dat') u 1:2 w lines  title "Tau(lambda)/tau(3 mkm) for alpha = pi/2",\
	 ('../tau/tau_2.dat') u 1:2 w lines  title " alpha = pi/3",\
	 ('../tau/tau_3.dat') u 1:2 w lines  title "alpha = pi/4",\
     ('../tau/tau_4.dat') u 1:2 w lines  title "alpha = pi/6",\
     ('../tau/tau_5.dat') u 1:2 w lines  title "alpha = pi/12",\
	 ('../tau/tau_6.dat') u 1:2 w lines  title "alpha = pi/18"

