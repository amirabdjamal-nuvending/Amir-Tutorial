#include<iostream>
//Example 2.40

using namespace std;

struct Node
{
    int Data;
    Node *next;
}*front,*rear;



void Enqueue(int value);
void display();
bool isEmpty();

int main()
{
     front=rear=NULL;

    cout<<"After Enqueue\n";
    Enqueue(5);
    display();

    cout<<"After Enqueue\n";
    Enqueue(15);
    display();

    cout<<"After Enqueue\n";
    Enqueue(25);
    display();

    cout<<"After Enqueue\n";
    Enqueue(35);
    display();


    return 0;

}

void Enqueue(int value)
{
    Node *temp;
    if (isEmpty())
    {
        rear = new Node;
        rear->Data = value;
        rear->next= NULL;
        front = rear;
    }
    else
    {
        temp=new Node;
        rear->next= temp;
        temp->Data = value;
        temp->next = NULL;

        rear = temp;
    }

}

void display()
{
     Node *var=front;
     if(var!=NULL)
     {
          cout<<"Elements are as:\n";
          while(var!=NULL)
          {
               cout<<"\t"<<var->Data;
               var=var->next;
          }
     cout<<"\n\n";
     }
     else
     cout<<"\nStack is Empty";
}

bool isEmpty()
   {      if (front == NULL)
			return true;
           else return false;
       }

