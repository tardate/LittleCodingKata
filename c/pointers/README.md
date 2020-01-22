# Pointers in C

All about pointers in C.

## Notes

Pointers are arguably what makes C so versatile, and also the reason why C has proven to be such an unsafe language in practice.

Pointers are defined in the C language spec [ISO/IEC 9899:TC3](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf).
Some interesting bits:

* 6.2.5 Types
* 6.7.5.1 Pointer declarators

## Demo

[demo.c](./demo.c?raw=true) exercises various pointer operations.
The make file will compile and run:

```
$ make
gcc -Wall -O0    demo.c   -o demo
./demo

===== test_simple_pointers
Set void pointer to the address of an int: `int *p = &i`
Dereferencing int pointer: `*p`. Returns 42

===== test_void_pointers
Set void pointer to the address of an int: `void *p = &i`. Address: 0x7ffee92dd5ac
Casting a void pointer to assumed type and dereferencing: `*(int*)p`. Returns 42
Set int pointer equal to void pointer: `int *int_p = p`
Dereferencing int pointer: `*int_p`. Returns 42
But would not stop you setting float pointer equal to void pointer that points to int: `float *float_p = p`
Dereferencing the float pointer doesn't blow up (since float and int both 4 bytes), but value is wrong: 0.000000

===== test_arrays_and_pointers
Initializing a static array of int: `int i[2] = {42, 43}`
Set int pointer equal to the array variable (implicitly a pointer): `int *p = i`. Address: 0x7ffee92dd5a0
Dereferencing int pointer by index: `p[0]`, `p[1]`. Returns 42, 43
Dereferencing int pointer: `*p`, `*(p + 1)`. Returns 42, 43
Dereferencing array variable as a pointer: `*i`, `*(i + 1)`. Returns 42, 43

===== test_pointer_arrays
Initializing an array of int with 3 elements: {10, 20, 30}`
Setting pointers to the addresses of array elements (but reversed order): `p[i] = &values[size - 1 - i]`
Dereferencing elements from array of int pointers: `*p[i]`. Returns {30, 20, 10}`
Double dereferencing elements from array of int pointers: `**p`, `**(p + 1)`, `**(p + 2)`. Returns {30, 20, 10}`

===== test_list_of_strings
Initializing an array of char pointer strings: `char *names[] = {"A Name",...}`
Dereferencing char pointer: `*names[0]`, Returns A
```

## Credits and References

* [ISO/IEC 9899:TC3](http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1256.pdf)
* [C - Pointers](https://www.tutorialspoint.com/cprogramming/c_pointers.htm) - tutorialspoint
* [C Pointers](https://www.programiz.com/c-programming/c-pointers) - programiz
* [Void pointers](https://www.learncpp.com/cpp-tutorial/613-void-pointers/)
