.data	#Variables globales
	A: .word 0      # Array1 in Memory
	B: .word 0  	# Array2 in Memory
	C: .word 0      # Array3 in Memory

.text
main:
	# Almacena la direccion de cada Arreglo
	la $s1, 0x10010000  # Loading fila A
	la $s2, 0x10010020  # Loading fila B
	la $s3, 0x10010040  # Loading fila C
	la $s6, 0x10010060  # Loading return address
	
	#Inicializar
	and $s0, $s0, $zero 
	ori $s0, $s0, 3		# s0 -> n -> numero de Discos
	add $s4, $s4, $s0	#Copia de n
	
	#Cargar to, aux
	add $t2, $t2, $s3
	add $t3, $t3, $s2
	
	#Inicializando Torre A 
Inicializar:
	sw  $s4, 0($s1)		# Loading values from stak
	addi $s1, $s1, 4 	# Increasing stack pointer
	addi $s4, $s4, -1	# Decrement de valor
	bne $s4, $zero, Inicializar   # if n != 0
	addi $s1, $s1, -4 	# Apuntar ultimo valor
	add $t1, $t1, $s1	# Cargar from
	jal Hanoi 		# Calling procedure
zero:	add $zero,$zero,$zero
	j Exit

Hanoi:	
	
N1:	bne $s0, 1, Recursivo   # if n < 1
	lw $s5, 0($t1)		# Guarda valor ultimo
	sw $zero, 0($t1)	# Elimina de Stack ultimo valor
	sw $s5, 0($t2)		# Guarda valor en Stack
	addi $t1, $t1, -4 	# Apuntar ultimo valor
	addi $t2, $t2, 4 	# Apuntar ultimo valor
	
	jr $ra  		# Return to the caller	
			
Recursivo:
	
	add $s4, $zero, $s0	#copia n
	
	add $t4, $zero, $t1
	add $t5, $zero, $t2
	add $t6, $zero, $t3
	
	add $t1, $zero, $t1
	add $t0, $zero, $t2
	add $t2, $zero, $t3
	add $t3, $zero, $t0
	add $s0, $s0, -1
	jal Hanoi		#Llamar hanoi con n-1, from=from,to=aux, aux=to
	
	add $s0, $zero, $s4
	add $s0, $s0, -1
	add $t1, $zero, $t4
	add $t2, $zero, $t5
	add $t3, $zero, $t6
	
	#Mover
	addi $t1, $t1, -4 	# Apuntar ultimo valor
	lw $s5, 0($t1)		#Guarda valor ultimo
	sw $zero, 0($t1)	#Elimina de Stack ultimo valor
	sw $s5, 0($t2)		#Guarda valor en Stack
	addi $t1, $t1, -4 	# Apuntar ultimo valor
	addi $t2, $t2, 4 	# Apuntar ultimo valor
	
	
	#Llamar hanoi con n-1, from=aux,to=to, aux=from
	add $t0, $zero, $t1
	add $t1, $zero, $t3
	add $t2, $zero, $t2
	add $t3, $zero, $t0
	
	jal Hanoi	
	
Exit: 
	
	
	
	
	