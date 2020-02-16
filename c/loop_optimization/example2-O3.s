	.section	__TEXT,__text,regular,pure_instructions
	.macosx_version_min 10, 13
	.globl	_main                   ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$100, %edi
	movl	$8, %esi
	callq	_calloc
	movq	$-800, %rcx             ## imm = 0xFCE0
	.p2align	4, 0x90
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movsd	800(%rax,%rcx), %xmm0   ## xmm0 = mem[0],zero
	movsd	%xmm0, 800(%rax,%rcx)
	movsd	808(%rax,%rcx), %xmm0   ## xmm0 = mem[0],zero
	movsd	%xmm0, 808(%rax,%rcx)
	movsd	816(%rax,%rcx), %xmm0   ## xmm0 = mem[0],zero
	movsd	%xmm0, 816(%rax,%rcx)
	movsd	824(%rax,%rcx), %xmm0   ## xmm0 = mem[0],zero
	movsd	%xmm0, 824(%rax,%rcx)
	movsd	832(%rax,%rcx), %xmm0   ## xmm0 = mem[0],zero
	movsd	%xmm0, 832(%rax,%rcx)
	addq	$40, %rcx
	jne	LBB0_1
## %bb.2:
	movq	%rax, %rdi
	callq	_free
	xorl	%eax, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
