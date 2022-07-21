#include<iostream>
#include<cstdlib>
using namespace std;
#define STACKSIZE 20

struct STACK{
int top;
int items[STACKSIZE]; /*stack can contain up to 20 integers*/
};
void push(STACK *, int);
int pop(STACK *);
double calculate(char []);

int main()
{
double result;
char E[50];
cout<<"Enter your Postfix expression(don't use space character):\n";
cin>>E;
result = calculate(E);
cout<<"The result of the Postfix expression "<<E<<" = "<<result;
return 0;
}

double calculate(char exp[])
{
STACK s;
s.top =-1;/*indicates that the stack is empty at the beginning*/
int i,num1,num2,value;
for(i=0; exp[i]!='\0';i++){
    if(exp[i] >='0' && exp[i] <='9') /*checks if exp[i] has a digit*/
        push(&s,(double)(exp[i] -'0')); /*converts digit into integer*/
    else{
        num1=pop(&s);
        num2=pop(&s);
        switch(exp[i]){
        case '+': value=num2+num1;break;
        case '-': value=num2-num1;break;
        case '*': value=num2*num1;break;
        case '/': value=num2/num1;break;
        default : cout<<"Illegal Operator\n";
        exit(1);
        }
        push(&s,value);
    }
}
return pop(&s);
}

void push(STACK *Sptr, int ps) /*pushes ps into stack*/
{
    if(Sptr->top == STACKSIZE-1){
        cout<<"Stack is full\n";
        exit(1); /*exit from the function*/
    }
    else {
        Sptr->top++;
        Sptr->items[Sptr->top]= ps;
    }
}
int pop(STACK *Sptr)
{
int pp;
    if(Sptr->top == -1){
        cout<<"Stack is empty\n";
        exit(1); /*exit from the function*/
    }
    else {
        pp = Sptr->items[Sptr->top];
        Sptr->top--;
    }
return pp;
}
