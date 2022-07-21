//Chapter 2:
//Example 2.11
// This program illustrates the creation
// of linked lists.
#include <iostream>
using namespace std;


struct nodeType
{
  int info;
  nodeType *link;
};

void display(nodeType *head);

int main()
{
   nodeType *head,*tail,*temp;

   head = new nodeType;    // Allocate new node
   head->info = 8;     // Store the value
   head->link = new nodeType;      // Signify end of list

   head->link->info = 5;     // Store the value
   head->link->link = new nodeType;      // Signify end of list

   // Create second node
   head->link->link->info = -1;     // Store the value
   head->link->link->link = new nodeType;

   head->link->link->link->info = 16;     // Store the value
   tail = new nodeType;
   head->link->link->link->link=tail;


   tail->info = 2;     // Store the value
   tail->link  = NULL;

   cout<<"Before remove a node"<<endl;
   display(head);

   temp=head;
   head->info=head->link->info;
   head->link=head->link->link;

   cout<<"Update head link"<<endl;
   display(head);

   temp=NULL;

   delete temp;

 cout<<"After remove a head node, the list is "<<endl;
  display(head);
   cout<<"After remove a head node, the removed head is "<<endl;
  display(temp);

   return 0;
}

void display(nodeType *head)
{
	nodeType *list = head;
	while(list) {
		cout << list->info << " ";
		list = list->link;
	}
	cout << endl;
	cout << endl;
}

