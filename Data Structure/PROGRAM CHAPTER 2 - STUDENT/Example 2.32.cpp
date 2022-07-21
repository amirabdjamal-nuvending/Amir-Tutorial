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
void display();

int main()
{
     int i=0;
     top=NULL;
     int value;

    push(5);
    display();
    push(15);
    display();
    push(25);
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
     else
     cout<<"\nStack is Empty";
}
