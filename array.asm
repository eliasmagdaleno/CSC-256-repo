.data
#x[]={0,0,0,1,2}
x: .word 0:3
   .word 4
   .word 5
   # what is the memory address 
   # for x[0],x[1],...x[4]
   #overwrite x[]=[4,0,0,1,2]
   .text
   li $t1,4
   # x[0]=4
   # sw $t1,x
   # &x[0]= 0x10010004
   li $t0,0x10010004
   sw $t1,($t0)
   # store word, from register to memory
   # from register $t1, to memory addr in $t0