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
	subq	$32, %rsp
	movl	$100, %eax
	movl	%eax, %edi
	movl	$8, %eax
	movl	%eax, %esi
	movl	$0, -4(%rbp)
	callq	_calloc
	movq	%rax, -16(%rbp)
	movq	$0, -24(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpq	$100, -24(%rbp)
	jae	LBB0_4
## %bb.2:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movsd	(%rax,%rcx,8), %xmm0    ## xmm0 = mem[0],zero
	movq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movsd	%xmm0, (%rax,%rcx,8)
## %bb.3:                               ##   in Loop: Header=BB0_1 Depth=1
	movq	-24(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -24(%rbp)
	jmp	LBB0_1
LBB0_4:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	callq	_free
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols
