.data 

str: .asciiz "11111101"
strFirstNom: .asciiz "Enter the first nominator:\n"
strSecondNom: .asciiz "Enter the second nominator:\n"

strFirstDenom: .asciiz "Enter the first denominator:\n"
strSecondDenom: .asciiz "Enter the second denominator:\n"

strSlash: .asciiz "/"

.text



question2:
	

	
	li $v0, 4
	la $a0, strFirstNom		#ask first nominator		
	syscall
	
	li $v0, 5
	syscall 
	move $t1, $v0			#first nom --> t1
	
	#-----------------------
	li $v0, 4
	la $a0, strFirstDenom		#ask first denominator
	syscall
	
	li $v0, 5
	syscall 
	move $t2, $v0			#first denom --> t2
	#-----------------------
	li $v0, 4
	la $a0, strSecondNom		#ask second nominator	
	syscall

	li $v0, 5
	syscall 
	move $t3, $v0			#second nom --> t3
	#-----------------------
	li $v0, 4
	la $a0, strSecondDenom		#ask second denominator
	syscall	

	li $v0, 5
	syscall 
	move $t4, $v0			#second denom --> t4
	#-----------------------
	
	
	mul $t5 ,$t1, $t4		#first nom * second denom -> t5
	mul $t6, $t3, $t2		#second nom * first denom -> t6
	
	add $t7, $t5, $t6		#t7 = (firstNom*secondDenom+ secondNom*firstDenom)
	
	add $s7, $t7, $zero		#save final nom
	
	mul $t6, $t2, $t4		#t6 = firstDenom*secondDenom
	add $s6, $t6, $zero		#save final denom

	
	#add $a1, $t5, $zero	# a1 = t5
	#add $a2, $t5, $zero	# a2 = t6
	
	jal gcd				#jump to the gcd func
	
	

	
	
	div $s7, $s7, $v1		#divide nom to gcd
	div $s6, $s6, $v1		#divide denom to gcd
	
	li $v0 ,1			#printi int
	add $a0 ,$s7, $zero
	syscall				#print gcd
	
	li $v0, 4
	la $a0, strSlash		#ask first denominator
	syscall
	
	li $v0 ,1			#printi int
	add $a0 ,$s6, $zero
	syscall				#print gcd	
	
	
	j exitq2
	
	
gcd:
	addi, $sp, $sp, -12
	
	sw $ra, 0($sp)			#push func into the stack
	sw $s0, 4($sp)			#push s0 into stack
	sw $s1, 8($sp)			#push s1 into stack
	
	
	

	
	
	add $s0, $t6, $zero		#s0 = first param
	add $s1, $t7, $zero		#s1 = second param
	
	#add $t1, $zero, $zero		#t1 = 0
	
	beq $zero, $s1, returnGcd	#if second param is equal to zero return the output
	
	addi $t6, $s1, 0		#t6 = second param
	
	
	

	
	
	div $s0, $s1
	mfhi $t2
	
	
#	li $v0 ,1			#printi int
#	add $a0 ,$t2, $zero
#	syscall				#print gcd
	
#	j exitq2
	
	
	
	
	addi $t7, $t2, 0		
	
	jal gcd
	
	

	
	

	
	
returnGcd:
	move  $v1, $t6	#returns first param (gcd)
	jal exitGcd
exitGcd:
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
		
	addi $sp, $sp, 12
		
	jr $ra
	
exitq2:
	
	
	
	
	
	
	
	
	
	

	
