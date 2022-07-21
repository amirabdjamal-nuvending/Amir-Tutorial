//Chapter 1:
//Example 1.31
//Program return larger number
#include<iostream>
using namespace std;

double larger (double x, double y);

int main()
{

 double a=1,b=2;
 cout<<"The largest number is "<<larger (a, b);

}

double larger (double x, double y)
{
    double max;

    if(x>=y)
        max=x;
    else
        max=y;

    return max;
}
