//Chapter 2:
//Example 2.38

# include<iostream>

using namespace std;


struct node
{
    int Data;
    node *link;
};

node *front;

bool isEmpty();



 //Initialize Top of Stack
int main()
{

 front=NULL;

if (isEmpty()==true)
            cout<<"Stack is empty.";

else
            cout<<"Stack is not empty.";
}

bool isEmpty()
   {      if (front == NULL)
			return true;
           else return false;
       }
