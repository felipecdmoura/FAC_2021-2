        .data

msg1:   .asciiz     "Digite a: "
msg2:   .asciiz     "Digite b: "
res:    .asciiz     "a + b = "
nl:     .asciiz     "\n"
        
        .text
main:
        # li (pseudoinstrucao): li reg, const  => carrega o valor da constante no registrador reg
        # la (pseudoinstrucao): la reg, rotulo => carrega o endereço de memória do rótulo no registrador reg
        # move (pseudoinstrucao): move reg1, reg2 => reg1 = reg2

        # $t0: a
        # $t1: b

        # Imprime msg1 na tela
        li          $v0, 4      # $v0 = 4
        la          $a0, msg1   # carrega em $a0 o endereço de memória de msg1
        syscall

        # Le um numero inteiro do teclado
        li          $v0, 5      # $v0 = 5
        syscall
        move        $t0, $v0    # move para $s0 o valor lido do teclado que esta em $v0

        # Imprime msg2 na tela
        li          $v0, 4      # $v0 = 4
        la          $a0, msg2   # carrega em $a0 o endereço de memória de msg2
        syscall

        # Le um numero inteiro do teclado
        li          $v0, 5      # $v0 = 5
        syscall
        move        $t1, $v0    # move para $s0 o valor lido do teclado que esta em $v0

        add $t2, $t0, $t1       # $t2 = $t0 + $t1

        # Imprime o resultado na tela
        li          $v0, 4      # $v0 = 4
        la          $a0, res    # carrega em $a0 o endereço de memória de res
        syscall

        li          $v0, 1
        move        $a0, $t2    # $a0 = $t2, o numero a ser impresso
        syscall

        # Imprime \n
        li          $v0, 4
        la          $a0, nl
        syscall

        # Encerrar o programa
        li          $v0, 10
        syscall
