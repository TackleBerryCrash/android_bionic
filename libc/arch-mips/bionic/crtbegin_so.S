/*
 * Copyright (C) 2008 The Android Open Source Project
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */
	.section .init_array, "aw"
	.type __INIT_ARRAY__, @object
	.globl __INIT_ARRAY__
__INIT_ARRAY__:
	.long -1

	.section .fini_array, "aw"
	.type __FINI_ARRAY__, @object
	.globl __FINI_ARRAY__
__FINI_ARRAY__:
	.long -1
	.long __do_global_dtors_aux

	.abicalls
	.text
	.align	2
	.set	nomips16
	.ent	__do_global_dtors_aux
	.type	__do_global_dtors_aux, @function
__do_global_dtors_aux:
	.frame	$sp,32,$31		# vars= 0, regs= 1/0, args= 16, gp= 8
	.mask	0x80000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.cpload	$25
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	.cprestore	16
	lw	$2,%got(completed.1269)($28)
	lbu	$2,%lo(completed.1269)($2)
	bne	$2,$0,$L8
	nop

$L4:
	lw	$2,%got(__cxa_finalize)($28)
	beq	$2,$0,$L6
	nop

	lw	$2,%got(__dso_handle)($28)
	lw	$4,0($2)
	lw	$25,%call16(__cxa_finalize)($28)
	.reloc	1f,R_MIPS_JALR,__cxa_finalize
1:	jalr	$25
	nop

	lw	$28,16($sp)
$L6:
	lw	$2,%got(completed.1269)($28)
	li	$3,1			# 0x1
	sb	$3,%lo(completed.1269)($2)
$L8:
	lw	$31,28($sp)
	addiu	$sp,$sp,32
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	__do_global_dtors_aux
	.size	__do_global_dtors_aux, .-__do_global_dtors_aux
	.local	completed.1269
	.comm	completed.1269,1,1
	.weak	__cxa_finalize

#include "__dso_handle_so.S"
#include "atexit.S"
