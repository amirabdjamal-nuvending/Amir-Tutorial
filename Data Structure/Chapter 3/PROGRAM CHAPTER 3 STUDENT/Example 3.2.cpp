// This program builds a binary tree with 5 nodes.
#include <iostream>

using namespace std;

struct TreeNode
   {
      int value;         // The value in the node
      TreeNode *left;    // Pointer to left child node
      TreeNode *right;   // Pointer to right child node
   };

   TreeNode *root;       // Pointer to the root node

void insertNode(int);
void insert(TreeNode *&, TreeNode *&);
void display();

int main()
{
   TreeNode tree;

   cout << "Inserting nodes =31. "<<endl;
   insertNode(31);
   display();

   cout << "Inserting nodes =19. "<<endl;
   insertNode(19);
   display();

   cout << "Inserting nodes =59. "<<endl;
   insertNode(59);
   display();

   cout << "Inserting nodes =43. "<<endl;
   insertNode(43);
   display();

   cout << "Inserting nodes =7. "<<endl;
   insertNode(7);
   display();

   cout << "Inserting nodes =23. "<<endl;
   insertNode(23);
   display();

   cout << "Done.\n";

   return 0;
}

void insertNode(int num)
{
   TreeNode *newNode = NULL;	// Pointer to a new node.

   // Create a new node and store num in it.
   newNode = new TreeNode;
   newNode->value = num;
   newNode->left = newNode->right = NULL;

   // Insert the node.
   insert(root, newNode);
}

void insert(TreeNode *&nodePtr, TreeNode *&newNode)
{
   if (nodePtr == NULL)
      nodePtr = newNode;                  // Insert the node.
   else if (newNode->value < nodePtr->value)
      insert(nodePtr->left, newNode);     // Search the left branch
   else
      insert(nodePtr->right, newNode);    // Search the right branch
}

void display()
{
     TreeNode *var=root;
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

