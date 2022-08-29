# helloworld.s
#
# Print out "Hello World"
#
# Copyright (c) 2013, James R. Larus.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice,
# this list of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.
#
# Neither the name of the James R. Larus nor the names of its contributors may be
# used to endorse or promote products derived from this software without specific
# prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
# GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

        .data
msg:   .asciiz "Hello World"
	.extern foobar 4

        .text
        .globl main
main:   li $v0, 4       # syscall 4 (print_str)
        la $a0, msg     # argument: string
        syscall         # print the string
        lw $t1, foobar
        
        jr $ra          # retrun to caller





elemDistintos:
        addi	$sp, $sp, -8			# $sp = $sp + -8
        sw		$rs, 4($sp)		# 
        sw		$s0, 0($sp)		# 
        
        li		$a2, 0		# $a2 = 0
        li		$a3, 0		# $a3 = 0
        addi	$a1, $a1, -1			# $a1 = $a1 + -1
        jal		for				# jump to for and save position to $ra
        move 	$v0, $a3		# $v0 = $a3

        lw		$s0, 0($sp)		# 
        lw		$rs, 4($sp)		# 
        addi	$sp, $sp, 8			# $sp = $sp + 8

        
        
for:
    beq		$a2, $a1, exit	# if $a2 == $a1 then Exit

    lw		$t0, v($a0)		# 
    addi	$s0, $s0, 1			# $s0 = $s0 + 1
    lw		$t1, v($a0)		# 

    addi	$a2, $a2, 1			# $a2 = $a2 + 1

    bne		$t0, $t1, soma	# if $t0 != $t1 then soma
    j		for				# jump to for
    

soma:
    addi	$a3, $a3, 1			# $a2 = $a2 + 1
    j		for				# jump to for
    
exit:
    jr		$ra					# jump to $ra