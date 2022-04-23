 .data    
    prompt1:    .asciiz      "Enter numbers: "
    list: .space 1000 #array for the string read from user
    spacechar : .word ' ' #spacechar is a space character
    zerochar: .word '0'
    ninechar: .word '9'
    newlinechar: .word '\n'
    numlist: .space 1000 #array of numbers
    results: .space 1000 #array for results
    
    
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
    j sqroot
    
    
sqroot: #square root operation to get dimension N
    addi $t1, $zero, 1 #t1=1,2,3,4.... diye gidecek
    addi $t2, $zero, 3 #t2=1,3,5... diye gidecek
    addi $t3, $zero, 1 #t3 toplam olacak, t3=1,4,9,16... diye gidecek
sqloop: 
    beq $t5, $t3, dimacqd
    add $t3, $t3, $t2
    addi $t2, $t2, 2
    addi $t1, $t1, 1
    j sqloop
    
dimacqd:
    move $t5, $t1 # N (dimension) t5'te tutuluyor
    
    
    addi $t0, $zero, 1 #iþlemlerin N kez yapýlmasý kontrolü counter, 80. satýrdaki lw 1 iþlem yapýlmýþ gibi davranýyor
    addi $t7, $zero, 0 #index
    addi $t6, $zero, 0 #satýr counter
    mul $t1, $t5, 4
    addi $t1, $t1, 4 #indexe eklemek için 4(n+1) hesaplanýyor, t1'de tutuluyor
    mul $t2, $t5, 4
    addi $t2, $t2, -4 #indexten çýkarmak için 4(n-1) hesaplanýyor, t2'de tutuluyor
    lw $t3, numlist($t7) # matrixin baþlangýcý
    
horizontaladd: #yatayda yapýlan iþlemler 
    add $t7, $t7, $t1 #index (n+1) ileriye
    lw $t4, numlist($t7) 
    mul $t3, $t3, $t4
    addi $t0, $t0, 1
    beq $t0, $t5, horizontaldone
horizontalsub:    
    sub $t7, $t7, $t2
    lw $t4, numlist($t7)
    mul $t3, $t3, $t4
    addi $t0, $t0, 1
    beq $t0, $t5, horizontaldone
    j horizontaladd
    
horizontaldone:
    addi $v0, $zero, 1
    move $a0, $t3
    syscall
    addi $v0, $zero, 11
    lw $a0, spacechar
    syscall
    addi $t6, $t6, 1
    div $t0, $t5, 2
    beq $t6, $t0, vertical
    addi $t0, $zero, 1 #iþlemlerin N kez yapýlmasý kontrolü counter, 80. satýrdaki lw 1 iþlem yapýlmýþ gibi davranýyor
    addi $t7, $zero, 1
    mul $t7,$t7, 8
    mul $t7,$t7, $t6
    mul $t7,$t7, $t5
    lw $t3, numlist($t7)
    j horizontaladd
    
vertical:
    addi $t0, $zero, 1 #iþlemlerin N kez yapýlmasý kontrolü counter, 80. satýrdaki lw 1 iþlem yapýlmýþ gibi davranýyor
    addi $t7, $zero, 4 #index dikeyde 1'den baþlýyor
    lw $t3, numlist($t7) # matrixin baþlangýcý
    
verticalleft: #dikeyde yapýlan iþlemler
    add $t7, $t7, $t2 #index (n+1) ileriye
    lw $t4, numlist($t7) 
    mul $t3, $t3, $t4
    addi $t0, $t0, 1
    beq $t0, $t5, verticaldone 
verticalright:
    add $t7, $t7, $t1
    lw $t4, numlist($t7)
    mul $t3, $t3, $t4
    addi $t0, $t0, 1
    beq $t0, $t5, verticaldone
    j verticalleft
    

verticaldone:
    addi $v0, $zero, 11
    lw $a0, newlinechar
    syscall
    addi $v0, $zero, 1
    move $a0, $t3
    syscall
