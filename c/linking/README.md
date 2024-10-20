# #275 C

All about compiling, linking, and debugging C with GCC on macOx (Intel and Apple Silicon).

## Notes

### gcc

[gcc](https://gcc.gnu.org/) the GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, Go, and D, as well as libraries for these languages.

### Original Examples Run on Intel Mac

#### gcc

Since I'm on macOS, gcc is actually linking to llvm's clang:

    $ gcc --version
    Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
    Apple LLVM version 10.0.0 (clang-1000.11.45.5)
    Target: x86_64-apple-darwin17.7.0
    Thread model: posix
    InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin

Compiling and link a single file:

    $ gcc example.c -o example -lc -g -Wall -O0 -std=gnu11
    $ ./example
    Hello, world.

[Compiler options](https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/Option-Summary.html#Option-Summary):

* `-lc` instructs the linker to link the standard libc library. This is redundant and is assumed if not specified.
* `-g` adds symbols for debugging
* `-std=gnu11` is gcc-specific, and specifies that gcc should allow code conforming to the C11 and POSIX standards
* `-O0` indicates optimization level zero, effectively turning off all funny business.
* `-Wall` enables all compiler warnings

#### objdump

[objdump](http://web.mit.edu/gnu/doc/html/binutils_5.html) displays object files on Unix-like operating systems.

Since I'm on macOS, objdump is actually linking to llvm's objdump:

    $ objdump --version
    Apple LLVM version 10.0.0 (clang-1000.11.45.5)
      Optimized build.
      Default target: x86_64-apple-darwin17.7.0
      Host CPU: haswell

      Registered Targets:
        aarch64    - AArch64 (little endian)
        aarch64_be - AArch64 (big endian)
        arm        - ARM
        arm64      - ARM64 (little endian)
        armeb      - ARM (big endian)
        thumb      - Thumb
        thumbeb    - Thumb (big endian)
        x86        - 32-bit X86: Pentium-Pro and above
        x86-64     - 64-bit X86: EM64T and AMD64


Using GCC to compile to object file:

    $ gcc -c example.c

Disassemble all text sections:

    $ objdump -d example.o

    example.o:  file format Mach-O 64-bit x86-64

    Disassembly of section __TEXT,__text:
    _status:
           0:   55    pushq %rbp
           1:   48 89 e5    movq  %rsp, %rbp
           4:   31 c0       xorl  %eax, %eax
           6:   5d    popq  %rbp
           7:   c3    retq
           8:   0f 1f 84 00 00 00 00 00       nopl  (%rax,%rax)

    _main:
          10:   55    pushq %rbp
          11:   48 89 e5    movq  %rsp, %rbp
          14:   48 83 ec 10       subq  $16, %rsp
          18:   48 8d 3d 1c 00 00 00    leaq  28(%rip), %rdi
          1f:   c7 45 fc 00 00 00 00    movl  $0, -4(%rbp)
          26:   b0 00       movb  $0, %al
          28:   e8 00 00 00 00    callq 0 <_main+0x1d>
          2d:   89 45 f8    movl  %eax, -8(%rbp)
          30:   e8 00 00 00 00    callq 0 <_main+0x25>
          35:   48 83 c4 10       addq  $16, %rsp
          39:   5d    popq  %rbp
          3a:   c3    retq

#### Linking from Object Files

    $ gcc -c example.c
    $ gcc example.o -lc -o example
    $ ./example
    Hello, world.

### macOS with Apple Silicon Update

#### gcc

Since I'm on macOS, gcc is actually linking to llvm's clang:

    $ gcc --version
    Apple clang version 15.0.0 (clang-1500.1.0.2.5)
    Target: arm64-apple-darwin23.2.0
    Thread model: posix
    InstalledDir: /Library/Developer/CommandLineTools/usr/bin

Compiling and link a single file:

    $ gcc example.c -o example -lc -g -Wall -O0 -std=gnu11
    $ ./example
    Hello, world.

#### objdump

[objdump](http://web.mit.edu/gnu/doc/html/binutils_5.html) displays object files on Unix-like operating systems.

Since I'm on macOS, objdump is actually linking to llvm's objdump:

    $ objdump --version
    Apple LLVM version 15.0.0
      Optimized build.
      Default target: arm64-apple-darwin23.2.0
      Host CPU: apple-m1

      Registered Targets:
        aarch64    - AArch64 (little endian)
        aarch64_32 - AArch64 (little endian ILP32)
        aarch64_be - AArch64 (big endian)
        arm        - ARM
        arm64      - ARM64 (little endian)
        arm64_32   - ARM64 (little endian ILP32)
        armeb      - ARM (big endian)
        thumb      - Thumb
        thumbeb    - Thumb (big endian)
        x86        - 32-bit X86: Pentium-Pro and above
        x86-64     - 64-bit X86: EM64T and AMD64

Using GCC to compile to object file:

    $ gcc -c example.c

Disassemble all text sections:

    $ objdump -d example.o

    example.o:  file format mach-o arm64

    Disassembly of section __TEXT,__text:

    0000000000000000 <ltmp0>:
           0: 52800000      mov w0, #0
           4: d65f03c0      ret

    0000000000000008 <_main>:
           8: d10083ff      sub sp, sp, #32
           c: a9017bfd      stp x29, x30, [sp, #16]
          10: 910043fd      add x29, sp, #16
          14: b81fc3bf      stur  wzr, [x29, #-4]
          18: 90000000      adrp  x0, 0x0 <_main+0x10>
          1c: 91000000      add x0, x0, #0
          20: 94000000      bl  0x20 <_main+0x18>
          24: 94000000      bl  0x24 <_main+0x1c>
          28: a9417bfd      ldp x29, x30, [sp, #16]
          2c: 910083ff      add sp, sp, #32
          30: d65f03c0      ret

#### Linking from Object Files

    $ gcc -c example.c
    $ gcc -c example.c
    $ gcc example.o -lc -o example
    $ ./example
    Hello, world.

## Credits and References

* [gcc](https://gcc.gnu.org/)
* [objdump](https://en.wikipedia.org/wiki/Objdump) - wikipedia
* [GNU objdump man page](http://web.mit.edu/gnu/doc/html/binutils_5.html)
* [llvm-objdump](https://llvm.org/docs/CommandGuide/llvm-objdump.html)
* [Clang: a C language family frontend for LLVM](https://clang.llvm.org/)
