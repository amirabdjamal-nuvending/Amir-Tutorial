//Chapter 2:
//Example 2.25 : To check if stack is empty

# include<iostream>

using namespace std;


struct node
{
    int info;
    node *link;
};

node *top;

bool isEmpty();



 //Initialize Top of Stack
int main()
{

 top=NULL;

if (isEmpty()==true)
            cout<<"Stack is empty.";

else
            cout<<"Stack is not empty.";
}

bool isEmpty()
   {      if (top == NULL)
			return true;
           else return false;
       }
