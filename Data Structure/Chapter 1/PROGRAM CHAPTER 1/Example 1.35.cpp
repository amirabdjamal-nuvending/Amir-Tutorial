//Chapter 1:
//Example 1.35// Pass by reference using reference variabla as parameter
#include<iostream>
using namespace std;

void squareIt(int &); //prototype

int main()
{
  int localVar = 5;
  cout<<"localVar before function call is "<<localVar<<endl;
  squareIt(localVar);  // localVar now
                     // contains 25
  cout<<"localVar after function call is "<<localVar<<endl;
}

void squareIt(int &num)
{
   cout<<"num before modification is "<<num<<endl;
		num *= num;
    cout<<"num after modification is "<<num<<endl;
}














