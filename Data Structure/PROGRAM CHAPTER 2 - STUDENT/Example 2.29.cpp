//Chapter 2:
//Example 2.25 : To check if stack is empty

# include<iostream>
#include<cstdlib>

using namespace std;

const int STACK_SIZE = 3;
char s[STACK_SIZE];
int top = 0;

void push(char x);
void pop(char &x);
void display(char s[STACK_SIZE]);
bool isEmpty();
bool isFull();

 //Initialize Top of Stack
int main()
{

push('a');
cout<<"After Push"<<endl;
display(s);

push('b');
cout<<"\nAfter Push"<<endl;
display(s);

push('c');
cout<<"\nAfter Push"<<endl;
display(s);

cout<<endl;
pop(s[top]);
pop(s[top]);
pop(s[top]);

}

void pop(char &x)
  {
   if (isEmpty())
     {cout<<endl<<"Error!!Stack is empty."<<endl; exit(1);}
   // or could throw an exception

      top--;
   x = s[top];
   cout<<"Popping "<<x<<endl;
    }


void push(char x)
  {
   if (isFull())
     {cout<<"Error!!Stack is full."<<endl;
      exit(1);}
   // or could throw an exception
       s[top] = x;
   top++;
    }

void display(char s[STACK_SIZE])
{
    for (int i=STACK_SIZE-1;i>=0;i--)
    { cout<<" _____ "<<endl;
      cout<<"|  "<<s[i]<<"  |"<<endl;
    }
    cout<<" _____ "<<endl;
}


bool isEmpty()
   {      if (top == 0)
			return true;
           else return false;
       }

bool isFull()
 {
   if (top == STACK_SIZE)
			return true;
       else return false;
   }



