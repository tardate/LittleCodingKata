#include <assert.h>
#include <stdint.h>
#include <stdio.h>

void print_binary_digits(uint8_t number, uint8_t digits) {
  printf("0b");
  for(int p = digits - 1; p >= 0; --p) {
    printf("%d", 1 & (number >> p));
  }
  printf("\n");
}

void print_binary(uint8_t number) {
  print_binary_digits(number, sizeof(number) * 8);
}


void test_bit_set() {
  printf("\n===== test_bit_set\n");

  uint8_t value = 0xf0;
  uint8_t bp = 2;
  uint8_t result = value | (1 << bp);

  printf("Initial value           : ");
  print_binary(value);
  printf("Result of setting bit %d : ", bp + 1);
  print_binary(result);
  assert(result == 0b11110100);
}

void test_bit_clear() {
  printf("\n===== test_bit_clear\n");

  uint8_t value = 0xaf;
  uint8_t bp = 2;
  uint8_t result = value & ~(1 << bp);

  printf("Initial value            : ");
  print_binary(value);
  printf("Result of clearing bit %d : ", bp);
  print_binary(result);
  assert(result == 0b10101011);
}

void test_bit_toggle() {
  printf("\n===== test_bit_toggle\n");

  uint8_t value = 0xaf;
  uint8_t bp = 2;
  uint8_t result = value ^ (1 << bp);

  printf("Initial value              : ");
  print_binary(value);
  printf("Result of toggling bit %d   : ", bp);
  print_binary(result);
  assert(result == 0b10101011);

  printf("After again toggling bit %d : ", bp);
  result ^= 1 << bp;
  print_binary(result);
  assert(result == 0b10101111);
}

void test_bit_check() {
  printf("\n===== test_bit_check\n");

  uint8_t value = 0xf0;
  uint8_t bp = 2;
  uint8_t bp2 = 6;
  uint8_t result = (value & (1 << bp)) > 0;
  uint8_t result2 = (value & (1 << bp2)) > 0;

  printf("Initial value     : ");
  print_binary(value);
  printf("Test if bit %d set : ", bp);
  print_binary(result);
  assert(result == 0);
  printf("Test if bit %d set : ", bp2);
  print_binary(result2);
  assert(result2 == 1);
}

void test_bit_set_multiple() {
  printf("\n===== test_bit_set_multiple\n");

  uint8_t value = 0b11110000;
  uint8_t bp = 2;
  uint8_t new_bits = 0b1010;
  uint8_t result = (value & ~(0b1111 << bp)) | (new_bits << bp);

  printf("Initial value               : ");
  print_binary(value);
  printf("Bits to set at position %d:%d : ", bp + 3, bp );
  print_binary_digits(new_bits, 4);
  printf("Result                      : ");
  print_binary(result);
  assert(result == 0b11101000);
}


int main(void) {
  test_bit_set();
  test_bit_clear();
  test_bit_toggle();
  test_bit_check();
  test_bit_set_multiple();
  printf("\nNB: bit positions mentioned are 0-based from LSB\n");
}
