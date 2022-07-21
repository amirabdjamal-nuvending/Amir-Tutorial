//Chapter 1:
//Example 1.2
//Gaddis Program 9-2// This program stores the address of a variable in a pointer.
#include <iostream>
using namespace std;

int main()
{
   int x = 25;				// int variable
   int *ptr = NULL;      // Pointer variable, can point to an int
  cout << "The value in x is " << x << endl;
   cout << "The address inside ptr is " << ptr << endl;

   ptr = &x;      // Store the address of x in ptr
   cout << "The value in x is " << x << endl;
   cout << "The address of x is " << ptr << endl;

   return 0;
}
