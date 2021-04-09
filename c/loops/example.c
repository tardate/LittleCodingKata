#include <assert.h>
#include <stdint.h>
#include <stdio.h>

void test_while() {
  printf("\n===== test_while\n");

  int result = 1;
  while (result < 10) {
    ++result;
  }
  assert(result == 10);
}

void test_break_while() {
  printf("\n===== test_break_while\n");

  int result = 1;
  while (result < 10) {
    ++result;
    if (result == 5) break;
  }
  assert(result == 5);
}

void test_continue_while() {
  printf("\n===== test_continue_while\n");

  int result = 1;
  int alt_result = 1;
  while (result < 10) {
    ++result;
    if (result < 10) continue;
    ++alt_result;
  }
  assert(result == 10);
  assert(alt_result == 2);
}

void test_do_while() {
  printf("\n===== test_do_while\n");

  int result = 1;
  do {
    ++result;
  } while (result < 10);
  assert(result == 10);
}

void test_break_do_while() {
  printf("\n===== test_break_do_while\n");

  int result = 1;
  do {
    ++result;
    if (result == 5) break;
  } while (result < 10);
  assert(result == 5);
}

void test_continue_do_while() {
  printf("\n===== test_continue_do_while\n");

  int result = 1;
  int alt_result = 1;
  do {
    ++result;
    if (result < 10) continue;
    ++alt_result;
  } while (result < 10);
  assert(result == 10);
  assert(alt_result == 2);
}

void test_for() {
  printf("\n===== test_for\n");

  int result = 1;
  for (int i = 1; i < 10; ++i) {
    ++result;
  }
  assert(result == 10);
}

void test_break_for() {
  printf("\n===== test_break_for\n");

  int result = 1;
  for (int i = 1; i < 10; ++i) {
    ++result;
    if (result == 5) break;
  }
  assert(result == 5);
}

void test_continue_for() {
  printf("\n===== test_continue_for\n");

  int result = 1;
  int alt_result = 1;
  for (int i = 1; i < 10; ++i) {
    ++result;
    if (result < 10) continue;
    ++alt_result;
  }
  assert(result == 10);
  assert(alt_result == 2);
}

int main(void) {
  test_while();
  test_break_while();
  test_continue_while();
  test_do_while();
  test_break_do_while();
  test_continue_do_while();
  test_for();
  test_break_for();
  test_continue_for();
}
