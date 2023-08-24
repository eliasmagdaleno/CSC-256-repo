#	CSC 256 Assignment 4
#	Name: Elias Magdaleno
# 	Date: 2/27/2023
#	Description: Takes two inputs and outputs the larger value
#

.data
str1:.asciiz "please input the value of variable a: "
str2:.asciiz "please input the value of variable b: "
str3:.asciiz "the larger value of a,b is "
.text

li 	$s0,0 		# a --> $s0
li 	$s1,0		# b -->  $s1
li 	$s2,0		# temp --> $s2

main:
	la 	$a0,str1	# cout << str1
	li 	$v0,4 		# print string
	syscall 
	
	li 	$v0,5		# input an int
	syscall
	
	move 	$s0,$v0 	# a ---> $s0
	la 	$a0,str2	# cout << str2
	li 	$v0,4
	syscall
	
	li 	$v0,5		# input an int
	syscall
	
	move 	$s1,$v0		# b ---> $s1
	la 	$a0,str3	# cout << str3
	li 	$v0,4		# print string
	syscall	
	
	ble	$s0,$s1, true	# if a <= b
	j 	No		# else go to No
	
true: 	move 	$s2,$s1		# temp = b
        li 	$v0,1		# print int
        move 	$a0,$s2		# cout << temp
        syscall
        j 	exit
       
false: 	move 	$s2,$s0		# temp = a
	li 	$v0,1		# print int
	move 	$a0,$s2		# cout << temp
	syscall	
        j exit
        
exit: 
       
	
	
