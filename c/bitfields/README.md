# Bit Fields

Using bitfields in C

## Notes

Bit fields are data structures for accessing and manipulating the individual bits of a data value.
Bit fields are supported in C and C++, however some details are implementation dependent,
such as internal allocation details and how out of range values are handled.

A bit field declaration is a struct with one or more fields defined:

```
struct {
   type [member_name] : width ;
   type [member_name] : width ;
   etc
};
```

* type - integer type that determines how a field's value is interpreted
* member_name - optional name of the element
* width - number of bits in the field

A width of zero is only allowed for nameless bitfields and  specifies that the next bit field in the class definition will begin at an allocation unit's boundary.


### Declaring Bit Fields

As an anonymous struct variable:

```
struct {
    uint8_t a      : 1;
    uint8_t b      : 1;
} bitfield;
bitfield.a = 1;
```

As a name struct type:

```
struct MyBitfieldType {
    uint8_t a      : 1;
    uint8_t b      : 1;
};

struct MyBitfieldType bitfield;
bitfield.a = 1;
```

Using pointers to a bitfield:

```
struct MyBitfieldType * bitfield_pointer;
bitfield_pointer = &bitfield;
assert(bitfield.a == bitfield_pointer->a);
```

### Using a Union

A union can facilitate the simultaneus bitwise and memory-level access.
HOWEVER, the internal layout of a bitfield is implementation (compiler and platform) dependent,
so this approach while convenient would need verification for each target environment.

```
  union {
    struct {
      uint8_t a      : 1;
      uint8_t b      : 1;
    } bits;

    uint16_t memory;
  } bitset;

bitset.bits.a = 0;
bitset.memory = 0xFFFF;
assert(bitset.bits.a == 1);
```

### Running the Examples

See [examples.c](./examples.c) for details. A makefile compiles and runs:

```
$ make
gcc -Wall -O0    example.c   -o example
./example

===== test_anonymous_narrow
Memory size occupied by bitfield : 8 bits
Memory contents (initial): 0b00000000
Memory contents (set)    : 0b00000011
Memory contents (cleared): 0b00000000

===== test_anonymous_aligned_wide
Memory size occupied by bitfield : 16 bits
Memory contents (initial): 0b0000000000000000
Memory contents (set)    : 0b0000001100001101
Memory contents (cleared): 0b0000000000000000

===== test_named_bitfield
Memory size occupied by bitfield : 8 bits
Memory contents (initial): 0b00000000
Memory contents (set)    : 0b00000011
Memory contents (cleared): 0b00000000

===== test_union
bitset.memory_value (initial)    : 0b0000000000000000
bitset.memory_value (set)        : 0b0000000000000011
bitset.bits.a                    : 0b1
bitset.bits.b                    : 0b1
bitset.memory_value (clear b)    : 0b0000000000000001
bitset.bits.a                    : 0b1
bitset.bits.b                    : 0b0
bitset.memory_value (direct set) : 0b1010101010101111
bitset.bits.a                    : 0b1
bitset.bits.b                    : 0b1

===== test_with_pointers
bitset.a                    : 0b0
bitset.b                    : 0b1
bitset_pointer->a           : 0b0
bitset_pointer->b           : 0b1
```

## Credits and References

* [Bit field](https://en.wikipedia.org/wiki/Bit_field)
* [C - Bit Fields](https://www.tutorialspoint.com/cprogramming/c_bit_fields.htm)
* [Bit field - C++](https://en.cppreference.com/w/cpp/language/bit_field)
* [Set, toggle and clear a bit in C](https://www.codesdope.com/blog/article/set-toggle-and-clear-a-bit-in-c/)
* [C structs and Pointers](https://www.programiz.com/c-programming/c-structures-pointers)
