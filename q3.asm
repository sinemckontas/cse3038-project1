.data
 #Q3 -Sinem Ceren Kontaþ   
    q3prompt1:    .asciiz      "Enter string: "
    q3str: .space 1000 #array for the string read from user
    q3prompt2:    .asciiz      "Enter parser set: "
    q3parsers: .space 100 #array for the parser set read from user
    q3nullchar: .word 0 #null character
    q3newlinechar: .word '\n'
    q3spacechar : .word ' ' #spacechar is a space character
    q3wordlist: .space 1000 #array of words
#Q3 end

 
 .text   
 #Q3 -Sinem Ceren Kontaþ  
    li $v0, 4     #command for printing a string
    la $a0, q3prompt1 #loading the string to print into the argument to enable printing
    syscall
    

    li $v0, 8    #command for reading a string
    la $a0, q3str
    li $a1, 1000
    syscall      #executing the command 
    
    move $t0, $a0 #a0'ý bi yere kopyala	 
    add $t4, $zero, $zero #t4 initialized as zero, represents the word just read
    add $t5, $zero, $zero #t5 initialized as zero, represents length of string
    
    
    li $v0, 4     #command for printing a string
    la $a0, q3prompt2 #loading the string to print into the argument to enable printing
    syscall
    

    li $v0, 8    #command for reading a string
    la $a0, q3parsers
    li $a1, 1000
    syscall      #executing the command
    
    move $t1, $a0 #a0'ý bi yere kopyala	  
    lw $t7, q3spacechar #space char put into t7
    add $s0, $zero, $zero
    
    
q3stringloop: 
    lbu $t2, 0($t0) #karakter kareakter string okuma
    addi $t0, $t0, 1 #to read next char
    beq $t2, $t7, q3nextelement #go to nextelement if space char occurs
    
    lw $t6, q3nullchar
    beq $t2, $t6, q3done #go to done if null char occurs
    lw $t6, q3newlinechar
    beq $t2, $t6, q3done #go to done if newline char occurs
    
q3parserloop:
    lbu $t3, 0($t1)   #karakter karakter parse set okuma
    addi $t1, $t1, 1 #read next parse char
    beq $t2, $t3, q3nextelement #go to nextelement if parser char occurs
    beq $t3, $t7, q3parserloop # ignore space
    lw $t6, q3nullchar
    beq $t3, $t6, q3parserdone #go to done if null char occurs
    lw $t6, q3newlinechar
    beq $t3, $t6, q3parserdone #go to done if newline char occurs
    j q3parserloop
     
#deðiþecek
q3nextelement: #boþluk ya da parse char varsa
    la $t1, q3parsers
    beq $s0, 0, q3stringloop
    lw $t6, q3newlinechar
    li $v0, 11
    move $a0, $t6
    syscall
    add $s0, $zero, $zero
    j q3stringloop

q3parserdone: #print character
    la $t1, q3parsers
    li $v0, 11
    move $a0, $t2
    syscall
    addi $s0, $s0, 1
    j q3stringloop
   
q3done: #string bittiyse
    lw $t6, q3newlinechar
    li $v0, 11
    move $a0, $t6
    syscall
#Q3 end 