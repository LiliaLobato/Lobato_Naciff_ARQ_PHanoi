
.data
#Apartado de memoria para torres
A: .word 0 0 0 0 0 0 0 0 #0 0 0 0 0 0 0
B: .word 0 0 0 0 0 0 0 0 #0 0 0 0 0 0 0
C: .word 0 0 0 0 0 0 0 0 #0 0 0 0 0 0 0

.text
main:
	#Carga de direccion de torres
	la $a1, A		#Carga direccion to
	la $a2, C		#Carga direccion from
	la $a3, B		#Carga direccion aux
	la $t6, A		#Carga direccion para llenado inicial
	#Num. Discos
	add $a0,$zero, 8
	
	#Copia Num. Discos
	add $s2,$zero, $a0
	
	#Apuntador a tope torre
	sll $s1, $a0, 2
	add $a1, $a1, $s1
	addi $a1, $a1, -4
	
	#Llenado de Torre 1
for:	
	sw $s2, ($t6)
	addi $t6, $t6, 4
	addi $s2, $s2, -1
	bne $s2, 0, for
endFor:	
	jal hanoi
	j exit
	
	#Funcion Hanoi
hanoi:
	beq $a0,1,uno 		#Num. Discos == 1 -> uno
	
nouno:
	#Guardando apuntadores memoria + dato
	add $sp, $sp, -8	#Regresa
	sw $ra, 0($sp)		#Direccion
	sw $a0, 4($sp)		#Num Disco
	
	#Cambio apuntadores 1
	add $a0,$a0,-1		#Decrementa el Num. Discos
	add $t0,$zero,$a3	
	add $a3,$zero,$a2	#Cambio from -> aux
	add $a2,$zero,$t0	#Cambion aux -> from
	
	#Llamada Hanoi 1 
	jal hanoi
	
	#Mover disco 2
	lw $s1, 0($a1)		#Recupera el ultimo valor de la Torre from
	sw $s1, 0($a3)		#Imprime en localidad sigueinte de Torre to 
	sw $zero, 0($a1)	#Limpia valor recién movido
	
	#Cambio apuntadores 2
	add $t0, $zero, $a1
	addi $a1, $a2, 4 	#Drecrementa tamaño aux y cambio from -> to	
	addi $a2, $a3, 4	#Drecrementa tamaño aux y cambio to -> aux
	addi $a3, $t0, 0 	#Cambio aux -> from
	
	#Llamada Hanoi 2
	jal hanoi
	
	#Cambio apuntadores 3
	add $t0, $a1, $zero
	addi $a1,$a3,-4		#Decrementa tamaño aux y cambio to -> aux
	add $a3,$t0,4		#Incrementa tamaño to y cambio aux -> to
	
	#Descargar apuntadores memoria + dato
	lw $ra, 0($sp)		#Direccion
	lw $a0, 4($sp)		#Num Disco
	addi $sp, $sp, 8	#Avanza
	
	jr $ra
	
uno:
	#mover disco 1
	lw $s1, 0($a1)		#Recupera el ultimo valor de la Torre from
	sw $s1, 0($a2)		#Imprime en localidad sigueinte de Torre to 
	sw $zero, 0($a1)	#Limpia valor recién movido
	addi $a1, $a1, -4	#Decrementa el tamaño de Torre from
	addi $a2, $a2, 4	#Incrementa tamaña torre to
	
	jr $ra
	

exit: