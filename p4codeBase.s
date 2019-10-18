.data
    endl:    .asciiz  "\n"   # used for cout << endl;
    sumlbl:    .asciiz  "Sum: " # label for sum
    revlbl:    .asciiz  "Reversed Number: " # label for rev
    pallbl:    .asciiz  "Is Palindrome: " # label for isPalindrome
    sumarr:    .word 1
               .word 3
               .word 44
               .word 66
               .word 88
               .word 90
               .word 9
               .word 232
               .word 4325
               .word 2321
    arr:       .word 1
               .word 2
               .word 3
               .word 4
               .word 5
               .word 4
               .word 3
               .word 2
               .word 1

.text

# sum               --> $s0
# address of sumarr --> $s1
# rev               --> $s2
# num               --> $s3
# isPalindrome      --> $s4
# address of arr    --> $s5
# i                 --> $t0
# beg               --> $s6
# end               --> $s7
# d                 --> $t1
# 10                --> $t2
# 100               --> $t3
main:
  
  li $s0 0
  la $s1 sumarr
  li $s2 0
  li $s3 45689
  li $s4 1
  la $s5 arr
  li $t0 0
  li $s6 0
  li $s7 8
  li $t1 -1
  li $t2 10
  li $t3 100
  
  bge $t0, $t2, next_0 
  
  loop0:
  lw $t4, ($s1)
  add $s0, $s0, $t4
  addi $s1, $s1, 4  	#sumarr[i+1]
  addi $t0, $t0, 1
  blt $t0, $t2, loop0

  next_0: 
  
  blt $s3, 0, next_1
  
  loop1:
  rem $t1, $s3, $t2
  li $t5, 0
  mul $t5, $s2, $t2 	#rev*10
  add $s2, $t5, $t1 	#rev = (rev*10) + d
  div $s3, $s3, $t2
  bgt $s3, 0, loop1
  
  next_1:
  
  bgt $s6, $s7, exit
  sll $t6, $s6, 2	#beg*4
  add $t6, $t6, $s5	#arr[beg] (1)
  lw $t8, ($t6)		#arr[beg] (2)
  sll $t7, $s7, 2	#end*4
  add $t7, $t7, $s5	#arr[end] (1)
  lw $t9, ($t7)		#arr[end] (2)
  beq $t8, $t9, loop2
  li $s4, -1
  j exit
  
  loop2:
  addi $s6, $s6, 1
  subi $s7, $s7, 1
  j next_1
  
exit:
  la   $a0, sumlbl    # puts sumlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s0       # puts sum into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, revlbl    # puts revlbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing an string
  syscall             # make a syscall to system

  move $a0, $s2       # puts rev into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall

  la   $a0, pallbl    # puts pallbl into arg0 (a0 register) for cout
  addi $v0, $0, 4     # puts 4 in v0 which denotes we are printing a string
  syscall             # make a syscall to system

  move $a0, $s4       # puts isPalindrome into arg0 (a0 register) for cout
  addi $v0, $0, 1     # puts 1 in v0 to denote we are printing an int
  syscall             # make a syscall to system

  la   $a0, endl      # puts the address of the string endl into a0
  addi $v0, $0, 4     # puts 4 into v0 saying we are printing a string
  syscall


  addi $v0,$0, 10
  syscall
