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
   new_node1= new nodeType;
   head=new nodeType;

   new_node1->info = 5;     // Store the value
   new_node1->link = new nodeType;      // Signify end of list

   new_node2= new nodeType;
   new_node2->info = 25;     // Store the value
   new_node2->link = NULL;      // Signify end of list

   head=new_node1;


   // Create second node
   head->link->info = -1;     // Store the value
   head->link->link = new nodeType;

   head->link->link->info = 16;     // Store the value
   tail = new nodeType;
   head->link->link->link=tail;


   tail->info = 2;     // Store the value
   tail->link  = NULL;

   cout<<"Before Insertion"<<endl;
   display(head);

   head=new_node2;
   new_node2->link = new_node1;      // Signify end of list

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


