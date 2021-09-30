###########################################################
# Assignment #: 5
# Name: Augustus Crosby 
# ASU email: ancrosby@asu.edu
# Course: CSE230, MW 3:05pm
# Description: Asks for inputs and prints updated arrays.
#		Demonstration for using arrays, loops, jumps.
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM
		.data
numbers_len:	.word 12 
numbers:	.word -5, 24, -27, 3, 46, -7, 11, 24, -9, 14, -18, 12
line1:		.asciiz "Enter a starting index:\n"
line2:		.asciiz "Enter an ending index:\n"
line3:		.asciiz "Enter an integer:\n"
line4:		.asciiz "Index out of bounds.\n"
line5:		.asciiz "Result Array Content:"
line6:		.asciiz "\n"

#program code is contained below under .text

		.text 
		.globl main	# define a global function main

main:
	la $t0, numbers_len	# $t0 = address of numbers_len 
	la $t1, numbers		# $t1 = address of numbers (start @ -5)

	li $v0, 4		# load 4 to print string
	la $a0, line1		# load address of line1
	syscall			# print_string()

	li $v0, 5		# load 5 to read int
	syscall 		# read_int()
	move $a1, $v0		# $a1 = startIndex

	li $v0, 4		# load 4 to print string
	la $a0, line2		# load address of line2
	syscall			# print_string()

	li $v0, 5		# load 5 to read int
	syscall 		# read_int()
	move $a2, $v0		# $a2 = endIndex

	li $v0, 4		# load 4 to print string
	la $a0, line3		# load address of line3
	syscall			# print_string()

	li $v0, 5		# load 5 to read int
	syscall 		# read_int()
	move $a3, $v0		# $a3 = num1	

	#if startIndex < 0 || endIndex > 11
	blt $a1, $zero, OutofBounds	#branch if $a1 is less than $zero
	li $t3, 11		# $t3 = 11
	bgt $a2, $t3, OutofBounds	#branch if $a2 is greater than 11 ($t3)
	
	move $s0, $a1		# $s0 = $a1 (startIndex)
Loop1:
	blt $a2, $s0, Label1	# branch if $a2 (endIndex) is less than j
	sll $t4, $s0, 2		# $t4 = j*4
	add $t5, $t1, $t4	# $t5 = address of array's start + j*4
	lw $t6, 0($t5)		# load value at address $t5

	#if numbers[j] > num1
	bgt $t6, $a3, Label2	# branch if $t6 (numbers[j]) is greater than $a3 (num1)

Label3:
	addi $s0, $s0, 1	# j = j + 1
	j Loop1

Label1:
	li $v0, 4		# load 4 to print string
	la $a0, line5		# load address of line5
	syscall			# print_string()

	li $s1, 0		# j = 0
	lw $t8, 0($t0)		# $t8 = value at $t0 (12)
	move $t2, $t1		# $t2 = $t1
Loop2:
	bge $s1, $t8, end	# branch if j is greater than or equal to 12
	li $v0, 4		# load 4 to print string
	la $a0, line6		# load address of line6
	syscall
	li $v0, 1		# load 1 to print int
	lw $a0, 0($t2)		# $a0 = value of numbers
	syscall			# print_int()
	addi $t2, $t2, 4	# $t2 = $t2 + 4
	addi $s1, $s1, 1	# j = j + 1
	j Loop2

end:
	jr $ra

OutofBounds:
	li $v0, 4		# load 4 to print string
	la $a0, line4		# load address of line4
	syscall			# print_string()
	j Label1

Label2: 
	add $t7, $t6, $a3	# $t7 =  numbers[j] + num1
	sw $t7, 0($t5)		# numbers[j] = $t7
	j Label3
	