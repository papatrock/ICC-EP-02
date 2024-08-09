<h1> Orientações gerais </h1>

O enunciado do exercício está <A HREF="https://moodle.c3sl.ufpr.br/mod/assign/view.php?id=47421">aqui</a>
<BR>
<BR>
O arquivo <B>perfctr</B> é um <I>script</I> shell para facilitar o uso de <I>likwid-perfctr</I>.
<BR><BR>

O arquivo <B>LIKWID-INSTALL.txt</B> são orientações APENAS para os alunos que desenvolvem este execício em uma instalação LINUX standalone. Estas orientações não devem ser seguidas caso sejam usadas as máquinas do LAB-3/DINF. 

<h1> GUIA DE ACESSO ÀS MÁQUINAS DO LABORATÓRIO LAB12 / DINF </h1>

Nos acessos abaixo, sempre use seu login/senha nas máquinas do DINF

<ol>
<LI> Copiar seus arquivos locais para a máquina 'macalan':

      scp -rp <sua_pasta_com_exercicio> <user_dinf>@macalan.c3sl.ufpr.br:.

<LI> Acessar 'macalan' com

      ssh <user_dinf>@macalan.c3sl.ufpr.br

<LI> Uma vez na 'macalan'

     ssh <maq_DINF>

        onde <maq_LAB12_DINF> = hxx, conforme o computador utilizado


<LI> <B>ATENÇÃO:</B> Lembre-se de RECOMPILAR SEUS PROGRAMAS em <B>maq_LAB12_DINF</B>
</ol>


<h1> GUIA DE CONFIGURAÇÃO DE FREQUENCIA DE RELÓGIO EM LINUX </h1>
<ol>
<LI> Execute a seguinte linha de comando:

     echo "performance" > /sys/devices/system/cpu/cpufreq/policy3/scaling_governor

<LI> Para retornar à frequencia original

     echo "powersave" > /sys/devices/system/cpu/cpufreq/policy3/scaling_governor
</ol>

<h1> GUIA DE CONFIGURAÇÃO DO LINUX PARA USO DO LIKWID </h1>
<ol>
<LI> Acrescentar linhas abaixo em '${HOME}/.bashrc' ou '/etc/profile':

       export LIKWID_HOME="/home/soft/likwid"
 
       if [ -d "${LIKWID_HOME}" ] ; then
	        PATH="$PATH:${LIKWID_HOME}/bin:${LIKWID_HOME}/sbin"
	        export LIKWID_LIB="${LIKWID_HOME}/lib"
	        export LIKWID_INCLUDE="${LIKWID_HOME}/include"
	        export LIKWID_MAN="${LIKWID_HOME}/man"
	        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${LIKWID_LIB}"
	        export MANPATH="$MANPATH:${LIKWID_MAN}"
       fi
     

<LI> Opções para compilação de programas:

       gcc -DLIKWID_PERFMON -I${LIKWID_INCLUDE} -c <prog.c>
       gcc -o <prog> <prog.o> -L${LIKWID_LIB} -llikwid


       * Nos códigos-fonte deve-se colocar

            #include <likwid.h>

</OL>

# Arquitetura do processador utilizado j15:
--------------------------------------------------------------------------------
CPU name:       Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz
CPU type:       Intel Core Haswell processor
CPU stepping:   3
********************************************************************************
Hardware Thread Topology
********************************************************************************
Sockets:                1
Cores per socket:       4
Threads per core:       2
--------------------------------------------------------------------------------
HWThread        Thread          Core            Socket          Available
0               0               0               0               *
1               0               1               0               *
2               0               2               0               *
3               0               3               0               *
4               1               0               0               *
5               1               1               0               *
6               1               2               0               *
7               1               3               0               *
--------------------------------------------------------------------------------
Socket 0:               ( 0 4 1 5 2 6 3 7 )
--------------------------------------------------------------------------------
********************************************************************************
Cache Topology
********************************************************************************
Level:                  1
Size:                   32 kB
Type:                   Data cache
Associativity:          8
Number of sets:         64
Cache line size:        64
Cache type:             Non Inclusive
Shared by threads:      2
Cache groups:           ( 0 4 ) ( 1 5 ) ( 2 6 ) ( 3 7 )
--------------------------------------------------------------------------------
Level:                  2
Size:                   256 kB
Type:                   Unified cache
Associativity:          8
Number of sets:         512
Cache line size:        64
Cache type:             Non Inclusive
Shared by threads:      2
Cache groups:           ( 0 4 ) ( 1 5 ) ( 2 6 ) ( 3 7 )
--------------------------------------------------------------------------------
Level:                  3
Size:                   8 MB
Type:                   Unified cache
Associativity:          16
Number of sets:         8192
Cache line size:        64
Cache type:             Inclusive
Shared by threads:      8
Cache groups:           ( 0 4 1 5 2 6 3 7 )
--------------------------------------------------------------------------------
********************************************************************************
NUMA Topology
********************************************************************************
NUMA domains:           1
--------------------------------------------------------------------------------
Domain:                 0
Processors:             ( 0 4 1 5 2 6 3 7 )
Distances:              10
Free memory:            4872.17 MB
Total memory:           7830.38 MB
--------------------------------------------------------------------------------


********************************************************************************
Graphical Topology
********************************************************************************
Socket 0:
+---------------------------------------------+
| +--------+ +--------+ +--------+ +--------+ |
| |  0 4   | |  1 5   | |  2 6   | |  3 7   | |
| +--------+ +--------+ +--------+ +--------+ |
| +--------+ +--------+ +--------+ +--------+ |
| |  32 kB | |  32 kB | |  32 kB | |  32 kB | |
| +--------+ +--------+ +--------+ +--------+ |
| +--------+ +--------+ +--------+ +--------+ |
| | 256 kB | | 256 kB | | 256 kB | | 256 kB | |
| +--------+ +--------+ +--------+ +--------+ |
| +-----------------------------------------+ |
| |                   8 MB                  | |
| +-----------------------------------------+ |
+---------------------------------------------+

