# #176 Numeric Limits in C

Numeric limits information available in the C standard library (and finding another clang/gcc difference).

## Notes

Since C runs on many computer architectures, numeric limits can vary.
The standard library provides support for checking
[numeric limits](https://en.cppreference.com/w/c/types/limits) at runtime.

### Running the Example

See [example.c](./example.c) for details. A makefile compiles and runs:

```
$ make
gcc-10 -Wall -O0 -std=c11    example.c   -o example
./example
## Limits of library types:
PTRDIFF_MIN    = -9223372036854775808
PTRDIFF_MAX    = +9223372036854775807
SIZE_MAX       = 18446744073709551615
SIG_ATOMIC_MIN = -2147483648
SIG_ATOMIC_MAX = +2147483647
WCHAR_MIN      = -2147483648
WCHAR_MAX      = +2147483647
WINT_MIN       = -2147483648
WINT_MAX       = 2147483647

## Limits of integer types:
CHAR_BIT   = 8
MB_LEN_MAX = 6

CHAR_MIN   = -128
CHAR_MAX   = +127
SCHAR_MIN  = -128
SCHAR_MAX  = +127
UCHAR_MAX  = 255

SHRT_MIN   = -32768
SHRT_MAX   = +32767
USHRT_MAX  = 65535

INT_MIN    = -2147483648
INT_MAX    = +2147483647
UINT_MAX   = 4294967295

LONG_MIN   = -9223372036854775808
LONG_MAX   = +9223372036854775807
ULONG_MAX  = 18446744073709551615

LLONG_MIN  = -9223372036854775808
LLONG_MAX  = +9223372036854775807
ULLONG_MAX = 18446744073709551615

## Limits of floating point types:
FLT_RADIX    = 2
DECIMAL_DIG  = 21
FLT_MIN      = 1.175494e-38
FLT_MAX      = 3.402823e+38
FLT_EPSILON  = 1.192093e-07
FLT_DIG      = 6
FLT_MANT_DIG = 24
FLT_MIN_EXP  = -125
FLT_MIN_10_EXP  = -37
FLT_MAX_EXP     = 128
FLT_MAX_10_EXP  = 38
FLT_ROUNDS      = 1
FLT_EVAL_METHOD = 0
FLT_HAS_SUBNORM = 1
```

### Limitations

I just discovered that the clang 10.0.0 headers don't include the fix for
[*_HAS_SUBNORM](https://github.com/llvm/llvm-project/commit/3c1a7bc290fb59c93decd1edd37b276e86909921)
floating point limits.

So to run the example above on my Mac, I'm using gcc-10 installed with brew:

```
$ gcc-10 -v
Using built-in specs.
COLLECT_GCC=gcc-10
COLLECT_LTO_WRAPPER=/usr/local/Cellar/gcc/10.2.0/libexec/gcc/x86_64-apple-darwin17/10.2.0/lto-wrapper
Target: x86_64-apple-darwin17
Configured with: ../configure --build=x86_64-apple-darwin17 --prefix=/usr/local/Cellar/gcc/10.2.0 --libdir=/usr/local/Cellar/gcc/10.2.0/lib/gcc/10 --disable-nls --enable-checking=release --enable-languages=c,c++,objc,obj-c++,fortran --program-suffix=-10 --with-gmp=/usr/local/opt/gmp --with-mpfr=/usr/local/opt/mpfr --with-mpc=/usr/local/opt/libmpc --with-isl=/usr/local/opt/isl --with-system-zlib --with-pkgversion='Homebrew GCC 10.2.0' --with-bugurl=https://github.com/Homebrew/homebrew-core/issues --disable-multilib SED=/usr/bin/sed
Thread model: posix
Supported LTO compression algorithms: zlib
gcc version 10.2.0 (Homebrew GCC 10.2.0)
```

Rather than the default gcc installed with Xcode:

```
$ gcc -v
Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Apple LLVM version 10.0.0 (clang-1000.11.45.5)
Target: x86_64-apple-darwin17.7.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
```

## Credits and References

* [Numeric limits](https://en.cppreference.com/w/c/types/limits)
