//Chapter 2:
//Example 2.6
//Gaddis Program 19-6// This program demonstrates a recursive function
// that calculates Fibonacci numbers.
#include <iostream>
using namespace std;

// Function prototype
int fib(int);

int main()
{
      cout << fib(3) << " ";
   cout << endl;
   return 0;
}

//*****************************************
// Function fib. Accepts an int argument  *
// in n. This function returns the nth    *
// Fibonacci number.                      *
//*****************************************

int fib(int n)
{
                         // Base case
   if(n!=0)
      return n + fib(n - 1); // Recursive case
}
