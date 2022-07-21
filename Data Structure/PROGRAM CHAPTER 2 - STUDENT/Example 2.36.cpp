//Chapter 2:
//Example 2.36

# include<iostream>
#include<cstdlib>

using namespace std;

const int QSIZE = 3;
char q[QSIZE];
int number = 0;
int front=-1;
int rear=-1;


void Enqueue(char x);
void display(char q[QSIZE]);
bool isEmpty();
bool isFull();

 //Initialize Top of Stack
int main()
{

Enqueue('E');
cout<<"After Enqueue"<<endl;
display(q);

Enqueue('K');
cout<<"\nAfter Enqueue"<<endl;
display(q);

Enqueue('G');
cout<<"\nAfter Enqueue"<<endl;
display(q);

Enqueue('M');
cout<<"\nAfter Enqueue"<<endl;
display(q);

return 0;
}

void Enqueue(char x)
{
if(!isFull())
   { rear = (rear + 1) % QSIZE;
	// mod operator for wrap-around
       q[rear] = x;
   number ++;
	}
else
	{
 cout<<"Error: Queue is Full\n";
	return;
 }
}


void display(char q[QSIZE])
{
    cout<<" ___________"<<endl;
    for (int i=0;i<QSIZE;i++)
    { cout<<"| "<<q[i]<<" ";
    }
    cout<<"|"<<endl;
    cout<<" ___________"<<endl;
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



