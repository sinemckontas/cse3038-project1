	.data
strWelcome:  .asciiz  "Main Menu:\n 1. Base Converter\n 2. Add Rational Number\n 3. Text Parser\n 4. Mystery Matrix Operation \n 5. Exit\n "
strOption:   .asciiz  "Please select an option:\n"
strEnd:	     .asciiz  "5 and exitting...\n"
strFonksiyon: .asciiz "Fonksiyon\n"

strFirstNom: .asciiz "Enter the first nominator:\n"
strSecondNom: .asciiz "Enter the second nominator:\n"

strFirstDenom: .asciiz "Enter the first denominator:\n"
strSecondDenom: .asciiz "Enter the second denominator:\n"

strSlash: .asciiz "/"

	.text 
	
main:

	add $t0, $zero , $zero
	
while:	beq $t0, 5, endwhile 	#while option is not 5(exit)

	li $v0, 4		#welcome message
	la $a0, strWelcome
	syscall
	
	li $v0, 4		#getting option as an input
	la $a0, strOption
	syscall
	
	li $v0, 5		#storing option to temp
	syscall
	move $t0, $v0
	
	
	beq $t0, 1, question1
	
	beq $t0, 2, question2
	
	
	j while
	

endwhile: 
	
	li $v0, 4
	la $a0, strEnd		#exit message
	syscall 
	
	li $v0, 10		#exit
	syscall

question1:
	
	li $v0, 4
	la $a0, strFonksiyon		
	syscall	
	
	j while

question2:
	

	
	li $v0, 4
	la $a0, strFirstNom	#ask first nominator		
	syscall
	
	li $v0, 5
	syscall 
	move $t1, $v0		#first nom --> t1
	
	#-----------------------
	li $v0, 4
	la $a0, strFirstDenom		
	syscall
	
	li $v0, 5
	syscall 
	move $t2, $v0		#first denom --> t2
	#-----------------------
	li $v0, 4
	la $a0, strSecondNom		
	syscall

	li $v0, 5
	syscall 
	move $t3, $v0		#second nom --> t3
	#-----------------------
	li $v0, 4
	la $a0, strSecondDenom		
	syscall	

	li $v0, 5
	syscall 
	move $t4, $v0		#second denom --> t4
	#-----------------------
	
	
	mul $t5 ,$t1, $t4	#first nom * second denom -> t5
	mul $t6, $t3, $t2	#second nom * first denom -> t6
	
	add $t5, $t5, $t6	#t5 = (firstNom*secondDenom+ secondNom*firstDenom)
	
	mul $t6, $t2, $t4	#t6 = firstDenom*secondDenom
	
	add $a1, $t5, $zero	# a1 = t5
	add $a2, $t5, $zero	# a2 = t6
	
	jal gcd			#jump to the gcd func
	
	add $a0 ,$v0, $zero
	
	div $a2, $t5, $a0
	li $v0, 4
	syscall
	
	li $v0, 5
	la $a3, strSlash
	syscall
	
	div $a1, $t6, $a0
	li $v0, 4
	syscall
	
	
	
	
	j while
 
 
gcd:
	addi, $sp, $sp, -12
	
	sw $ra, 0($sp)	#push func into the stack
	sw $s0, 4($sp)	#push s0 into stack
	sw $s1, 8($sp)	#push s1 into stack
	
	add $s0, $a0, $zero	#s0 = first param
	add $s1, $a1, $zero	#s1 = second param
	
	add $t1, $zero, $zero	#t1 = 0
	
	beq $t1, $s1, returnGcd		#if second param is equal to zero return the output
	
	addi $a0, $s1, 0		#a0 = second param
	
	
	div $t0, $s0, $s1
	mfhi $t7
	
	addi $a1, $t7, 0
	
	jal gcd
	
	
	returnGcd:
		move  $v0, $s0	#returns first param (gcd)
		jal exitGcd
	exitGcd:
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		
		addi $sp, $sp, 12
		
		jr $ra
	
	  
	
	
	
	
	
	
	
	
	
	
	
	

	