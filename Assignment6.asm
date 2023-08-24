#	CSC 256 Assignment 6
#	Name: Elias Magdaleno
#	Date: 3/13/2023
#	Description: Creates an integer array and inserts integers that correspond to its index

.data

x: .space 24     # reserve 6 words in array

.text
main:
    
    li 		$t0, 0        	# $t0 -> i = 0
    la 		$t1, x        	# $t1 = address of x[0]
    bge 	$t0, 6, exit	# if i >= 6

    
    loop:
       
        	sw 	$t0, ($t1)	# store i in x[i]

        	addi 	$t0, $t0, 1     # i++
        	addi 	$t1, $t1, 4     # increment by 4 bytes 
        
    cont: 	blt 	$t0,6,loop	# if i < 6 

  
    exit:
   	 	li 	$v0, 10		# exit program
    		syscall