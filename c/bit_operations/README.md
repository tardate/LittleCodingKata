# Bitwise Operations

Summary and demonstration of all the usual bit operations in C.

## Notes

Manipulating individual bits of a variable or register is very common especially in embedded programming.
If you studied any digital/boolean logic, the theory may be familier, but we faced with actually writing a
line of bit manipulation code I often find myself mentally working it out again from first principles.

Here's a catalog of the conventional bit operation techniques in C.
Note: bitfields provide another approach for dealing with fixed size data, but I'll cover those seperately

### Building blocks

The key operators from which all these recipes can be made:

* bitwise OR: `|`
* bitwise AND: `&`
* bitwise XOR: `^`
* bitwise NOT: `~` to invert (ones' complement)
* shift: `<<` ,`>>` to shift bits left or right
* assignment: `=` but often compounded with a bitwise operation e.g. `|=`, `&=`, `^=`, `~=`

Note: bitwise operators are not to be confused with their logical analogs: `||`, `&&`, `!`.

### Setting a bit

Shift a bit to the desired position to be set and OR it with the current value. e.g. to set bit position p:

    value |= 1 << p;

### Clearing a bit

Create a bit mask with all bits set to 1 except those to be cleared. AND this with the current value to clear all the unmasked bits
e.g. to clear bit position p:

    value &= ~(1 << p);

### Toggle a bit

Shift a bit to the desired position to be toggled and XOR with the current value.

    value ^= 1 << p;

### Checking a bit

Shift a bit to the desired position to be checked and AND with the current value. The result will be non-zero of the bit is set.

    value & (1 << p)

To coerce to a boolean result, compare with 0 (for example:

    value & (1 << p) == 0

### Setting multiple bits

Setting multiple bits poses the challenge that some bits may need to be set, some cleared, all while keeping the other bits as-is.

There are a few ways to approach this. Here's one:
mask out the bits to be set in the current value, then OR with the new bits (shifted into the correct position)

For example, to set two bits[3:2] with some `some_bits` value:

    new_bits = 0b10;
    result = (value & ~(0b11 << 2)) | (new_bits << 2);

### Macros

Libraries often provide macros for bit operations, though these are non-standard and often not portable.
Here are some commmon ones:

The `_BV` "bit value" - shortcut for creating a 1-bit mask. e.g. [avr/sfr_defs.h](https://github.com/vancegroup-mirrors/avr-libc/blob/master/avr-libc/include/avr/sfr_defs.h#L208)

    #define _BV(bit) (1 << (bit))


### Running the Examples

See [example.c](./example.c) for details. A makefile compiles and runs:

```
$ make
gcc -Wall -O0    example.c   -o example
./example

===== test_bit_set
Initial value           : 0b11110000
Result of setting bit 3 : 0b11110100

===== test_bit_clear
Initial value            : 0b10101111
Result of clearing bit 2 : 0b10101011

===== test_bit_toggle
Initial value              : 0b10101111
Result of toggling bit 2   : 0b10101011
After again toggling bit 2 : 0b10101111

===== test_bit_check
Initial value     : 0b11110000
Test if bit 2 set : 0b00000000
Test if bit 6 set : 0b00000001

===== test_bit_set_multiple
Initial value               : 0b11110000
Bits to set at position 5:2 : 0b1010
Result                      : 0b11101000

NB: bit positions mentioned are 0-based from LSB
```

## Credits and References

* [Bitwise operations in C](https://en.wikipedia.org/wiki/Bitwise_operations_in_C)
* [Set, toggle and clear a bit in C](https://www.codesdope.com/blog/article/set-toggle-and-clear-a-bit-in-c/)
* [Introduction to C language bitwise operators](http://dubworks.blogspot.com/2012/07/introduction-to-c-language-bitwise_21.html)
