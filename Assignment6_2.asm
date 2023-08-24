#	CSC 256 Assignment 6_2
#	Name: Elias Magdaleno
# 	Date: 3/8/2023
# 	Description:  User enters count. Program performs xor and shift right
#               operations, for count iterations. 
#               Note: spim doesn't support printing integers in hex
#               (though we can write a utility function!) Look at
#               $s1 in spim to trace the operations.

# count	$s0
# x	$s1
# i	$s2

	.data
endl:   .asciiz "\n"
	.text
	
main:	li 	$s0,0		# int count = 0
	li	$s1,0x89abcdef	# int x = 0x89abcdef;
	li 	$s2,0 		# int i = 0
	li      $s3,0x00010002 	# int temp = 0x00010002
	li 	$v0,5 		# cin >> count
	syscall
	
	move 	$s0,$v0 	# count = input
	bge 	$s2,$s0,cont    # i >= count
	
loop: 
      addi 	$s2,$s2,1	#i++  
      xor 	$s1,$s1,$s3	# x = x ^ 0x00010002
      addi 	$v0,$0,1	#print integer	
      addi 	$a0,$s1,0
      syscall
      
      la 	$a0,endl 	# cout << endl
      li 	$v0,4 		# print string
      syscall
      
      sra 	$s1,$s1,1 	#shift right by 1 bit
       
      
cont: blt $s2,$s0,loop		# i < count

exit: addi $v0,$0,10
      syscall
      
      
      

