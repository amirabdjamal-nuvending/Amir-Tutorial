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
void initNode(nodeType *head,int n);
void addNode(nodeType *head, int n);
nodeType *searchNode(nodeType *head, int n);
void deleteNode(struct nodeType **head, nodeType *ptrDel);

int main()
{
   nodeType *head,*tail,*pr_tail,*temp,*temp1,*cur;
   int n;

   // Create first node
   head = new nodeType;    // Allocate new node
   tail = new nodeType;

    initNode(head,5);
	addNode(head,-1);
	addNode(head,16);
	addNode(head,2);
	addNode(head,7);


   cout<<"Before remove a node"<<endl;
   display(head);

   cur=new nodeType;
   cur=head;

   while(cur) {
		if(cur->link==NULL)
           {
            n=cur->info;

           }

        cur = cur->link;
	}
	nodeType *ptrDelete = searchNode(head,n);
    deleteNode(&head,ptrDelete);
    cout << "Node "<< n << " deleted!\n";
	display(head);


 cout<<"After remove a tail link"<<endl;
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

void initNode(nodeType *head,int n){
	head->info = n;
	head->link =NULL;
}

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

nodeType *searchNode(nodeType *head, int n) {
	nodeType *cur = head;
	while(cur) {
		if(cur->info == n) return cur;
		cur = cur->link;
	}
	cout << "No Node " << n << " in list.\n";
}

void deleteNode(nodeType **head, nodeType *ptrDel) {
	nodeType *cur = *head;

	while(cur) {
		if(cur->link == ptrDel) {
			cur->link= ptrDel->link;
			delete ptrDel;

		}
		cur = cur->link;
	}

}


