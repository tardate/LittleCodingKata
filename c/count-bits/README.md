# #xxx Count Bits (C)

Given a positive number n, count total bits needed to represent it (using C).

## Notes

In binary, the largest unsigned integer `n` that can be represented in a given number of bits `b` is `n = 2^b`.
Therefore the number of bits `b` required to represent a given number `n` is `b=int(log2(n)) + 1`.

### Example Implementation

C has a [`log2()` function](https://www.w3schools.com/c/ref_math_log2.php) in the standard library, so implementation is trivial e.g.

```c
unsigned countBits(unsigned int number) {
  return (int)log2(number)+1;
}
```

### Example Run

Use the [Makefile](./Makefile) to build the example, the run:

```sh
$ make
gcc -Wall -O0    example.c   -o example
$ ./example
Usage: ./example <number>
$ ./example 5
3
$ ./example 128
8
```

### Final Code

See [example.c](./example.c):

```c
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
```

## Credits and References

* [Count total bits in a number](https://www.geeksforgeeks.org/dsa/count-total-bits-number/)
* [C Math log2() Function](https://www.w3schools.com/c/ref_math_log2.php)
