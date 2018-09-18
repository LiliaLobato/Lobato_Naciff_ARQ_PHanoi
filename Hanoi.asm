.data	#Variables globales
	A: .word 0      # Array1 in Memory
	B: .word 0  	# Array2 in Memory
	C: .word 0      # Array3 in Memory

.text
main:
	# Almacena la direccion de cada Arreglo
	la $s1, 0x10010000 # Loading an address
	la $s2, 0x10010020  # Loading an address
	la $s3, 0x10010040  # Loading an address
	
	