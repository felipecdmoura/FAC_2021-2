.data
v: .space 16 

.text

main:
    move 	$t0, $zero		# $t0 = $zero
    move 	$t1, $zero		# $t1 = $zero

    
    
    sw		$t1, v($t0)		# 
    addi	$t0, $t0, 4			# $t0 = $t0 + 4
    addi	$t1, $t1, 2			# $t1 = $t1 + 2
  

    sw		$t1, v($t0)		# 
    addi	$t0, $t0, 4			# $t0 = $t0 + 4
    addi	$t1, $t1, 2			# $t1 = $t1 + 2

    sw		$t1, v($t0)		# 
    addi	$t0, $t0, 4			# $t0 = $t0 + 4
    addi	$t1, $t1, 2			# $t1 = $t1 + 2

    sw		$t1, v($t0)		# 
    
    move 	$a0, $zero		# $a0 = $zero
    li		$a1, 4		# $a1 = 4
    
    jal		elemDistintos				# jump to elemDistintos and save position to $ra

    move 	$a0, $v0		# $t0 = $v0
    li		$v0, 1		# $v0 = 1
    syscall
    
    li		$v0, 10 		# $v0 = 1
    syscall

    
    
elemDistintos:
        addi	$sp, $sp, -8			# $sp = $sp + -8
        sw		$ra, 4($sp)		# 
        sw		$s0, 0($sp)		# 
        
        li		$a2, 0		# $a2 = 0
        li		$a3, 0		# $a3 = 0
        addi	$a1, $a1, -1			# $a1 = $a1 + -1
        jal		for				# jump to for and save position to $ra

        move 	$v0, $a3		# $v0 = $a3
        addi	$v0, $v0, 1			# $v0 = $v0 + 1

        lw		$s0, 0($sp)		# 
        lw		$ra, 4($sp)		# 
        addi	$sp, $sp, 8			# $sp = $sp + 8

        jr		$ra					# jump to $ra
        

        t0 = a[a2+3]
        t1 = a[a2+4]          5, 8 , 8, 10
        
for:
    beq		$a2, $a1, exit	# if $a2 == $a1 then Exit

    lw		$t0, 0($a0)		# 
    addi	$a0, $a0, 4			# $a0 = $a0 + 1
    lw		$t1, 0($a0)		# 

    addi	$a2, $a2, 1			# $a2 = $a2 + 1

    bne		$t0, $t1, soma	# if $t0 != $t1 then soma
    j		for				# jump to for
    

soma:
    addi	$a3, $a3, 1			# $a2 = $a2 + 1
    j		for				# jump to for
    
exit:
    jr		$ra					# jump to $ra
    
        


        

        
        

    
        
        
        
        
        
        


        
        

        
        
        
        