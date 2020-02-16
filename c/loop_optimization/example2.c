#include <stdlib.h>

#define SIZE 100

int main(void) {
  volatile double *a;
  a = calloc(SIZE, sizeof *a);

  for (size_t i = 0; i < SIZE; ++i) {
    a[i] = a[i];
  }

  free((void *)a);
}
