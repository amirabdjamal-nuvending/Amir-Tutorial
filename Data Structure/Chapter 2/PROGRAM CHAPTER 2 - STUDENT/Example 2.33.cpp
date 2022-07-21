#include<iostream>
#include <stdio.h>
#include <stdlib.h>

using namespace std;

struct Node
{
    int Data;
    Node *next;
}*top;



void push(int value);
void pop();
bool isEmpty();
void display();

int main()
{
     int i=0;
     top=NULL;
     int value;

    push(5);
    cout<<"After Push"<<endl;
    display();

    push(15);
    cout<<"After Push"<<endl;
    display();

    push(25);
    cout<<"After Push"<<endl;
    display();

    pop();
    cout<<"After Pop"<<endl;
    display();

    pop();
    cout<<"After Pop"<<endl;
    display();

    pop();
    cout<<"After Pop"<<endl;
    display();

    pop();
    cout<<"After Pop"<<endl;
    display();

    return 0;

}

void push(int value)
{
    Node *temp;
    temp=new Node;
    temp->Data=value;
    if (top == NULL)
    {
         top=temp;
         top->next=NULL;
    }
    else
    {
        temp->next=top;
        top=temp;
    }
}

void pop()
{
    Node *temp, *var=top;

    if (isEmpty()==true)
    { cout<<"\nStack is empty.";
     exit(1);
     }

    else if(var==top)
    {
        top = top->next;
        free(var);
    }

}

bool isEmpty()
   {      if (top == NULL)
			return true;
           else return false;
       }


void display()
{
     Node *var=top;
     if(var!=NULL)
     {
          cout<<"\nElements are as:\n";
          while(var!=NULL)
          {
               cout<<"\t"<<var->Data<<endl;
               var=var->next;
          }
     cout<<"\n";
     }

}
