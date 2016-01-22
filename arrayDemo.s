	.file	"arrayDemo.c"
	.section	.rodata
	.align 8
.LC0:
	.string	"\nRepresentations of the Array:"
.LC1:
	.string	"Hex:\t"
.LC2:
	.string	"Binary:\t%s\n"
	.align 8
.LC3:
	.string	"\nAccessing Elements of the Array"
	.align 8
.LC4:
	.string	"Fourth element, index 3:\t0x%.2X\n"
	.align 8
.LC5:
	.string	"Testing bits 7, 5, 1, or 0:\t0x%.2X\n"
.LC6:
	.string	"Testing bit 5:\t\t\t0x%.2X\n"
	.text
	.globl	arrayDemo
	.type	arrayDemo, @function
arrayDemo:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movb	$1, -80(%rbp)
	movb	$2, -79(%rbp)
	movb	$51, -78(%rbp)
	movb	$-33, -77(%rbp)
	movb	$-20, -76(%rbp)
	movl	$.LC0, %edi
	call	puts
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	leaq	-80(%rbp), %rax
	movl	$5, %esi
	movq	%rax, %rdi
	call	printArray
	leaq	-64(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movl	$5, %esi
	movq	%rax, %rdi
	call	arrayToBin
	movq	%rax, %rsi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movl	$.LC3, %edi
	call	puts
	movzbl	-77(%rbp), %eax
	movb	%al, -83(%rbp)
	movsbl	-83(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC4, %edi
	movl	$0, %eax
	call	printf
	movzbl	-77(%rbp), %eax
	andl	$-93, %eax
	movb	%al, -82(%rbp)
	movzbl	-77(%rbp), %eax
	andl	$32, %eax
	movb	%al, -81(%rbp)
	movsbl	-82(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	movsbl	-81(%rbp), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC6, %edi
	movl	$0, %eax
	call	printf
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L2
	call	__stack_chk_fail
.L2:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	arrayDemo, .-arrayDemo
	.section	.rodata
.LC7:
	.string	"0x%.2X "
	.text
	.globl	printArray
	.type	printArray, @function
printArray:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L4
.L5:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC7, %edi
	movl	$0, %eax
	call	printf
	addl	$1, -4(%rbp)
.L4:
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L5
	movl	$10, %edi
	call	putchar
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	printArray, .-printArray
	.globl	arrayToBin
	.type	arrayToBin, @function
arrayToBin:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	%esi, -28(%rbp)
	movq	%rdx, -40(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L7
.L12:
	movl	$1, -4(%rbp)
	movl	$0, -8(%rbp)
	jmp	.L8
.L11:
	movl	-12(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	andl	-4(%rbp), %eax
	testl	%eax, %eax
	je	.L9
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movb	$49, (%rax)
	jmp	.L10
.L9:
	movl	-12(%rbp), %eax
	leal	0(,%rax,8), %edx
	movl	-8(%rbp), %eax
	addl	%edx, %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movb	$48, (%rax)
.L10:
	sall	-4(%rbp)
	addl	$1, -8(%rbp)
.L8:
	cmpl	$7, -8(%rbp)
	jle	.L11
	addl	$1, -12(%rbp)
.L7:
	movl	-12(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.L12
	movl	-28(%rbp), %eax
	sall	$3, %eax
	movslq	%eax, %rdx
	movq	-40(%rbp), %rax
	addq	%rdx, %rax
	movb	$0, (%rax)
	movq	-40(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	arrayToBin, .-arrayToBin
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu2) 5.2.1 20151010"
	.section	.note.GNU-stack,"",@progbits
