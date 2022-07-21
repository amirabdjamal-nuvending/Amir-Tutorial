//Chapter 1:
//Example 1.20
//Using function definition on top of program

#include<iostream>
using namespace std;

int square(int x)
{
    return x*x;
}

int main()
{
    int a=10;
    cout<<a<<" squared: "<<square(a)<<endl;

}


