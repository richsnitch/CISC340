# Hayden Richards
# CISC 340
# Homework 5
	.data
data:	.float 9.24, 1.15, 3.91, -2.30, 7.43, 5.79, -6.83, 3.14
size:	.word 8
prmpt1:	.asciiz "How many should be averaged? "
prmpt2:	.asciiz "The average is "

	.text
main:
	jal averagePositive
	
	# print prmpt2
	la $a0, prmpt2
	li $v0, 4
	syscall
	
	# load average into a0 and print the result
	mfc1, $a0, $f0
	li $v0, 2
	syscall
	
	li $v0, 10
	syscall

averagePositive:
	# Function body
	
	# print prmpt1
	la $a0, prmpt1
	li $v0, 4
	syscall
	
	# user input
	li $v0, 5
	syscall
	
	# load address and word into $s0
	la $s0, size
	lw $s0, 0($s0)
	
	la $a0, data # load address of the array into a0
	move $a1, $v0 # move user input into the second parameter, a1
	
	add $t0, $zero, $zero # numPos = 0 
	
	add $t1, $zero, $zero # initialize a counter variable
	
	slt $t2, $a1, $s0 # if n > size, t2 = 0 else t2 = 1

	# if n > size, set n = size (if t2 = 0, set a1 = s0)
	bne $t2, $zero, skip
		add $a1, $zero, $s0
		

skip:
	mtc1 $zero, $f12 # sum = 0.0 (set f21 = 0)
	mtc1 $zero, $f16 # set 0 = f16 for comparison on line
	
avgPosLoop:
	lwc1 $f17, 0($a0) # load array[i] into f17
	c.lt.s $f17, $f16 # if $f17 < $f16, flag = 1 else flag = 0
	bc1t skipAdd
		add.s $f12, $f12, $f17 # sum = sum + nums[i]
		addi $t0, $t0, 1 # numPos = numPos + 1
skipAdd:
	addi $t1, $t1, 1 # add 1 to the counter
	beq $t1, $a1, avgLoopEnd # if the counter is equal to the user inputted size, end the loop
		addi $a0, $a0, 4 # add 4 to the address of the array
		j avgPosLoop
	
avgLoopEnd:
	mtc1 $t0, $f16 # move numPos to f16
	cvt.s.w $f16, $f16 # convert f16 from a word to a single precision
	div.s $f12, $f12, $f16 # find the average
	
	jr $ra


