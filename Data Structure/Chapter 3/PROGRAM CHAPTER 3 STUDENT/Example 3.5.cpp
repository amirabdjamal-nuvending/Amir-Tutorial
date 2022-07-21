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
bool searchNode(int num);

int main()
{


   cout << "Inserting nodes.\n";
   insertNode(31);
   insertNode(19);
   insertNode(59);
   insertNode(43);
   insertNode(7);


   if (searchNode(43))
      cout << "43 is found in the tree.\n";
   else
      cout << "43 was not found in the tree.\n";

   // Search for the value 100.
   if (searchNode(100))
      cout << "100 is found in the tree.\n";
   else
      cout << "100 was not found in the tree.\n";

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

bool searchNode(int num)
{
   TreeNode *nodePtr = root;

   while (nodePtr)
   {
      if (nodePtr->value == num)
         return true;
      else if (num < nodePtr->value)
         nodePtr = nodePtr->left;
      else
         nodePtr = nodePtr->right;
   }
   return false;
}
