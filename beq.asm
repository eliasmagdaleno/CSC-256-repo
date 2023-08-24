#
#
#
#

.text 
	li $s0,1
	li $s1,2
	beq $s0,$s1,label
	li $s1,3
label:  li $s2,4