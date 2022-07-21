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
   nodeType *head,*tail,*new_node;

   // Create first node
   head = new nodeType;    // Allocate new node
   head->info = 5;     // Store the value
   head->link = new nodeType;      // Signify end of list

   // Create second node
   head->link->info = -1;     // Store the value
   head->link->link = new nodeType;

   head->link->link->info = 16;     // Store the value
   tail = new nodeType;
   head->link->link->link=tail;

   new_node= new nodeType;

   tail->info = 2;     // Store the value
   tail->link  = NULL;

   cout<<"Before Insertion"<<endl;
   display(head);

   tail->link  = new_node;

   new_node->info = 25;     // Store the value
   new_node->link  = NULL;

   tail=new_node;

   cout<<"After Insertion"<<endl;
   display(head);

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


