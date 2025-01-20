# #125 Loop Optimization

Looking at how C compilers optimize loops.

## Notes

C compilers usually supprot a range of loop optimizations, including:

* Loop Unroll
* Loop Unswitching
* Loop Interchange
* Detection of memcpy, memset idioms
* Delete side-effect free loops
* Loop Distribution
* Loop Vectorization


### Examples

[example1.c](./example1.c) is [based on a question on stackoverflow](http://stackoverflow.com/questions/7680489/why-this-loop-is-not-optimised-out).
It creates an array, loops and does a pointless operation on each element, then discards the array:

```
int main(void) {
  double *a;
  a = calloc(SIZE, sizeof *a);
  for (size_t i = 0; i < SIZE; ++i) {
    a[i] = a[i];
  }
  free(a);
}
```

The question is: would this be so obviously pointless and without side-effect as to be optimized away?

With clang-1000.11.45.5, it turns out that yes, the compiler is smart enough to figure this is a "side-effect free loop",
as long as optimization is enabled.

* with no optimizations enabled (`gcc -std=c17 -O0 -S example1.c`), the generated code includes the loop.
* with level 1 optimizations enabled (`gcc -std=c17 -O1 -S example1.c`), the generated code excludes the loop.

Optimizing the loop away may not always be desirable, especially in embedded situations where a NOP loop might be there for timing reasons.
[example2.c](./example2.c) demonstrates one way of forcing the loop to remain - declaring the affected variable as `volatile`.
The loop remains in the compiled code even with optimization turned up to level 3.

### Running the Examples

Easy to do by hand, but here's a [Makefle](.//Makefile) to do it instead:

```
$ make
gcc -Wall -std=c17 -S -O0 -o example1-O0.s example1.c
gcc -Wall -std=c17 -S -O1 -o example1-O1.s example1.c
gcc -Wall -std=c17 -S -O1 -o example2-O1.s example2.c
tail -n+1 example1-O0.s example1-O1.s example2-O1.s
==> example1-O0.s <==
  .section  __TEXT,__text,regular,pure_instructions
  .macosx_version_min 10, 13
  .globl  _main                   ## -- Begin function main
  .p2align  4, 0x90
_main:                                  ## @main
  .cfi_startproc
## %bb.0:
  pushq %rbp
  .cfi_def_cfa_offset 16
  .cfi_offset %rbp, -16
  movq  %rsp, %rbp
  .cfi_def_cfa_register %rbp
  subq  $32, %rsp
  movl  $100, %eax
  movl  %eax, %edi
  movl  $8, %eax
  movl  %eax, %esi
  movl  $0, -4(%rbp)
  callq _calloc
  movq  %rax, -16(%rbp)
  movq  $0, -24(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
  cmpq  $100, -24(%rbp)
  jae LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
  movq  -16(%rbp), %rax
  movq  -24(%rbp), %rcx
  movsd (%rax,%rcx,8), %xmm0    ## xmm0 = mem[0],zero
  movq  -16(%rbp), %rax
  movq  -24(%rbp), %rcx
  movsd %xmm0, (%rax,%rcx,8)
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
  movq  -24(%rbp), %rax
  addq  $1, %rax
  movq  %rax, -24(%rbp)
  jmp LBB0_1
LBB0_4:
  movq  -16(%rbp), %rax
  movq  %rax, %rdi
  callq _free
  movl  -4(%rbp), %eax
  addq  $32, %rsp
  popq  %rbp
  retq
  .cfi_endproc
                                        ## -- End function

.subsections_via_symbols

==> example1-O1.s <==
  .section  __TEXT,__text,regular,pure_instructions
  .macosx_version_min 10, 13
  .globl  _main                   ## -- Begin function main
  .p2align  4, 0x90
_main:                                  ## @main
  .cfi_startproc
## %bb.0:
  pushq %rbp
  .cfi_def_cfa_offset 16
  .cfi_offset %rbp, -16
  movq  %rsp, %rbp
  .cfi_def_cfa_register %rbp
  xorl  %eax, %eax
  popq  %rbp
  retq
  .cfi_endproc
                                        ## -- End function

.subsections_via_symbols

==> example2-O1.s <==
  .section  __TEXT,__text,regular,pure_instructions
  .macosx_version_min 10, 13
  .globl  _main                   ## -- Begin function main
  .p2align  4, 0x90
_main:                                  ## @main
  .cfi_startproc
## %bb.0:
  pushq %rbp
  .cfi_def_cfa_offset 16
  .cfi_offset %rbp, -16
  movq  %rsp, %rbp
  .cfi_def_cfa_register %rbp
  movl  $100, %edi
  movl  $8, %esi
  callq _calloc
  movq  $-800, %rcx             ## imm = 0xFCE0
  .p2align  4, 0x90
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
  movsd 800(%rax,%rcx), %xmm0   ## xmm0 = mem[0],zero
  movsd %xmm0, 800(%rax,%rcx)
  addq  $8, %rcx
  jne LBB0_1
## %bb.2:
  movq  %rax, %rdi
  callq _free
  xorl  %eax, %eax
  popq  %rbp
  retq
  .cfi_endproc
                                        ## -- End function

.subsections_via_symbols
```

## Credits and References

* [Why this loop is not optimised out?](http://stackoverflow.com/questions/7680489/why-this-loop-is-not-optimised-out) - stackoverflow
* [Loop Optimizations in LLVM: The Good, The Bad, and The Ugly](https://llvm.org/devmtg/2018-10/slides/Kruse-LoopTransforms.pdf)
* [GCC 3.10 Options That Control Optimization](https://gcc.gnu.org/onlinedocs/gcc-4.5.2/gcc/Optimize-Options.html)
