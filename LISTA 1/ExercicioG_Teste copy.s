main:   
    li		$a0, 127		# $a0 = 50
    
    jal		bitparidade				# jump to bitparidade and save position to $ra

    move 	$t5, $v0		# $t5 = $v0
    move 	$t6, $v1		# $t6 = $v1

    li		$v0, 1		# $v0 = 1
    move 	$a0, $t5		# $a0 = $t5
    syscall

    li		$v0, 1		# $v0 = 1
    move 	$a0, $t6		# $a0 = $t5
    syscall

    li		$v0, 10		# $v0 = 10
    syscall
    
    
    

bitparidade:
        li		$t4, 128		# $t4 = 128
        slt		$t7, $a0, $t4		# $t7 = ($a0 < $t4) ? 1 : 0
        beq		$t7, $zero, extitall	# if $t7 == $zero then extitall

        addi	        $sp, $sp, -8			# $sp = $sp + -8
        sw		$ra, 41 sp)		# 
        sw		$s0, 0($sp)		# 
        
        li		$a1, 1		# $a1 = 1
        li		$a3, 0		# $a3 = 0
        li		$a2, 0		# $a2 = 0
        
        jal		loop				# jump to loop and save position to $ra
        
        jal		comp				# jump to comp and save position to $ra

        lw		$s0, 0($sp)		# 
        lw		$ra, 4($sp)		# 
        addi	        $sp, $sp, 8			# $sp = $sp + 8

        jr		$ra	

loop:
        li		$t1, 7		# $t1 = 7
        beq		$a2, $t1, exit	# if $a2 == $t1 then exit
        
        and		$t2, $a0, $a1		# $t2 = $a0 & $a1`
        sll		$a1, $a1, 1			# $a1 = $a1 << 1
        
        addi	        $a2, $a2, 1			# $a2 = $a2 + 1
        
        bne		$t2, $zero, soma	# if $t2 != $zero then soma
        j		loop				# jump to loop
        
soma:

        addi	        $a3, $a3, 1			# $a3 = $a3 + 1
        j		loop				# jump to loop

exit:

        jr		$ra					# jump to $ra
    
        
comp:
        li		$t0, 2		# $t0 = 2
        
        div	        $a3, $t0			# $a3 / $t0
        mfhi	        $t1					# $t3 = $t0 mod $t1 

        bne		$t1, $zero, impar	# if $t1 != $zero then impar
        move	        $v1, $a0			# $v1 = $a0 >> 1
        move 	        $v0, $zero		# $v0 = $zero
        
        jr		$ra					# jump to $ra

impar:

        li		$t2, 128		# $t2 = 128
        add		$v1, $a0, $t2		# $v1 = $a0 | $t2
        li		$v0, 1		# $v0 = 1
        

        jr		$ra					# jump to $ra
        
        
extitall:
        jr		$ra					# jump to $ra
        
        
     