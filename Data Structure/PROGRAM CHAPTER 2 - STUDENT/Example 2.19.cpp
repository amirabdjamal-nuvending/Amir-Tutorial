//Chapter 2:
//Example 2.13
// A complete working C++ program to demonstrate all insertion methods
// on Linked List

#include <iostream>

using namespace std;

struct nodeType
{
  int info;
  nodeType *link;
};

void initNode(nodeType *head,int n);
void addNode(nodeType *head, int n);
void display(nodeType *head);

int main()
{

	nodeType *head = new nodeType;

	initNode(head,17);
	display(head);

	addNode(head,92);
	display(head);

	addNode(head,63);
	display(head);

	addNode(head,45);
	display(head);


	return 0;
}

// only for the 1st Node
void initNode(nodeType *head,int n){
	head->info = n;
	head->link =NULL;
}

// apending
void addNode(nodeType *head, int n) {
	nodeType *newNode = new nodeType;
	newNode->info = n;
	newNode->link = NULL;

	nodeType *cur = head;
	while(cur!=NULL) {
		if(cur->link == NULL) {
			cur->link = newNode;
			return;
		}
		cur = cur->link;
	}
}


void display(nodeType *head) {
	nodeType*list = head;
	while(list) {
		cout << list->info << " ";
		list = list->link;
	}
	cout << endl;
	cout << endl;
}

