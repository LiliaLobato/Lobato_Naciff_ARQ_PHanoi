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

	

exit: