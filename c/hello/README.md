# #172 World in C

The clichéd starting point, in C.

## Notes

Using [printf](https://www.tutorialspoint.com/c_standard_library/c_function_printf.htm)
from the standard libary, in the most basic definition of a main program:

```
#include <stdio.h>

int main() {
  printf("Hello, world.\n");
}
```

### Running the Example

See [example.c](./example.c) for details. A makefile compiles and runs:

```
$ make
gcc -g -Wall -O3    hello.c   -o hello
$ ./hello
Hello, world.
```

## Credits and References

* [printf](https://www.tutorialspoint.com/c_standard_library/c_function_printf.htm)
* [C standard library](https://en.wikipedia.org/wiki/C_standard_library) - wikipedia
* [C Language: Standard Library Functions - stdlib.h](https://www.techonthenet.com/c_language/standard_library_functions/stdlib_h/) - techonthenet
