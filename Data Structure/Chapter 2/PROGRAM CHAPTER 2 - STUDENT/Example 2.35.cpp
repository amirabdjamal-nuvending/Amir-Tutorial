//Chapter 2:
//Example 2.35 :

# include<iostream>

using namespace std;

const int QSIZE = 3;
char q[QSIZE];
int number = 0;
int front=-1;
int rear=-1;


bool isEmpty();
bool isFull();

 //Initialize Top of Queue
int main()
{


if (isEmpty()==true)
            cout<<"Queue is empty."<<endl;

else
            cout<<"Queue is not empty."<<endl;

q[number++]='E';
q[number++]='K';
q[number++]='G';

cout<<"After initialization"<<endl;

if (isEmpty()==true)
    cout<<"Queue is empty."<<endl;

else
    cout<<"Queue is not empty."<<endl;


if (isFull()==true)
            cout<<"Queue is full."<<endl;

else
            cout<<"Queue is not full."<<endl;

return 0;
}

bool isEmpty()
  {
    if (number > 0)
      return false;
    else
      return true;
  }

bool isFull()
  {
    if (number < QSIZE)
      return false;
    else
      return true;
  }

