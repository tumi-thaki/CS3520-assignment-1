#===============================================================================
#
#AUTHOR: Tumisang Thaki
#CONTACT: tumiethaki01@gamil.com
#FUNCTION: This program finds and prints the first 10 reversible square primes
#DATE: October 2022
#
#================================================================================
#
#int Reverse(int num)
#{
#	int no = num, reverse = 0, remainder;
#	while (no != 0)
#	{
#		remainder = no % 10;
#		reverse = reverse * 10 + remainder;
#		no /= 10;
#	}
#	return reverse;
#}
#int palindrome (int number)
#{
#	int reverse = Reverse (number);
#	if (reverse == number)
#	{
#		return 1;
#	}
#	else
#	{
#		return 0;
#	}
#}
#int isPrime(int num)
#{
#	int m = num/2;
#	int flag = 0;
#	for(int i = 2 ; i <= m; i++)
#	{
#		if ( (num % i) == 0)
#		{
#			flag = 1;
#			break;
#		}
#	}
#	if (flag == 1)
#	{
#		return 0;
#	}
#	else
#	{
#		return 1;
#	}
#}
#
#int main()
#{
#	printf ( "W E L C O M E \nPrinting the first 10 reversible prime squares: \n\n");
#	int num = 0, count = 0;
#	while (count < 10)
#	{
#		//check if the number is palindrome
#		if (palindrome(num) == 1)
#		{
#			num++;
#		}
#		else
#		{
#			// check if the number is prime
#			if (isPrime(num) == 1)
#			{
#				int reverse = Reverse(num); 
#				// check if the reverse if prime
#				if(isPrime(reverse) == 1)
#				{
#					int squareNum = num * num;
#					int squareReverse = reverse * reverse;
#					int reverseSquareNum = Reverse(squareNum);
#					//check if the reverse squared if equal to the reverse of the original number squared 
#					if ( reverseSquareNum == squareReverse)
#					{
#						// print on the screen and increment the count if true
#						count++;
#						printf("%d \n", squareNum);
#					}
#					num++;
#				}
#				else
#				{
#					num++;
#				}
#			}
#			else
#			{
#				num++;
#			}
#		}
#	}
#	printf("\nD O N E  P R I N T I N G");
#	return 0;
#}




.data
	msg1: .asciiz "\nW E L C O M E \nPrinting the first 10 reversible prime squares: \n\n"
	msg2: .asciiz "\nD O N E  P R I N T I N G"
	msg3: .asciiz "\n"
	msg4: .asciiz "\n counter incremented"
	msg5: .asciiz "\n successful"
.text
.globl main

main:
	
	li $s0, 0 # $s0 = num = 0
	li $t0, 0 # $t0 = count = 0
	
	
	li $v0, 4
	la $a0, msg1
	syscall
	

	while:
		#addiu $sp, $sp, -8
		#sw $s0, 0($sp)
		#sw $t0, 4($sp)
		
		move $a0, $s0           #load num as parameter in $a0
		bgt $t0, 9, endWhile
		jal palindrome
		add $s1, $zero, $v0      # $s1:results of palindrome 
		beq $s1, 1, else         # if $s1 == 1 branch to else 
		jal isPrime
		add $s2, $zero, $v0      # $s2 : return from isPrime
		beq $s2, 0, else         #if $s2 == 0 branch to else
		jal reverse
		add $t1, $zero, $v0      #$t1:reverse(num)
		move $a0, $t1            #parameter $a0:reverse(num)
		jal isPrime
		beq $v0, 0, else
		mulo $t2, $s0, $s0        # $t2 : squareNum
		mulo $t3, $t1, $t1        # $t3 : squareReverse
		move $a0, $t2               # $a0 : squareNum
		jal reverse
		add $t4, $zero, $v0      # $t4 : reverse(squareNum)
		bne $t4, $t3, else
		li $v0, 1
		move $a0, $t2           # load squareNum for printing
		syscall
		#lw $t0, 4($sp)
		addi $t0, $t0, 1
		add $s0, $s0, 1
		
		li $v0, 4
		la $a0, msg3          
		syscall
		
		j while
		
	else:
	
		#lw $s0, 0($sp)
		#lw $t0, 4($sp)
		#addiu $sp, $sp, 8
		#li $v0, 4
		#la $a0, msg4
		#syscall
		add $s0, $s0, 1
		j while 
		
	endWhile:
		#lw $s0, 0($sp)
		#lw $t0, 4($sp)
		#addiu $sp, $sp, 8
		li $v0, 4
		la $a0, msg2
		syscall
		
		j exit
	
	exit:
		li $v0, 10
		syscall
	
		
reverse:
	#computes and returns the reverse of the argument $a0
	addiu $sp, $sp, -20         
	
	li $t1, 0                     # reverse = 0
	sw $s0, 0($sp)                # load num on to stack to avoid changes
	sw $t0, 4($sp)
	sw $ra, 8($sp)
	sw $t1, 12($sp)
	sw $t2, 16($sp)
	
	reverseLoop:
		beq $a0, 0, close
		remu $t2, $a0, 10       #$t2 : remainder
		mul $t1, $t1, 10    
		add $t1, $t1, $t2
		div $a0, $a0, 10
		j reverseLoop
	close:
		add $v0, $zero, $t1
	lw $a0, 0($sp)                # $a0 : num
	lw $t0, 4($sp)                #$t0 : count
	lw $ra, 8($sp)
	lw $t1, 12($sp)  # restore the values in main
	lw $t2, 16($sp)
	addiu $sp, $sp, 20
	
	jr $ra

	
palindrome:
	#returns 1 if the argument $a0 is  palindrome
	addiu $sp, $sp, -8
	sw $ra, 0($sp)
	sw $t1, 4($sp)
	jal reverse
	add $t1, $zero, $v0  # $t1 : Reverse(num) = reverse
	seq  $v0, $t1, $a0
	lw $ra, 0($sp)
	lw $t1, 4($sp)
	addiu $sp, $sp, 8
	
	jr $ra


isPrime:
	#returns 1 if the argument $a0 is  prime
	addiu $sp, $sp, -4
	sw $ra, 0($sp) 
	div $t3, $a0, 2                      # $t3 = m = num/2
	addi $t4, $zero, 0                   # $t4 = flag = 0
	addi $t5, $zero, 2                   # $t5 = i = 2
	branch:
		bgt $t5, $t3, leaveFor     # if $t5 > $t3
		remu $t6, $a0, $t5		         # $t6:remainder  i.e num%i
		addi $t5, $t5, 1                 #incrementing the counter i i.e i++
		beqz $t6, conditional          # if ( (num % i) == 0)
		j branch
	conditional:
		li $t4, 1
		j leaveFor
	leaveFor:
		beq $t4, 1, return
		li $v0, 1
		j functionEnd
	return:
		li $v0, 0
	
	functionEnd:
		lw $ra, 0($sp)
		addiu $sp, $sp, 4
		jr $ra