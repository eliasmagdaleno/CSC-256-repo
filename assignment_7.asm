#	Project Description: compute a polynomial x^4 + x^3 + 1 by passing arguements to the function
#	Name: Elias Magdaleno
#	Date: 4/24/2023

.data
newline: .asciiz "\n" 
.text	



main: 
	li 	$t0,2	#int i =2 -> $t0
	li 	$t1,4	# end value for i
	
loop: 	blt 	$t0,$t1,exit	# i > 4
	move 	$a0,$t0		# arg = i
	jal 	poly		# call the poly function
	sw 	$v0,($t0)	# result
	lw 	$a0,($t0)	# load result
	move	$a0,$t0
	li 	$v0,1		# print integer
	
	#la	$a0,($t0)
	syscall
	li	$v0,4
	la	$a0,newline
	syscall 
	addi 	$t0,$t0,1  	# i++
	
	j 	loop
	
exit:   li	 $v0,10
	syscall


poly: 
	addi	$sp,$sp,-12
	sw 	$s1,($sp)	# save value of $s1
	sw	$s0,4($sp)	# save value of $s0
	sw	$ra,8($sp)
	add	$s0,$a0,$0
	li 	$a1,4		# set power to 4
	
	jal	pow		# call pow with power of 4
	
	move	$s1,$v0		# store result in temp1
	li	$a1,3		# set power to 3
	
	jal 	pow		# call pow with power of 3
	
	add	$t0,$v0,$s1	# result = temp1 + result
	addi	$v0,$v0,1	# result = result + 1
	lw	$ra,8($sp)
	lw 	$s0,4($sp)	# restore $s0 value
	lw	$s1,($sp)	# restore $s1 value
	addi 	$sp,$sp,12
	jr 	$ra

pow: 
	li 	$v0,1 		# int product = 1
	li	$t0,0		# int i = 0
	bge	$t0,$a1,exit2 	# i >= arg1
	powloop: 
		mul	$v0,$a0,$v0 	#product *= arg00
		addi	$t0,$t0,1	#i++
		blt	$t0,$a1,powloop
	exit2: 	
		jr 	$ra
	

