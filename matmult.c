#include <stdio.h>
#include <stdlib.h>    /* exit, malloc, calloc, etc. */
#include <string.h>
#include <getopt.h>    /* getopt */
#include <time.h>

#include <likwid.h>
#include "matriz.h"

/**
 * Exibe mensagem de erro indicando forma de uso do programa e termina
 * o programa.
 */

static void usage(char *progname)
{
  fprintf(stderr, "Forma de uso: %s [ <ordem> ] \n", progname);
  exit(1);
}

typedef double rtime_t;

rtime_t timestamp (void)
{
  struct timespec tp;
  clock_gettime(CLOCK_MONOTONIC_RAW, &tp);
  return ( (rtime_t) tp.tv_sec*1.0e3 + (rtime_t) tp.tv_nsec*1.0e-6 );
}


/**
 * Programa principal
 * Forma de uso: matmult [ -n <ordem> ]
 * -n <ordem>: ordem da matriz quadrada e dos vetores
 *
 */

int main (int argc, char *argv[]) 
{
  int n=DEF_SIZE;
  
  MatRow mRow_1, mRow_2, resMat;
  Vetor vet, res;
  
  /* =============== TRATAMENTO DE LINHA DE COMANDO =============== */

  if (argc < 2)
    usage(argv[0]);

  n = atoi(argv[1]);
  
  /* ================ FIM DO TRATAMENTO DE LINHA DE COMANDO ========= */
 
  srandom(20232);
      
  res = geraVetor (n, 1); // (real_t *) malloc (n*sizeof(real_t));
  resMat = geraMatRow(n, n, 1);
    
  mRow_1 = geraMatRow (n, n, 0);
  mRow_2 = geraMatRow (n, n, 0);

  vet = geraVetor (n, 0);

  if (!res || !resMat || !mRow_1 || !mRow_2 || !vet) {
    fprintf(stderr, "Falha em alocação de memória !!\n");
    liberaVetor ((void*) mRow_1);
    liberaVetor ((void*) mRow_2);
    liberaVetor ((void*) resMat);
    liberaVetor ((void*) vet);
    liberaVetor ((void*) res);
    exit(2);
  }
    
#ifdef _DEBUG_
    printf("ORIGINAL\n");
    prnMat (mRow_1, n, n);
    prnMat (mRow_2, n, n);
    prnVetor (vet, n);
    prnVetor (res, n);
    prnMat (resMat, n, n);
    printf ("=================================\n\n");
#endif /* _DEBUG_ */

  double time;
  LIKWID_MARKER_INIT;


  LIKWID_MARKER_START("MulMatVet_");
  time = timestamp();
  multMatVet (mRow_1, vet, n, n, res);
  time = timestamp() - time;
  LIKWID_MARKER_STOP("MulMatVet_");
  printf("%f,",time);

  LIKWID_MARKER_START("MulMatMat_");
  time = timestamp();  
  multMatMat (mRow_1, mRow_2, n, resMat);
  time = timestamp() - time;
  LIKWID_MARKER_STOP("MulMatMat_");
  printf("%f\n",time);

    
  LIKWID_MARKER_CLOSE;

#ifdef _DEBUG_
    printf("RESULTADO 1 \n");
    prnVetor (res, n);
    prnMat (resMat, n, n);
#endif 

  res = geraVetor (n, 1);
  resMat = geraMatRow(n, n, 1);

  multMatVetOtimi (mRow_1, vet, n, n, res,UF);
  multMatMatOtimi (mRow_1, mRow_2, n, resMat,UF,BK);

  #ifdef _DEBUG_
    printf("RESULTADO 2 \n");	
    prnVetor (res, n);
    prnMat (resMat, n, n);
  #endif //_DEBUG_ 

  liberaVetor ((void*) mRow_1);
  liberaVetor ((void*) mRow_2);
  liberaVetor ((void*) resMat);
  liberaVetor ((void*) vet);
  liberaVetor ((void*) res);

  return 0;
}

