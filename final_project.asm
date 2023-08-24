# Name: Elias Magdaleno
# Project: Ancient Robot Game
#

	.data
x:	.word	0:4	# x-coordinates of 4 robots
y:	.word	0:4	# y-coordinates of 4 robots

str1:	.asciiz	"Your coordinates: 25 25\n"
str2:	.asciiz	"Enter move (1 for +x, -1 for -x, 2 for + y, -2 for -y):"
str3:	.asciiz	"Your coordinates: "
sp:	.asciiz	" "
endl:	.asciiz	"\n"
str4:	.asciiz	"Robot at "
str5:	.asciiz	"AAAARRRRGHHHHH... Game over\n"

#i	$s0
#myX	$s1
#myY	$s2
#move	$s3
#status	$s4
#temp,pointers	$s5,$s6
	.text
#	.globl	inc
#	.globl	getNew

main:
	li	$s1, 25        # myX = 25
	li	$s2, 25        # myY = 25
	li	$s4, 1         # status = 1

	la	$s5, x         # pointers = &x[0]
	la	$s6, y         # pointers = &y[0]

	sw	$0, ($s5)      # x[0] = 0; y[0] = 0;
	sw	$0, ($s6)
	sw	$0, 4($s5)     # x[1] = 0; y[1] = 50;
	li	$s7, 50
	sw	$s7, 4($s6)
	sw	$s7, 8($s5)    # x[2] = 50; y[2] = 0;
	sw	$0, 8($s6)
	sw	$s7, 12($s5)   # x[3] = 50; y[3] = 50;
	sw	$s7, 12($s6)

	la	$a0, str1      # cout << "Your coordinates: 25 25\n";
	li	$v0, 4
	syscall

	bne	$s4, 1, main_exitw  # while (status == 1) {
main_while:
	la	$a0, str2      # cout << "Enter move (1 for +x, -1 for -x, 2 for + y, -2 for -y):";
	li	$v0, 4
	syscall

	li	$v0, 5         # cin >> move;
	syscall
	move	$s3, $v0

	bne	$s3, 1, main_else1  # if (move == 1)
	add	$s1, $s1, 1    # myX++;
	b	main_exitif
main_else1:
	bne	$s3, -1, main_else2  # else if (move == -1)
	add	$s1, $s1, -1   # myX--;
	b	main_exitif
main_else2:
	bne	$s3, 2, main_else3  # else if (move == 2)
	add	$s2, $s2, 1    # myY++;
	b	main_exitif
main_else3:
	bne	$s3, -2, main_exitif  # else if (move == -2)
	add	$s2, $s2, -1   # myY--;

main_exitif:
	la	$a0, x         # status = moveRobots(&x[0], &y[0], myX, myY);
	la	$a1, y
	move	$a2, $s1
	move	$a3, $s2
	jal	moveRobots
	move	$s4, $v0

	la	$a0, str3      # cout << "Your coordinates: " << myX
	li	$v0, 4
	syscall
	move	$a0, $s1
	li	$v0, 1
	syscall
	la	$a0, sp
	li	$v0, 4
	syscall
	move	$a0, $s2
	li	$v0, 1
	syscall
	la	$a0, endl
	li	$v0, 4
	syscall

	la	$s5, x         # pointers = &x[0]
	la	$s6, y         # pointers = &y[0]
	li	$s0, 0         # i = 0
main_for:
	la	$a0, str4      # cout << "Robot at " << x[i] << " "
	li	$v0, 4
	syscall
	lw	$a0, ($s5)
	li	$v0, 1
	syscall
	la	$a0, sp
	li	$v0, 4
	syscall
	lw	$a0, ($s6)
	li	$v0, 1
	syscall
	la	$a0, endl
	li	$v0, 4
	syscall
	add	$s5, $s5, 4   # ptrX++;
	add	$s6, $s6, 4   # ptrY++;
	add	$s0, $s0, 1   # i++;
	blt	$s0, 4, main_for

	beq	$s4, 1, main_while  # }
main_exitw:
	la	$a0, str5      # cout << "AAAARRRRGHHHHH... Game over\n";
	li	$v0, 4
	syscall
	li	$v0, 10        # exit
	syscall

	# int moveRobots(int *arg0, int *arg1, int arg2, int arg3)
	#
	# arg0     base address of array of x-coordinates
	# arg1     base address of array of y-coordinates
	# arg2     x-coordinate of human (copy in $s2)
	# arg3     y-coordinate of human (copy in $s3)
	# ptrX
	# ptrY
	# i
	# alive
	# temp
	#
	# moveRobots() calls getNew() to obtain the new coordinates
	# of each robot. The position of each robot is updated.

moveRobots:
	# alive = 1;
	# ptrX = arg0;
	# ptrY = arg1;
	# for (i=0; i<4; i++) {
	#     *ptrX = getNew(*ptrX, arg2);
	#     *ptrY = getNew(*ptrY, arg3);
	#     if ((*ptrX == arg2) && (*ptrY == arg3)) {
	#         alive = 0;
	#         break;
	#     }
	#     ptrX++;
	#     ptrY++;
	# }
	# return alive;

	li	$s4, 1         # alive = 1
	move	$s5, $a0      # ptrX = arg0
	move	$s6, $a1      # ptrY = arg1
	li	$s0, 0         # i = 0
	move	$s7, $a2      # temp = arg2

	moveRobots_loop:
	lw	$t0, ($s5)     # *ptrX
	move	$a0, $t0       # arg0 = *ptrX
	move	$a1, $s7       # arg1 = arg2
	jal	getNew         # getNew(*ptrX, arg2)
	sw	$v0, ($s5)     # *ptrX = result

	lw	$t0, ($s6)     # *ptrY
	move	$a0, $t0       # arg0 = *ptrY
	move	$a1, $a3       # arg1 = arg3
	jal	getNew         # getNew(*ptrY, arg3)
	sw	$v0, ($s6)     # *ptrY = result

	lw	$t0, ($s5)     # *ptrX
	move	$t1, $s7      # arg0 = *ptrX
	beq	$t0, $t1, moveRobots_done  # if (*ptrX == arg2 && *ptrY == arg3) -> break

	addi	$s5, $s5, 4   # ptrX++
	addi	$s6, $s6, 4   # ptrY++
	addi	$s0, $s0, 1   # i++
	blt	$s0, 4, moveRobots_loop  # for (i=0; i<4; i++)

	move	$v0, $s4      # return alive

	moveRobots_done:
	li	$v0, 0         # alive = 0
	move	$s4, $v0
	move	$v0, $s4      # return alive

	# int getNew(int arg0, int arg1)
	#
	# arg0     one coordinate of robot
	# arg1     one coordinate of human
	# temp
	# result
	#
	# Returns new coordinate of robot. If the absolute difference between
	# the robot coordinate and human coordinate is >=10, the robot
	# coordinate moves 10 units closer to the human coordinate.
	# If the absolute difference is < 10, the robot coordinate
	# moves 1 unit closer to the human coordinate.

getNew:
	# temp = arg0 - arg1;
	# if (temp >= 10)
	#     result = arg0 - 10;
	# else if (temp > 0)
	#     result = arg0 - 1;
	# else if (temp == 0)
	#     result = arg0;
	# else if (temp > -10)
	#     result = arg0 + 1;
	# else if (temp <= -10)
	#     result = arg0 + 10;
	# return result

	sub	$t0, $a0, $a1  # temp = arg0 - arg1

	blt	$t0, 0, getNew_neg
	bgt	$t0, 0, getNew_pos
	beq	$t0, 0, getNew_zero

getNew_pos:
	li	$t1, 1         # result = arg0 - 1
	sub	$v0, $a0, $t1
	jr	$ra

getNew_zero:
	move	$v0, $a0      # result = arg0
	jr	$ra

getNew_neg:
	bge	$t0, -10, getNew_small_neg
	li	$t1, 10        # result = arg0 + 10
	add	$v0, $a0, $t1
	jr	$ra

getNew_small_neg:
	li	$t1, 1         # result = arg0 + 1
	add	$v0, $a0, $t1
	jr	$ra
