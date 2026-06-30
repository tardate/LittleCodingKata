#include <stdio.h>
#include <stdlib.h>
#include <math.h>

unsigned countBits(unsigned int number) {
  return (int)log2(number)+1;
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("Usage: %s <number>\n", argv[0]);
    return 1;
  }
  unsigned int num = (unsigned int)atoi(argv[1]);
  printf("%d\n", countBits(num));
  return 0;
}
