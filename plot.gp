#!/usr/bin/gnuplot -c
set grid
set style data point
set style function line
set style line 1 lc 3 pt 7 ps 0.3
set boxwidth 1
set xtics
set xrange [64:4500]
set xlabel  "N (bytes)"

set logscale x
# set logscale y

## set datafile separator {whitespace | tab | comma | "<chars>"}
set datafile separator comma

#
# TEMPO
#
ARQ=ARG1."./Resultados/Tempos.dat"
set key left top
set logscale y
set ylabel  "Tempo (ms)"
set title   "Tempo"
set terminal png
set output "./Graficos/Tempo.png"
plot './Resultados/Tempos.dat' using 1:2 title "MatxVet" with linespoints, \
     '' using 1:3 title "MatxMat" with linespoints, \
     '' using 1:4 title "MatxVetOtimizado" with linespoints, \
     '' using 1:5 title "MatxMatOtimizado" with linespoints
replot
unset output


#
# FLOPS_DP
#
ARQ=ARG1."./Resultados/FLOPS_DP.dat
set key right top
unset logscale y
set ylabel  "FLOPS DP [MFlops/s]"
set title   "FLOPS DP"
set terminal png
set output "./Graficos/FLOPS_DP.png"
plot './Resultados/FLOPS_DP.dat' using 1:2 title "MatxVet" with linespoints, \
     '' using 1:3 title "MatxMat" with linespoints, \
     '' using 1:4 title "MatxVetOtimizado" with linespoints, \
     '' using 1:5 title "MatxMatOtimizado" with linespoints
replot
unset output

#
# L3
#
ARQ=ARG1."./Resultados/L3.dat
set key left top
unset logscale y
set ylabel  "L3 [MBytes/s]"
set title   "L3"
set terminal png
set output "./Graficos/L3.png"
plot './Resultados/L3.dat' using 1:2 title "MatxVet" with linespoints, \
     '' using 1:3 title "MatxMat" with linespoints, \
     '' using 1:4 title "MatxVetOtimizado" with linespoints, \
     '' using 1:5 title "MatxMatOtimizado" with linespoints
replot
unset output

#
# L2CACHE
#
ARQ=ARG1."./Resultados/L2CACHE.dat
set key right bottom
unset logscale y
set ylabel  "L2 miss ratio"
set title   "L2 miss ratio"
set terminal png
set output "./Graficos/L2CACHE.png"
plot './Resultados/L2CACHE.dat' using 1:2 title "MatxVet" with linespoints, \
     '' using 1:3 title "MatxMat" with linespoints, \
     '' using 1:4 title "MatxVetOtimizado" with linespoints, \
     '' using 1:5 title "MatxMatOtimizado" with linespoints
replot
unset output


#
# ENERGY
#
ARQ=ARG1."./Resultados/ENERGY.dat"
set key center top
unset logscale y
set ylabel  "Energia [J]"
set title   "Energia"
set terminal png
set output "./Graficos/ENERGY.png"
plot './Resultados/ENERGY.dat' using 1:2 title "MatxVet" with linespoints, \
     '' using 1:3 title "MatxMat" with linespoints, \
     '' using 1:4 title "MatxVetOtimizado" with linespoints, \
     '' using 1:5 title "MatxMatOtimizado" with linespoints
replot
unset output