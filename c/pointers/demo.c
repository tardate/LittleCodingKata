#include <assert.h>
#include <stdio.h>

void test_void_pointers() {
  printf("\n===== test_void_pointers\n");

  int i = 42;
  void *p = &i;
  printf("Set void pointer to the address of an int: `void *p = &i`. Address: %p\n", p);
  assert(*(int*)p == 42);
  printf("Casting a void pointer to assumed type and dereferencing: `*(int*)p`. Returns %d\n", *(int*)p);

  int *int_p = p;
  printf("Set int pointer equal to void pointer: `int *int_p = p`\n");
  assert(*int_p == 42);
  printf("Dereferencing int pointer: `*int_p`. Returns %d\n", *int_p);

  float *float_p = p;
  printf("But would not stop you setting float pointer equal to void pointer that points to int: `float *float_p = p`\n");
  printf("Dereferencing the float pointer doesn't blow up (since float and int both 4 bytes), but value is wrong: %f\n", *float_p);
}

void test_simple_pointers() {
  printf("\n===== test_simple_pointers\n");
  int i = 42;
  int *p = &i;

  assert(p);
  printf("Set void pointer to the address of an int: `int *p = &i`\n");

  assert(*p == 42);
  printf("Dereferencing int pointer: `*p`. Returns %d\n", *p);
}

void test_arrays_and_pointers() {
  printf("\n===== test_arrays_and_pointers\n");
  int i[2] = {42, 43};

  assert(i[0] == 42);
  assert(i[1] == 43);
  printf("Initializing a static array of int: `int i[2] = {%d, %d}`\n", i[0], i[1]);

  int *p = i;
  assert(p == i);
  printf("Set int pointer equal to the array variable (implicitly a pointer): `int *p = i`. Address: %p\n", p);

  assert(p[0] == 42);
  assert(p[1] == 43);
  printf("Dereferencing int pointer by index: `p[0]`, `p[1]`. Returns %d, %d\n", p[0], p[1]);

  assert(*p == 42);
  assert(*(p + 1) == 43);
  printf("Dereferencing int pointer: `*p`, `*(p + 1)`. Returns %d, %d\n", *p, *(p + 1));

  assert(*i == 42);
  assert(*(i + 1) == 43);
  printf("Dereferencing array variable as a pointer: `*i`, `*(i + 1)`. Returns %d, %d\n", *i, *(i + 1));
}

void test_pointer_arrays() {
  printf("\n===== test_pointer_arrays\n");
  int values[] = {10, 20, 30};
  int size = sizeof(values) / sizeof(values[0]);
  assert(size == 3);
  printf("Initializing an array of int with %d elements: {%d, %d, %d}`\n", size, values[0], values[1], values[2]);

  int *p[size];
  for (int i = 0; i < size; ++i) {
    p[i] = &values[size - 1 - i];
  }
  printf("Setting pointers to the addresses of array elements (but reversed order): `p[i] = &values[size - 1 - i]`\n");

  assert(*p[0] == 30);
  assert(*p[1] == 20);
  assert(*p[2] == 10);
  printf("Dereferencing elements from array of int pointers: `*p[i]`. Returns {%d, %d, %d}`\n", *p[0], *p[1], *p[2]);
  assert(**p == 30);
  assert(**(p + 1) == 20);
  assert(**(p + 2) == 10);
  printf("Double dereferencing elements from array of int pointers: `**p`, `**(p + 1)`, `**(p + 2)`. Returns {%d, %d, %d}`\n", **p, **(p + 1), **(p + 2));
}

void test_list_of_strings() {
  printf("\n===== test_list_of_strings\n");
  char *names[] = {
    "A Name",
    "B Name",
    "C Name",
    "D Name"
  };
  assert(names[0] == "A Name");
  assert(names[1] == "B Name");
  assert(names[2] == "C Name");
  assert(names[3] == "D Name");
  printf("Initializing an array of char pointer strings: `char *names[] = {\"A Name\",...}`\n");

  assert(*names[0] == 'A');
  printf("Dereferencing char pointer: `*names[0]`, Returns %c\n", *names[0]);
}

int main(void) {
  test_simple_pointers();
  test_void_pointers();
  test_arrays_and_pointers();
  test_pointer_arrays();
  test_list_of_strings();
}
