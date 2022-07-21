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
   nodeType *head;

   // Create first node
   head = new nodeType;    // Allocate new node
   head->info = 17;     // Store the value
   head->link = NULL;      // Signify end of list

   cout<<"Before remove a node"<<endl;

  display(head);

  head=NULL;

  delete head;

 cout<<"After remove a node"<<endl;
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
