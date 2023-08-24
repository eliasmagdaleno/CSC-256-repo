#	CSC 256 Assignment 6_1
#	Name: Elias Magdaleno
# 	Date: 3/8/2023
# 	Description: 	User enters x. Program subtracts 5 from x repeatedly,
#		until x <= 0, and prints x.
#
# #include <iostream.h>
# int main(void)
# {
#   int x;
#   
#   cin >> x; // read an int, store in x
#   while (x > 0)
#     x = x - 5;
#   
#   cout << x << endl;
#   
# }

# x	$s0

	.data
endl:	.asciiz	"\n"

	
	.text
        li 	$s0,0 		# int x = 0 
      
main:   la 	$v0,5 
        syscall
        move 	$s0,$v0 	# x = input
        ble 	$s0,0,exit      # while x <= 0

loop:   subi 	$s0,$s0,1 	# x = x-1
	bgt  	$s0,0,loop 	# x > 0
      
      

exit:   li 	$v0,1 		#print int
	move 	$a0,$s0 	# cout << x
	syscall
	la 	$a0,endl 	# cout << endl
	li 	$v0,4 		#print string
	syscall
	
