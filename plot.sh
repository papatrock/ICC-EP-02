#!/bin/bash

PROG="matmult"
METRICA="FLOPS_DP L2CACHE L3"
CPU=3
DATA_DIR="Dados/"
TEMPOS="Resultados/Tempos.csv"
mkdir -p ${DATA_DIR} 

echo "performance" > /sys/devices/system/cpu/cpufreq/policy3/scaling_governor

make purge matmult

TAMANHOS="64 100 128 200 256 512 600 900 1024 2000 2048 4000"

for m in ${METRICA}
do
    LIKWID_LOG="${DATA_DIR}/${m}.log"
    for n  in $TAMANHOS
    do
        LIKWID_OUT="${DATA_DIR}/${m}_${n}.log" 
        echo "------------$m: ./${PROG} $n---------------"
        echo $n >> Resultados/Tamanhos.csv
        likwid-perfctr -C ${CPU} -g ${m} -o ${LIKWID_OUT} -m ./${PROG} ${n} >> ${TEMPOS}        
    done
done

#Filtra os dados a partir dos logs
RESULTADOS=$(ls -l Dados/ | awk '{print $9}')
for i in ${RESULTADOS}
do
    awk -F"," '(/DP MFLOP/ && !/AVX/){print $2}' Dados/$i >> Resultados/FLOPS_DP.csv
    awk -F"," '/L3 bandwidth/ {print $2}' Dados/$i >> Resultados/L3.csv
    awk -F"," '/L2 miss ratio/ {print $2}' Dados/$i >> Resultados/L2CACHE.csv
done

#Gera .dat dos tempos
paste -d ',' Resultados/Tamanhos.csv Resultados/Tempos.csv > Resultados/Tempos.dat

#Formata tabela de tamanhos
sort -g Resultados/Tamanhos.csv | uniq > Resultados/Tempos.csv
#Gera .dat FLOPS_DP
paste - - < Resultados/FLOPS_DP.csv | awk '{print $1","$2}' | paste -d ',' Resultados/Tempos.csv - > Resultados/FLOPS_DP.dat

#Gera .dat L2 CACHE
paste - - < Resultados/L2CACHE.csv | awk '{print $1","$2}' | paste -d ',' Resultados/Tempos.csv - > Resultados/L2CACHE.dat

#Gera .dat L3
paste - - < Resultados/L3.csv | awk '{print $1","$2}' | paste -d ',' Resultados/Tempos.csv - > Resultados/L3.dat

#Roda o script de plotar gráfico
gnuplot plot.gp

echo "powersave" > /sys/devices/system/cpu/cpufreq/policy3/scaling_governor
