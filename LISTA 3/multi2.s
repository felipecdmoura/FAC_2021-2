

multfac:

    slt		$t0, $a0, $zero		# $t0 = ($a0 < $zero) ? 1 : 0
    li		$t1, 1		# $t1 = 1
    
    beq		$t0, $t1, cmp2_1	# if $t0 == $t1 then target

    slt		$t0, $a1, $zero		# $t0 = ($a0 < $zero) ? 1 : 0
    li		$t1, 1		# $t1 = 1
    
    beq		$t0, $t1, cmp2_2	# if $t0 == $t1 then target
    
    move $s0, $a0       
    move $s1, $a1        
    move $s3, $0        # lw product
    move $s4, $0        # hw product

    move $s2, $0        # extend multiplicand to 64 bits

    j		multopr				# jump to multopr and save position to $ra
    
    
cmp2_1:

    nor		$a0, $a0, $zero		# $a0 = ~($a0 | $zero)
    addi	$a0, $a0, 1			# $a0 = $a0 + 1

    addi	$s5, $s5, 1			# $s5 = $s5 + 1

    j		multfac				# jump to $ra
    
cmp2_2:

    nor		$a1, $a1, $zero		# $a0 = ~($a0 | $zero)
    addi	$a1, $a1, 1			# $a0 = $a0 + 1

    addi	$s5, $s5, 1			# $s5 = $s5 + 1
    j		multfac				# jump to $ra
    
multopr:

    andi $t0, $s0, 1    # LSB(multiplier)
    beq $t0, $0, eqlzero   # skip if zero
    addu $s3, $s3, $s1  # lw(product) += lw(multiplicand)
    sltu $t0, $s3, $s1  # catch carry-out(0 or 1)
    addu $s4, $s4, $t0  # hw(product) += carry
    addu $s4, $s4, $s2  # hw(product) += hw(multiplicand)

eqlzero:

     # shift multiplicand left
    srl $t0, $s1, 31    # copy bit from lw to hw
    sll $s1, $s1, 1
    sll $s2, $s2, 1
    addu $s2, $s2, $t0

    srl $s0, $s0, 1     # shift multiplier right
    bne $s0, $0, multopr

exit:

    li		$t1, 1		# $t1 = 1
    beq		$s5, $t1, cmp2_3	# if $s5 == $t1 then cmp2_3

    j		end				# jump to end
    
cmp2_3:

    nor		$s3, $s3, $zero		# $a0 = ~($a0 | $zero)
    addi	$s3, $s3, 1			# $a0 = $a0 + 1

    nor		$s4, $s4, $zero		# $a0 = ~($a0 | $zero)
    li		$s5, 0		# $s5 =0 
    

    j		exit				# jump to exit
    
end:

    mtlo $s3
    mthi $s4

    jr		$ra					# jump to $ra