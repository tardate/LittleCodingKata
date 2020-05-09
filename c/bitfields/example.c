#include <assert.h>
#include <stdint.h>
#include <stdio.h>

void print_binary(uint32_t number, uint8_t digits) {
  printf("0b");
  for(int p = digits - 1; p >= 0; --p) {
    printf("%d", 1 & (number >> p));
  }
  printf("\n");
}

void test_anonymous_narrow() {
  printf("\n===== test_anonymous_narrow\n");

  struct {
      uint8_t a      : 1;
      uint8_t b      : 1;
  } bitfield;

  printf( "Memory size occupied by bitfield : %lu bits\n", sizeof(bitfield) * 8);

  printf( "Memory contents (initial): ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);

  bitfield.a = 1;
  bitfield.b = 1;
  assert(bitfield.a == 1);
  assert(bitfield.b == 1);
  printf( "Memory contents (set)    : ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);

  bitfield.a = 0;
  bitfield.b = 0;
  assert(bitfield.a == 0);
  assert(bitfield.b == 0);
  printf( "Memory contents (cleared): ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);
}

void test_anonymous_aligned_wide() {
  printf("\n===== test_anonymous_aligned_wide\n");

  struct {
      uint8_t a      : 1;
      uint8_t        : 1; // skip
      uint8_t b      : 1;
      uint8_t c      : 1;
      uint8_t        : 0; // align next bit on allocation boundary
      uint8_t opcode : 2;
  } bitfield;

  printf( "Memory size occupied by bitfield : %lu bits\n", sizeof(bitfield) * 8);

  printf( "Memory contents (initial): ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);

  bitfield.a = 1;
  bitfield.b = 1;
  bitfield.c = 1;
  bitfield.opcode = 0b11;
  assert(bitfield.a == 1);
  assert(bitfield.b == 1);
  assert(bitfield.c == 1);
  assert(bitfield.opcode == 3);
  printf( "Memory contents (set)    : ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);

  bitfield.a = 0;
  bitfield.b = 0;
  bitfield.c = 0;
  bitfield.opcode = 0;
  assert(bitfield.a == 0);
  assert(bitfield.b == 0);
  assert(bitfield.c == 0);
  assert(bitfield.opcode == 0);
  printf( "Memory contents (cleared): ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);
}

void test_named_bitfield() {
  printf("\n===== test_named_bitfield\n");

  struct MyBitfieldType {
      uint8_t a      : 1;
      uint8_t b      : 1;
  };

  struct MyBitfieldType bitfield;

  printf( "Memory size occupied by bitfield : %lu bits\n", sizeof(bitfield) * 8);

  printf( "Memory contents (initial): ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);

  bitfield.a = 1;
  bitfield.b = 1;
  assert(bitfield.a == 1);
  assert(bitfield.b == 1);
  printf( "Memory contents (set)    : ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);

  bitfield.a = 0;
  bitfield.b = 0;
  assert(bitfield.a == 0);
  assert(bitfield.b == 0);
  printf( "Memory contents (cleared): ");
  print_binary( *(uint32_t*)&bitfield, sizeof(bitfield) * 8);
}

void test_union() {
  printf("\n===== test_union\n");

  union {
    struct {
      uint8_t a      : 1;
      uint8_t b      : 1;
    } bits;

    uint16_t memory_value;
  } bitset;

  printf( "bitset.memory_value (initial)    : ");
  print_binary(bitset.memory_value, 16);

  bitset.bits.a = 1;
  bitset.bits.b = 1;
  printf( "bitset.memory_value (set)        : ");
  print_binary(bitset.memory_value, 16);
  printf( "bitset.bits.a                    : ");
  print_binary(bitset.bits.a, 1);
  printf( "bitset.bits.b                    : ");
  print_binary(bitset.bits.b, 1);

  bitset.bits.b = 0;
  printf( "bitset.memory_value (clear b)    : ");
  print_binary(bitset.memory_value, 16);
  printf( "bitset.bits.a                    : ");
  print_binary(bitset.bits.a, 1);
  printf( "bitset.bits.b                    : ");
  print_binary(bitset.bits.b, 1);

  bitset.memory_value = 0xaaaf;
  printf( "bitset.memory_value (direct set) : ");
  print_binary(bitset.memory_value, 16);
  printf( "bitset.bits.a                    : ");
  print_binary(bitset.bits.a, 1);
  printf( "bitset.bits.b                    : ");
  print_binary(bitset.bits.b, 1);
  assert(bitset.bits.a == 1);
  assert(bitset.bits.b == 1);

}

void test_with_pointers() {
  printf("\n===== test_with_pointers\n");

  struct MyBitfieldType {
      uint8_t a      : 1;
      uint8_t b      : 1;
  };

  struct MyBitfieldType bitset;
  struct MyBitfieldType * bitset_pointer;

  bitset.a = 0;
  bitset.b = 1;
  printf( "bitset.a                    : ");
  print_binary(bitset.a, 1);
  printf( "bitset.b                    : ");
  print_binary(bitset.b, 1);

  bitset_pointer = &bitset;
  printf( "bitset_pointer->a           : ");
  print_binary(bitset_pointer->a, 1);
  printf( "bitset_pointer->b           : ");
  print_binary(bitset_pointer->b, 1);

  assert(bitset.a == bitset_pointer->a);
  assert(bitset.b == bitset_pointer->b);
}


int main(void) {
  test_anonymous_narrow();
  test_anonymous_aligned_wide();
  test_named_bitfield();
  test_union();
  test_with_pointers();
}
