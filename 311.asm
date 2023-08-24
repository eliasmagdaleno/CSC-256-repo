 #.data
 #int x[3]={3,4,5};
 #.text
 # y = x[0]+x[1];
 #cout << y;
 # y --->$s1
 .data
 x_0: .word 3
 x_1:   .word 4
    .word 5
 .text
 #y=x[0]+x[1];
 
 #if you want to do operations on memory
 #you have to load it into register first
 # x[0]-->$t1
 # x[1]-->$t2
 lw $t1,x_0 #load x[0] in $t1
 lw $t3,x_1 #load x[1] in $t2
 add $s1,$t1,$t2 # y = x[0]+x[1];
 #cout<<y;
 
 li $v0,1
 move $a0,$s1
 syscall