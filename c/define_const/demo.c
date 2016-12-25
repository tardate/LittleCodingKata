#include <stdio.h>

#define A 1
#define B A + 1
#define C 3
#define X B * C
#define B2 (A + 1)
#define X2 B2 * C

const int A3 = 1;
const int B3 = A3 + 1;
const int C3 = 3;
const int X3 = B3 * C3;

#define C 3

int main(){
  printf("The power of parentheses...\n");
  printf("X  = B * C  = A + 1 * 3   = 1 + 1 * 3   = %d (wrong!)\n", X);
  printf("X2 = B2 * C = (A + 1) * 3 = (1 + 1) * 3 = %d (correct)\n", X2);
  printf("Using const overcomes the issues and with extra type safety...\n");
  printf("X3 = B3 * C3 = (A3 + 1) * 3 = (1 + 1) * 3 = %d (correct)\n", X3);
}
