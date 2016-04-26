
#include <stdio.h>


int main (int argc, char *argv[]) {
  int A = 25;
  int B = 16;
  int C = 7;
  int D = 4;
  int E = 9;
  
  int result;
  
  int *pA = &A;
  int *pB = &B;
  int *pC = &C;
  int *pD = &D;
  int *pE = &E;
  
  result = ((*pA - *pB) * (*pC + *pD)) / *pE;
  printf("result = %i", result);
  return 0;
}