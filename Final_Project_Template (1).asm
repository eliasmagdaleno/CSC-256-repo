.data
x:      .word   0:4     # x-coordinates of 4 robots
y:      .word   0:4     # y-coordinates of 4 robots

str1:   .asciiz "Your coordinates: 25 25\n"
str2:   .asciiz "Enter move (1 for +x, -1 for -x, 2 for + y, -2 for -y):"
str3:   .asciiz "Your coordinates: "
sp:     .asciiz " "
endl:   .asciiz "\n"
str4:   .asciiz "Robot at "
str5:   .asciiz "AAAARRRRGHHHHH... Game over\n"

.text
main:
    li  $s0, 0          # i = 0
    li  $s1, 25         # myX = 25
    li  $s2, 25         # myY = 25
    li  $s3, 1          # status = 1

    la  $s4, x          # ptrX = &x[0]
    la  $s5, y          # ptrY = &y[0]

    sw  $0, ($s4)       # x[0] = 0; y[0] = 0;
    sw  $0, ($s5)
    sw  $0, 4($s4)      # x[1] = 0; y[1] = 50;
    li  $t0, 50
    sw  $t0, 4($s5)
    sw  $t0, 8($s4)     # x[2] = 50; y[2] = 0;
    sw  $0, 8($s5)
    sw  $t0, 12($s4)    # x[3] = 50; y[3] = 50;
    sw  $t0, 12($s5)

    la  $a0, str1      # cout << "Your coordinates: 25 25\n";
    li  $v0, 4
    syscall

while_loop:
    bne $s3, 1, game_over # while (status == 1)

    la  $a0, str2      # cout << "Enter move (1 for +x,
    li  $v0, 4         #        -1 for -x, 2 for + y, -2 for -y):";
    syscall

    li  $v0, 5         # cin >> move;
    syscall
    move $s6, $v0      # move = $v0

    beq $s6, 1, inc_myX # if (move == 1)
    beq $s6, -1, dec_myX # else if (move == -1)
    beq $s6, 2, inc_myY # else if (move == 2)
    beq $s6, -2, dec_myY # else if (move == -2)

inc_myX:
    addi $s1, $s1, 1   # myX++;
    b modify_robots

dec_myX:
    addi $s1, $s1, -1  # myX--;
    b modify_robots

inc_myY:
    addi $s2, $s2, 1   # myY++;
    b modify_robots

dec_myY:
    addi $s2, $s2, -1  # myY--;
    b modify_robots

modify_robots:
    move $a0, $s4      # arg0 = &x[0]
    move $a1, $s5      # arg1 = &y[0]
    move $a2, $s1      # arg2 = myX
    move $a3, $s2      # arg3 = myY
    jal moveRobots     # status = moveRobots(&x[0], &y[0], myX, myY)

    la  $a0, str3      # cout << "Your coordinates: "
    li  $v0, 4
    syscall

    move $a1, $s1      # cout << myX
    li   $v0, 1
    syscall

    la  $a0, sp        # cout << " "
    li  $v0, 4
    syscall

    move $a1, $s2      # cout << myY
    li   $v0, 1
    syscall

    la  $a0, endl      # cout << endl;
    li  $v0, 4
    syscall

    li  $s0, 0         # i = 0
    move $s4, $s6      # ptrX = &x[0]
    move $s5, $s6      # ptrY = &y[0]

print_robots:
    beq $s0, 4, while_loop_end # if (i == 4)
    la  $a0, str4      # cout << "Robot at "
    li  $v0, 4
    syscall

    lw  $a1, ($s4)     # cout << x[i]
    li  $v0, 1
    syscall

    la  $a0, sp        # cout << " "
    li  $v0, 4
    syscall

    lw  $a1, ($s5)     # cout << y[i]
    li  $v0, 1
    syscall

    la  $a0, endl      # cout << endl;
    li  $v0, 4
    syscall

    addi $s0, $s0, 1   # i++
    addi $s4, $s4, 4   # ptrX++
    addi $s5, $s5, 4   # ptrY++
    b print_robots

while_loop_end:
    la  $a0, str5      # cout << "AAAARRRRGHHHHH... Game over\n";
    li  $v0, 4
    syscall

    j  game_over

moveRobots:
    move $s7, $ra      # save return address

    li   $t1, 1        # alive = 1
    move $t2, $a0      # ptrX = arg0
    move $t3, $a1      # ptrY = arg1

moveRobots_loop:
    beq  $s0, 4, moveRobots_end # if (i == 4)

    lw   $t4, ($t2)    # temp = *ptrX
    jal  getNew        # result = getNew(temp, arg2)
    move $t4, $v0      # temp = result
    sw   $t4, ($t2)    # *ptrX = temp

    lw   $t4, ($t3)    # temp = *ptrY
    jal  getNew        # result = getNew(temp, arg3)
    move $t4, $v0      # temp = result
    sw   $t4, ($t3)    # *ptrY = temp

    lw   $t4, ($t2)    # temp = *ptrX
    beq  $t4, $a2, caught_by_robot # if (temp == arg2)
    lw   $t4, ($t3)    # temp = *ptrY
    beq  $t4, $a3, caught_by_robot # if (temp == arg3)

    addi $s0, $s0, 1   # i++
    addi $t2, $t2, 4   # ptrX++
    addi $t3, $t3, 4   # ptrY++
    j moveRobots_loop

caught_by_robot:
    li   $t1, 0        # alive = 0
    j moveRobots_end

moveRobots_end:
    move $v0, $t1      # return alive
    move $ra, $s7      # restore return address
    jr   $ra

getNew:
    move $s7, $ra      # save return address

    sub  $t4, $a0, $a1 # temp = arg0 - arg1
    li   $t5, 10       # $t5 = 10

    bge  $t4, $t5, getNew_case1 # if (temp >= 10)
    bgtz $t4, getNew_case2    # else if (temp > 0)
    beqz $t4, getNew_case3    # else if (temp == 0)
    bltz $t4, getNew_case4    # else if (temp < 0)
    ble  $t4, -10, getNew_case5 # else if (temp <= -10)

getNew_case1:
    subi $v0, $a0, 10  # result = arg0 - 10
    j getNew_end

getNew_case2:
    subi $v0, $a0, 1   # result = arg0 - 1
    j getNew_end

getNew_case3:
    move $v0, $a0      # result = arg0
    j getNew_end

getNew_case4:
    addi $v0, $a0, 1   # result = arg0 + 1
    j getNew_end

getNew_case5:
    addi $v0, $a0, 10  # result = arg0 + 10
    j getNew_end

getNew_end:
    move $ra, $s7      # restore return address
    jr   $ra

game_over:
    li  $v0, 10        # exit
    syscall
