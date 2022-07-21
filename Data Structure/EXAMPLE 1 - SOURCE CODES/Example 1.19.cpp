//Chapter 1:
//Example 1.19
//Using Function Prototype

#include<iostream>
using namespace std;

int square(int x);

int main()
{
    int a=10;
    cout<<a<<" squared: "<<square(a)<<endl;

}

int square(int x)
{
    return x*x;
}
