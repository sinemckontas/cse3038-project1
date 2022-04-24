.data
q1inputText: 	.asciiz "Input: "
q1typeText: 	.asciiz "Type: "
q1outputText:	.asciiz "Output: "	

q1list:           .space 1000
q1resultString:	.space 1000

.text
q1function1:
	li $v0, 4             #input texti yüklüyoruz
	la $a0, q1inputText     #inputu basýyoruz
	syscall
	
	li $v0, 8 
	la $a0, q1list    # load byte space into address
	li $a1, 1000     # allot the byte space for string
	syscall
	
	li $v0, 4
	la $a0, q1typeText
	syscall
	
	li $v0, 5
	syscall		# The type number is stored in v0
	
	move $s0, $v0	# Save the type value in s0
	j q1length
	
q1length_ret:
	move $s1, $v0	# Save the length of binary string in s1
	# beq $s0, 1, base_ten
	# beq $s0, 2, base_sixteen

q1convert_ret:
   	la $a0, q1outputText	# load and print "output" string
    	li $v0, 4
    	syscall
    		
   	la $a0, q1resultString	# reload byte space to primary addressmove $a0, $s0   # primary address = t0 address (load pointer)
    	li $v0, 4		# print string
    	syscall
    	j q1exit

q1length:
	addi $t0, $zero, 0 # Array index
	addi $t1, $zero, 0 # Character read from array
	addi $t2, $zero, 0 # Number of valid characters
q1length_loop:
	lbu $t1, q1list($t0)			# Load the character from user input
	beq $t1, 48, q1length_loop_count_char	# branch if char == '0'
	beq $t1, 49, q1length_loop_count_char	# branch if char == '1'
	beq $t1, 32, q1length_loop_skip_char	# skip current char if space character
	j q1length_loop_return			# Character is neither '0', '1', nor a space. Invalid char, EOL reached.
q1length_loop_count_char:
	addi $t2, $t2, 1 # Increment valid char counter
q1length_loop_skip_char:
	addi $t0, $t0, 1 # Move to next char
	j q1length_loop
q1length_loop_return:
	move $v0, $t2	# Return the length of binary number
	j q1length_ret

q1exit:
