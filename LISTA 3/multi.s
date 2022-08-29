multfac:
    slt        $t1, $a0, $zero        # se o multiplicando for negativo t1 recebe 1 
    slt        $t2, $a1, $zero        # se o multiplicador for negativo t2 recebe 1     

    li $s3, 0        # LO do produto
    li $s4, 0        # HI do produto

    li $t3, 1        # contador 
    li $t4, 33        # condicao de parada

    beq $a1, $0, fim   
    beq $a0, $0, fim

    move $s2, $0        # extende o produto para 64 bits

    bne        $t1, $zero, complementoa0    # if $t1 !=zerot1 then target
    bne        $t2, $zero, complementoa1    # if $t1 !=zerot1 then target

    j        loop                # jump to loop
    

complementoa0:
    nor        $a0, $a0, $zero        # $a9 = zero$t1 | $t2)
    addi    $a0, $a0, 1            # $a0 = a01 1 0
    beq        $t2, $zero, loop    # if $t2 ==zerot1 then target

complementoa1:
    nor        $a1, $a1, $zero        # $a9 = zero$t1 | $t2)
    addi    $a1, $a1, 1            # $a0 = a01 1 0


loop:
    andi $t0, $a0, 1    # ultimo bit do meu multiplicador
    beq $t0, $0, shift   # se meu ultimo bit do multiplicador for 0 ele ja vai para o shift

    addu $s3, $s3, $a1  # O LO do produto recebe meu multiplicador
    sltu $t0, $s3, $a1  # obtem meu carry extra

    addu $s4, $s4, $t0  # o HI do meu produto recebe meu carry
    addu $s4, $s4, $s2  # o HI do meu produto recebe meu multiplicando
shift:
    
    srl $t0, $a1, 31    # copia o bit do LO para meu HI 

    sll $a1, $a1, 1     #realiza o shift a esquerda do meu multiplicador
    sll $s2, $s2, 1     #realiza o shift a esquerda do meu multiplicando

    addu $s2, $s2, $t0  #adiciona o ultimo bit do meu multiplicador no meu multiplicando

    srl $a0, $a0, 1     # realiza um shifta direita no meu multiplicador
    
    addi    $t3, $t3, 1            # $t3 = $31 1 0
    beq        $t3, $t4, fim    # if $t3 ==t4t1 then target
    bne        $t3, $t4, loop    # if $t3 != 4t1 then target
    
fim:
    bne        $t1, $t2, fim2    # if $t1 != 2t1 then target

    mthi    $s4
    mtlo    $s3

    j        exit                # jump to exit
    
fim2:
    nor        $s4, $s4, $zero        # $s4 = s4$t1zero $t2)

    nor        $s3, $s3, $zero        # $s4 = s4$t1zero $t2)
    addi    $s3, $s3, 1            # $s4 = s41 1 0

    mthi    $s4
    mtlo    $s3

exit:
    jr        $ra                    # jump to $ra