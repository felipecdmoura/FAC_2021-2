
.text

main:
    
    li		$v0, 5		# $v0 = 5
    syscall
    move 	$a0, $v0		# $t0 = $v0

    li		$v0, 5		# $v0 = 5
    syscall
    move 	$a1, $v0		# $t1 = $v0
    
    jal		multfac				# jump to multfac

    li		$v0, 1		# $vo = 1
    mfhi    $a0
    syscall

    li		$v0, 1		# $vo = 1
    mflo    $a0
    syscall

    li		$v0, 10		# $vo = 1
    syscall

multfac:

    slt		$t0, $a0, $zero		# $t0 = ($a0 < $zero) ? 1 : 0
    slt		$t1, $a1, $zero		# $t0 = ($a0 < $zero) ? 1 : 0
    li		$t2, 1		# $t1 = 1
           
    li      $s3, 0        # lw product
    li      $s4, 0        # hw product

    beq $a1, $0, exit   
    beq $a0, $0, exit

    move    $s2, $0        # extend multiplicand to 64 bits

    li		$t3, 0		# $t3 = 0
    li		$t4, 1		# $t4 = 33
    li		$t5, 33		# $t5 = 33
    

    beq		$t0, $t2, cmp2_1	# if $t0 == $t1 then target
    beq		$t1, $t2, cmp2_2	# if $t0 == $t1 then target

    j		multopr				
    
    
cmp2_1:

    nor		$a0, $a0, $zero		# $a0 = ~($a0 | $zero)
    addi	$a0, $a0, 1			# $a0 = $a0 + 1

    addi	$t3, $t3, 1			# $t3 = $t3 + 1

    beq		$t1, $zero, multopr	# if $t1 ==zerot1 then target
    
    
    
cmp2_2:

    nor		$a1, $a1, $zero		# $a0 = ~($a0 | $zero)
    addi	$a1, $a1, 1			# $a0 = $a0 + 1

    addi	$t3, $t3, 1			# $t3 = $t3 + 1
    
    
multopr:

    andi $t0, $a0, 1     
    beq $t0, $0, eqlzero   
    addu $s3, $s3, $a1  
    sltu $t0, $s3, $a1  
    addu $s4, $s4, $t0  
    addu $s4, $s4, $s2  

eqlzero:

    srl $t0, $a1, 31    
    sll $a1, $a1, 1
    sll $s2, $s2, 1
    addu $s2, $s2, $t0

    srl $a0, $a0, 1     

    addi	$t4, $t4, 1			# $t4 = $t4 + 1
    
    beq $t4, $t5, exit
    bne $t4, $t5, multopr
    

exit:

    li		$t1, 1		# $t1 = 1
    beq		$t3, $t1, cmp2_3	# if $t3 == $t1 then cmp2_3

    mtlo $s3
    mthi $s4

    j		end				# jump to end
    
cmp2_3:

    nor		$s3, $s3, $zero		# $a0 = ~($a0 | $zero)
    addi	$s3, $s3, 1			# $a0 = $a0 + 1

    nor		$s4, $s4, $zero		# $a0 = ~($a0 | $zero)
    li		$t3, 0		# $t3 =0 
    
    mtlo $s3
    mthi $s4
    
    j		end				# jump to exit
    
end:
    jr		$ra					# jump to $ra