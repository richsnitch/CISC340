# Hayden Richards
# CISC 340
# Assignment 4
	.data
prmpt1:	.asciiz "Enter a positive integer value: "
prmpt2: .asciiz "Sawin number for "
prmpt3:	.asciiz "Computing Sawin Numbers: "
comma: 	.asciiz	","
newline:.asciiz "\n"
is:	.asciiz " is "
result: .word 0
	.text
main:
	# print prompt
	la $a0, prmpt1
	li $v0, 4
	syscall
	# read input for first int
	li $v0, 5
	syscall
	# move user input into $t0
	move $t0, $v0
	# print prompt
	la $a0, prmpt1
	li $v0, 4
	syscall
	# read input for second int
	li $v0, 5
	syscall
	# move user input into $t1
	move $t1, $v0
	# store result in $t2
	la $a0, result
	lw $t2, 0($a0)
	# call sawinNum
	move $a0, $t0
	move $a1, $t1

	jal sawinNum
	move $t3, $v0
	# Print "Sawin number for "
	la $a0, prmpt2
	li $v0, 4
	syscall
	# print first parameter
	move $a0, $t0
	li $v0, 1
	syscall
	# print comma
	la $a0, comma
	li $v0, 4
	syscall
	# print second paramter
	move $a0, $t1
	li $v0, 1
	syscall
	# print "is"
	la $a0, is
	li $v0, 4
	syscall
	# print result
	move $a0, $t3
	li $v0, 1
	syscall
	 
	# exit
	li $v0, 10
	syscall

sawinNum:
	move $s0, $a0 # first parameter
	move $s1, $a1 # second paramter
	move $v0, $s2 # result
	
	# create stack frame
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $s2, 0($sp)
	
	# function body
	
	# print "Computing sawin numbers"
	la $a0, prmpt3
	li $v0, 4
	syscall
	# print out the first parameter
	move $a0, $s0
	li $v0, 1
	syscall
	# print comma
	la $a0, comma
	li $v0, 4
	syscall
	# copy a1 into a0 and print out that parameter
	move $a0, $s1
	li $v0, 1
	syscall
	# print newline character
	la $a0, newline
	li $v0, 4
	syscall
	
	# move the correct parameter back into a0
	move $a0, $s0

if:	
	# if x == 0, result = y + 1 and jump to the end
	bne $a0, $zero, elseIf
		addi $v0, $s1, 1
		move $s2, $v0 # store result in s2
		j end
elseIf:	
	# if y == 0, result = sawinNum(x-1, 1) and jump to the end
	bne $a1, $zero, else
		# subtract 1 from a0 and have a1 = 1
		subi $a0, $s0, 1 # x = x - 1
		addi $a1, $zero, 1 # y = 1
		jal sawinNum
		move $s2, $v0 # move result into s2
		j end
	
else:
	subi $a1, $s1, 1 # y = y -1
	jal sawinNum
	move $s2, $v0 # move result into s2
	move $a1, $s2 # move result into second parameter
	subi $a0, $s0, 1 # x = x - 1
	jal sawinNum
	

end:
	# retire stack frame
	lw $s2, 0($sp)
	lw $s1, 4($sp)
	lw $s0, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra
