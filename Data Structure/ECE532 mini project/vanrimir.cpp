
// This program builds a binary tree with 5 nodes.
#include <iostream>

using namespace std;

struct UiTMNode
   {
      int value;         // The value in the node
      UiTMNode *state[];    // Pointer to left child node
      UiTMNode *branch[];
      UiTMNode *faculty[];
      UiTMNode *course[];
      UiTMNode *male;
      UiTMNode *female; // Pointer to right child node
   };

   UiTMNode *root;       // Pointer to the root node

void insertNode(string);
void insert(UiTMNode *&, UiTMNode *&);
void display();

int main()
{
   UiTMNode tree;

   cout << "Inserting nodes =Selangor. "<<endl;
   insertNode("Selangor");
   display();

   cout << "Inserting nodes =Penang. "<<endl;
   insertNode("Pulau Pinang");
   display();

   cout << "Inserting nodes =Terengganu. "<<endl;
   insertNode("Terengganu");
   display();

   cout << "Done.\n";

   return 0;
}

void insertNode(string negeri)
{
   UiTMNode *newNode = NULL;	// Pointer to a new node.

   // Create a new node and store num in it.
   newNode = new UiTMNode;
   newNode->value = negeri;
   //newNode->left = newNode->right = NULL;
   //newNode->state[]=NULL;
   for(int i=0;i<14;i++)
   {
      newNode->state[i]=NULL;
   }
   // Insert the node.
   insert(root, newNode);
}

void insert(UiTMNode *&nodePtr, UiTMNode *&newNode)
{
   if (nodePtr == NULL)
      nodePtr = newNode;                  // Insert the node.
   else if (newNode->value != nodePtr->value)
      insert(nodePtr->state[0], newNode);     // Search the left branch
   else
      insert(nodePtr->state[1], newNode);    // Search the right branch
}

void display()
{
     UiTMNode *var=root;
     if(var!=NULL)
     {
          cout<<"\nElements are as:\n";
          while(var!=NULL)
          {
               cout<<"\t"<<var->value<<endl;
               var=var->left;
               //var=var->right;
          }
     cout<<"\n";
     }
     else
     cout<<"\nStack is Empty";
}

