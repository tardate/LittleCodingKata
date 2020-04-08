#include <assert.h>
#include <stdio.h>
#include <string.h>


const char * long_string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const char * short_string = "ABCD";

void test_explicit_printf_format() {
  printf("\n===== test_explicit_printf_format\n");
  printf("> printf(\"Prints just 5 characters (should print 'ABCDE'): %%.5s\\n\", long_string);\n");

  printf("Prints just 5 characters (should print 'ABCDE'): %.5s\n", long_string);
}

void test_printf_width_as_argument() {
  printf("\n===== test_printf_width_as_argument\n");
  printf("> printf(\"Prints just %%d characters (should print 'AB'): %%.*s\\n\", 2, 2, long_string);\n");

  printf("Prints just %d characters (should print 'AB'): %.*s\n", 2, 2, long_string);
}

void test_printf_still_honours_null_termination() {
  printf("\n===== test_explicit_printf_format\n");
  printf("> printf(\"Asking for 5 characters, but only 4 available (should print 'ABCD'): %%.5s\\n\", short_string);\n");
  printf("Asking for 5 characters, but only 4 available (should print 'ABCD'): %.5s\n", short_string);
}

void test_explicit_sprintf_format() {
  printf("\n===== test_explicit_sprintf_format\n");
  char result[10];
  char expected[] = "ABCDE";

  printf("> sprintf(result, \"%%.5s\", long_string);\n");
  sprintf(result, "%.5s", long_string);
  assert(strcmp(result, expected) == 0);
}

void test_sprintf_with_width_as_argument() {
  printf("\n===== test_sprintf_with_width_as_argument\n");
  char result[10];
  char expected[] = "AB";

  printf("> sprintf(result, \"%%.*s\", 2, long_string);\n");
  sprintf(result, "%.*s", 2, long_string);
  assert(strcmp(result, expected) == 0);
}


int main(void) {
  test_explicit_printf_format();
  test_printf_width_as_argument();
  test_printf_still_honours_null_termination();
  test_explicit_sprintf_format();
  test_sprintf_with_width_as_argument();
}
