 
 .data 
 #Q4 -Sinem Ceren Konta�   
    q4prompt1:    .asciiz      "Enter numbers: "
    q4list: .space 1000 #array for the string read from user
    q4spacechar : .word ' ' #spacechar is a space character
    q4zerochar: .word '0'
    q4ninechar: .word '9'
    q4newlinechar: .word '\n'
    q4numlist: .space 1000 #array of numbers
    q4results: .space 1000 #array for results
 #Q4 end
    
    
 .text   
 #Q4 -Sinem Ceren Konta�  
    li $v0, 4     #command for printing a string
    la $a0, q4prompt1 #loading the string to print into the argument to enable printing
    syscall
    

    li $v0, 8    #command for reading a string
    la $a0, q4list
    li $a1, 1000
    syscall      #executing the command 
    
    move $t0, $a0 #a0'� bi yere kopyala	
    
    lw $t7, q4spacechar #space char put into t7
    add $t3, $zero, $zero #t3 initialized as zero
    add $t5, $zero, $zero #t5 initialized as zero, t5 is N^2
    
q4loop: 
    lbu $t1, 0($t0) #karakter kareakter alma to'� t1'e att�m
    addi $t0, $t0, 1 #to read next char
    beq $t1, $t7, q4nextelement #go to nextelement if space char occurs
    
    lw $t6, q4zerochar
    blt $t1, $t6, q4done #go to done if char not number (ascii <0)
    
    lw $t6, q4ninechar
    bgt $t1, $t6, q4done #go to done if char not number (ascii >9)
    
    addi $t2, $t1, -48 #convert char to int and keep it in t2
    mul $t3, $t3, 10 #t3=t3*10
    add $t3, $t3, $t2 #t3=(t3*10)+t2
    j q4loop
     
   
q4nextelement: #bo�luk varsa
    mul $t1, $t5, 4 #a�a��daki sat�r i�in
    sw $t3, q4numlist($t1) #put t3 to memory (t3 is the value of the number that has just been read)
    addi $t5, $t5, 1 #increase number of read numbers aka N^2
    add $t3, $zero, $zero #t3 set as zero
    j q4loop
    
q4done: #string bittiyse
    mul $t1, $t5, 4 #a�a��daki sat�r i�in
    sw $t3, q4numlist($t1) #put t3 to memory (t3 is the value of the number that has just been read)
    addi $t5, $t5, 1 #increase number of read numbers aka N^2
    j q4sqroot
    
    
q4sqroot: #square root operation to get dimension N
    addi $t1, $zero, 1 #t1=1,2,3,4.... diye gidecek
    addi $t2, $zero, 3 #t2=1,3,5... diye gidecek
    addi $t3, $zero, 1 #t3 toplam olacak, t3=1,4,9,16... diye gidecek
q4sqloop: 
    beq $t5, $t3, q4dimacqd
    add $t3, $t3, $t2
    addi $t2, $t2, 2
    addi $t1, $t1, 1
    j q4sqloop
    
q4dimacqd:
    move $t5, $t1 # N (dimension) t5'te tutuluyor
    
    
    addi $t0, $zero, 1 #i�lemlerin N kez yap�lmas� kontrol� counter, 80. sat�rdaki lw 1 i�lem yap�lm�� gibi davran�yor
    addi $t7, $zero, 0 #index
    addi $t6, $zero, 0 #sat�r counter
    mul $t1, $t5, 4
    addi $t1, $t1, 4 #indexe eklemek i�in 4(n+1) hesaplan�yor, t1'de tutuluyor
    mul $t2, $t5, 4
    addi $t2, $t2, -4 #indexten ��karmak i�in 4(n-1) hesaplan�yor, t2'de tutuluyor
    lw $t3, q4numlist($t7) # matrixin ba�lang�c�
    
q4horizontaladd: #yatayda yap�lan i�lemler 
    add $t7, $t7, $t1 #index (n+1) ileriye
    lw $t4, q4numlist($t7) #yeni eleman� loadla
    mul $t3, $t3, $t4 #eski elemanla �arp
    addi $t0, $t0, 1 #i�lem sayac�n� artt�r
    beq $t0, $t5, q4horizontaldone #maks i�lem say�s� n'e ula��ld�ysa terminate
q4horizontalsub:    #yatayda yap�lan ikinci i�lem
    sub $t7, $t7, $t2 #index (n-1) geriye
    lw $t4, q4numlist($t7) #yeni eleman� loadla
    mul $t3, $t3, $t4 #eski elemanla �arp
    addi $t0, $t0, 1 #i�lem sayac�n� artt�r
    beq $t0, $t5, q4horizontaldone #maks i�lem say�s� n'e ula��ld�ysa terminate
    j q4horizontaladd #i�lemleri s�rd�r
    
q4horizontaldone:
    addi $v0, $zero, 1
    move $a0, $t3
    syscall #bir �arp�m�n sonucunu yazd�r
    addi $v0, $zero, 11
    lw $a0, q4spacechar
    syscall #space yazd�r
    addi $t6, $t6, 1 #sat�r sayac�n� artt�r
    div $t0, $t5, 2 
    beq $t6, $t0, q4vertical #sat�r i�lemi sayac� n/2'ye e�it ise sat�r i�lemleri bitmi�tir
    addi $t0, $zero, 1 #i�lemlerin N kez yap�lmas� kontrol� counter, 80. sat�rdaki lw 1 i�lem yap�lm�� gibi davran�yor
    addi $t7, $zero, 1 
    mul $t7,$t7, 8
    mul $t7,$t7, $t6
    mul $t7,$t7, $t5 #bu d�rt sat�r 8*t6*t5, sonraki sat�r�n ba�lang�� indexini hesaplar (2n*sat�r sayac�)
    lw $t3, q4numlist($t7)
    j q4horizontaladd
    
q4vertical:
    addi $v0, $zero, 11
    lw $a0, q4newlinechar
    syscall #alt sat�ra dikey i�lemleri yazd�rmaya ge�
    addi $t6, $zero, 0 #s�tun sayac�
    addi $t0, $zero, 1 #i�lemlerin N kez yap�lmas� kontrol� counter, 80. sat�rdaki lw 1 i�lem yap�lm�� gibi davran�yor
    addi $t7, $zero, 4 #index dikeyde 1'den ba�l�yor
    lw $t3, q4numlist($t7) # matrixin ba�lang�c�
    
q4verticalleft: #dikey i�lemlerin sola gidilen ad�mlar�
    add $t7, $t7, $t2 #index (n+1) ileriye
    lw $t4, q4numlist($t7) 
    mul $t3, $t3, $t4 #�nceki elemanla �arpma
    addi $t0, $t0, 1 #i�lem sayac�n� artt�r
    beq $t0, $t5, q4verticaldone #s�tunun sonuna gelindiyse
q4verticalright: #dikey i�lemlerin sa�a gidilen ad�mlar�
    add $t7, $t7, $t1 #index (n-1) ileri 
    lw $t4, q4numlist($t7) 
    mul $t3, $t3, $t4 #�nceki ile �arpma
    addi $t0, $t0, 1 #i�lem sayac�n� artt�r
    beq $t0, $t5, q4verticaldone #s�tun sonuna gelindiyse
    j q4verticalleft #s�tun sonuna gelinmediyse devam et
    

q4verticaldone:
    addi $v0, $zero, 1
    move $a0, $t3
    syscall #bir �arp�m�n sonucunu yazd�r
    addi $v0, $zero, 11
    lw $a0, q4spacechar
    syscall #space koy
    addi $t6, $t6, 1 #s�tun sayac�n� artt�r
    div $t0, $t5, 2 
    beq $t6, $t0, q4exit #s�tun sayac� n/2'ye e�it mi kontrol�, e�it ise program�n sonu
    addi $t0, $zero, 1 #i�lemlerin N kez yap�lmas� kontrol� counter, 80. sat�rdaki lw 1 i�lem yap�lm�� gibi davran�yor
    mul $t7, $t6, 2
    addi $t7, $t7, 1 
    mul $t7, $t7, 4 #sonraki s�tun i�leminin ba�lang�� offseti
    lw $t3, q4numlist($t7)
    j q4verticalleft
    
    
q4exit:

 #Q4 end
