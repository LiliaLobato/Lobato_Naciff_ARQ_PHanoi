.data	#Variables globales
	A: .word 0      # Array1 in Memory
	B: .word 0  	# Array2 in Memory
	C: .word 0      # Array3 in Memory

.text
main:
	# Almacena la direccion de cada Arreglo
	la $s1, 0x10010000  # Loading an address
	la $s2, 0x10010020  # Loading an address
	la $s3, 0x10010040  # Loading an address
	
	and $s0, $s0, $zero 
	ori $s0, $s0, 4		# s0 -> n -> numero de Discos
	add $s4, $s4, $s0	#Copia de n
	add $sp, $zero, $s1   	# Direccion cargado Discos
	
	#Inicializando Torre A 
Inicializar:
	sw  $s4, 0($sp)		# Loading values from stak
	addi $sp, $sp, 4 	# Increasing stack pointer
	addi $s4, $s4, -1	# Decrement de valor
	bne $s4, $zero, Inicializar   # if n < 1
	jal Hanoi 		# Calling procedure
	j Exit

Hanoi:
	
	bne $s0, 1, Recursivo   # if n < 1
				#Mueve
	j Exit

Recursivo:

Exit: 
	
	
	
	
	