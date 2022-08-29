.data
over:    .asciiz     "overflow"

.text

main:
    
    li		$v0, 5		# $v0 = 5
    syscall
    move 	$s0, $v0		# $t0 = $v0

    li		$v0, 5		# $v0 = 5
    syscall
    move 	$s1, $v0		# $t1 = $v0
    
    li		$v0, 5		# $v0 = 5
    syscall
    move 	$s2, $v0		# $t1 = $v0

    beq		$s0, $zero, sem_sinal	# if $s0 ==zero sem_sinal
    
    bne		$s0, $zero, com_sinal	# if $s0 !=zero com_sinal 
        
sem_sinal:

    nor		$s3, $s1, $zero		# $s1 = 3($s1 | $zero)
    sltu    $s3, $s3, $s2     # $s3 < $s2
    bne		$s3, $zero, overflow	# if $s3 !=$zero then overflow
    
    j		resul_sem_sinal				# jump to resul_sem_sinal
    
com_sinal:

    addu		$s4, $s1, $s2		# $s4 = $s1 + $s2

    xor		$s3, $s1, $s2		# $s3 = $s1 ^ $s2
    
    slt		$s3, $s3, $zero		# $s3 = ($s3 < $zero) ? 1 : 0
    bne		$s3, $zero, result_com_sinal	# if $s3 != $zero then result_com_sinal
    
    xor		$s3, $s4, $s2		# $s3 = $s4 ^ $s2
    slt		$s3, $s3, $zero		# $s3 = ($s3 < $zero) ? 1 : 0
    bne		$s3, $zero, overflow	# if $s3 != $zero then overflow
    
    j		result_com_sinal				# jump to result_com_sinal
    
    
overflow:
    
    li		$v0, 4		# $v0 = 4
    la		$a0, over		# 
    syscall
    
    li		$v0, 10 		# $v0 = 1
    syscall
        
        
resul_sem_sinal:  

    add		$s3, $s1, $s2		# $s3 = $s1 + $s2
    
    li		$v0, 1		# $vo = 1
    move 	$a0, $s3		# $a0 = s3
    syscall

    li		$v0, 10 		# $v0 = 1
    syscall

        
result_com_sinal:

    li		$v0, 1		# $vo = 1
    move 	$a0, $s4		# $a0 = s3
    syscall

    li		$v0, 10 		# $v0 = 1
    syscall

        
        
        
        