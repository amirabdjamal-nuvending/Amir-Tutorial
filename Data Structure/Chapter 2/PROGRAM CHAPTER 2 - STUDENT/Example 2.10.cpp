//Chapter 2:
//Example 2.10
//Modification of Gaddis Program 19-3// This program demonstrates a tail recursive function to
// calculate the factorial of a number.
#include <iostream>
using namespace std;

// Function prototype
int factorial(int);
int factorial_tail(int, int);

int main()
{
   int number;

   // Get a number from the user.
   cout << "Enter an integer value and I will display\n";
   cout << "its factorial: ";
   cin >> number;

   // Display the factorial of the number.
   cout << "The factorial of " << number << " is ";
   cout << factorial(number) << endl;
   return 0;
}

//*************************************************************
// Definition of factorial. A recursive function to calculate *
// the factorial of the parameter n.                          *
//*************************************************************

 int factorial1(int n, int accumulator)
 {
    if (n == 0)
        return accumulator;
    return factorial1(n - 1, n * accumulator);
  }

 int factorial(int n)
 {
    return factorial1(n, 1);
  }
