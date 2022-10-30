/*	
AUTHOR: Tumisang Thaki
CONTACT: tumiethaki01@gamil.com
FUNCTION: This program finds and prints the first 10 reversible square primes
DATE: October 2022
*/

#include <stdio.h>

int Reverse(int num)
{
	//this function returns the reverse of the number
	int no = num, reverse = 0, remainder;
	while (no != 0)
	{
		remainder = no % 10;
		reverse = reverse * 10 + remainder;
		no /= 10;
	}
	return reverse;
}

int palindrome (int number)
{
	// returns 1 if the number is a palindrome
	int reverse = Reverse (number);
	if (reverse == number)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}

int isPrime(int num)
{
	// returns 1 if the number is prime
	int m = num/2;
	int flag = 0;
	for(int i = 2 ; i <= m; i++)
	{
		if ( (num % i) == 0)
		{
			flag = 1;
			break;
		}
	}
	if (flag == 1)
	{
		return 0;
	}
	else
	{
		return 1;
	}
}

int main()
{
	printf ( "W E L C O M E \nPrinting the first 10 reversible prime squares: \n\n");
	int num = 0, count = 0;
	while (count < 10)
	{
		//check if the number is palindrome
		if (palindrome(num) == 1)
		{
			num++;
		}
		else
		{
			// check if the number is prime
			if (isPrime(num) == 1)
			{
				int reverse = Reverse(num); 
				// check if the reverse if prime
				if(isPrime(reverse) == 1)
				{
					int squareNum = num * num;
					int squareReverse = reverse * reverse;
					int reverseSquareNum = Reverse(squareNum);
					//check if the reverse squared if equal to the reverse of the original number squared 
					if ( reverseSquareNum == squareReverse)
					{
						// print on the screen and increment the count if true
						count++;
						printf("%d \n", squareNum);
					}
					num++;
				}
				else
				{
					num++;
				}
			}
			else
			{
				num++;
			}
		}
	}
	printf("\nD O N E  P R I N T I N G");
	return 0;
}