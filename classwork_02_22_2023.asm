
.text 
	li 	$s0,1		# num -> $s1
	li 	$s2,2		# max -> $s2
	bne 	$s0,$s2,l1	# num != max
	li 	$s1,1		# flag = 1
	j 	exit
	
l1: 	beq 	$s0,0,l2	# num == 0
    	li 	$s1,-1		# flag = -1
	j exit
	
l2: 	li 	$s1,0		# flag = 0
	j exit
	
exit: