# memory
# int x= 4 and y = -1, x and y is in memory
# char z=0xab, char w =0x34
.data
	# int is 32 bit of the data, which is 1 word
x: .word  4  #x 4 memory address, 0x0000000
y: .word  -1 #y
z: .byte 0xab #z 1 memory address 0x00000008
w: .byte 0x34 #w 1 memory address 0x00000009
.text