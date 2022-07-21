//Chapter 1:
//Example 1.2
//Gaddis Program 9-2// This program stores the address of a variable in a pointer.
#include <iostream>
using namespace std;

int main()
{
   //int x = 25;				// int variable
   int *ptr = new int;      // Pointer variable, can point to an int
   *ptr=5;
   //ptr = &x;      // Store the address of x in ptr
   cout << "ptr is " << ptr << endl;
   cout << "*ptr is " << *ptr << endl;
    cout << "Address ptr is " << &ptr << endl;

    delete ptr;
    ptr=NULL;

  cout << "ptr is " << ptr << endl;
   cout << "*ptr is " << *ptr << endl;
   // cout << "Address ptr is " << &ptr << endl;

   return 0;
}
