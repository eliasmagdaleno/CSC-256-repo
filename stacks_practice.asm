.text
	li 	$s1,1
	jal 	l1  	#1) jump to l1
			#2) store MA of next line to $ra
	li 	$s2,1
	li 	$v0,10
	syscall

l1: 
	li 	$s3,1
	move 	$t0,$ra
	jal	l2
	
	li 	$s5,1
	jr 	$ra	

l2:	li 	$s4,1
	jr	$ra