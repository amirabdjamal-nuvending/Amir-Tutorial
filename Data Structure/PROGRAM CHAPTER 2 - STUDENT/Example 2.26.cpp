//Chapter 2:
//Example 2.25 : To check if stack is empty

# include<iostream>

using namespace std;

const int STACK_SIZE = 3;
char s[STACK_SIZE];
int top = 0;


bool isEmpty();

 //Initialize Top of Stack
int main()
{


if (isEmpty()==true)
            cout<<"Stack is empty."<<endl;

else
            cout<<"Stack is not empty."<<endl;

s[top]='a';
s[top++]='b';
s[top++]='c';

cout<<"After initialization"<<endl;

if (isEmpty()==true)
            cout<<"Stack is empty."<<endl;

else
            cout<<"Stack is not empty."<<endl;

}

bool isEmpty()
   {      if (top == 0)
			return true;
           else return false;
       }

