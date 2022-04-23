 .data    
    prompt1:    .asciiz      "Enter numbers: "
    list: .space 1000 #array for the string read from user
    spacechar : .word ' ' #spacechar is a space character
    zerochar: .word '0'
    ninechar: .word '9'
    numlist: .space 1000 #array of numbers
    
    
 .text   
    li $v0, 4     #command for printing a string
    la $a0, prompt1 #loading the string to print into the argument to enable printing
    syscall
    

    li $v0, 8    #command for reading a string
    la $a0, list
    li $a1, 1000
    syscall      #executing the command 
    
    move $t0, $a0 #a0'ý bi yere kopyala	
    
    lw $t7, spacechar #space char put into t7
    add $t3, $zero, $zero #t3 initialized as zero
    add $t5, $zero, $zero #t5 initialized as zero, t5 is N^2
    
loop: 
    lbu $t1, 0($t0) #karakter kareakter alma to'ý t1'e attým
    addi $t0, $t0, 1 #to read next char
    beq $t1, $t7, nextelement #go to nextelement if space char occurs
    
    lw $t6, zerochar
    blt $t1, $t6, done #go to done if char not number (ascii <0)
    
    lw $t6, ninechar
    bgt $t1, $t6, done #go to done if char not number (ascii >9)
    
    addi $t2, $t1, -48 #convert char to int and keep it in t2
    mul $t3, $t3, 10 #t3=t3*10
    add $t3, $t3, $t2 #t3=(t3*10)+t2
    

    j loop
     
   
nextelement: #boþluk varsa
    mul $t1, $t5, 4 #aþaðýdaki satýr için
    sw $t3, numlist($t1) #put t3 to memory (t3 is the value of the number that has just been read)
    addi $t5, $t5, 1 #increase number of read numbers aka N^2
    add $t3, $zero, $zero #t3 set as zero
    j loop
    
done: #string bittiyse
    mul $t1, $t5, 4 #aþaðýdaki satýr için
    sw $t3, numlist($t1) #put t3 to memory (t3 is the value of the number that has just been read)
    addi $t5, $t5, 1 #increase number of read numbers aka N^2
    