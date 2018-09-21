.data
tower_A: .word 0 0 0 0 0 0 0 0
tower_B: .word 0 0 0 0 0 0 0 0
tower_C: .word 0 0 0 0 0 0 0 0

.text
main:
	la $a1, tower_A
	la $a2, tower_C
	la $a3, tower_B
	la $t6, tower_A
	add $a0,$zero, 8
	
for:	
	sw $s2, ($t6)
	addi $t6, $t6, 4
	addi $s2, $s2, -1
	bne $s2, 0, for
endFor:	
	jal hanoi
	j exit

hanoi:
	beq $a0,1,uno
	
nouno:
	#Cambio apuntadores 
	add $a0,$a0,-1
	add $t0,$zero,$a3
	add $a3,$zero,$a2
	add $a2,$zero,$t0
	
	jal hanoi
	
	#Mover disco
	
	#Cambio apuntadores
	add $t0, $zero,$a1
	add $a1,$zero,$a3
	add $a3,$zero,$t0
	
	jal hanoi
	
	#Cambio apuntadores
	add $t0, $a1, $zero
	addi $a1,$a3,-4
	add $a3,$t0,4
	
	jr $ra
	
uno:
	#mover disco
	
	jr $ra
	

exit: