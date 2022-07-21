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
   nodeType *head,*tail,*new_node1,*new_node2;

   // Create first node
   head = new nodeType;    // Allocate new node
   head->info = 5;     // Store the value
   head->link = new nodeType;      // Signify end of list

   // Create second node
   head->link->info = -1;     // Store the value
   head->link->link = new nodeType;

   head->link->link->info = 16;     // Store the value
   new_node1 = new nodeType;
   tail = new nodeType;


   new_node1->info = 2;     // Store the value
   new_node1->link  = NULL;

   tail=new_node1;

   head->link->link->link=tail;

   cout<<"Before Insertion"<<endl;
   display(head);

   new_node2= new nodeType;

   new_node2->info = 25;     // Store the value
   new_node2->link  = NULL;

   tail=new_node2;
   new_node1->link=tail;

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
