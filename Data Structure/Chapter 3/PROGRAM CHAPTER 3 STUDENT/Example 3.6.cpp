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
void displayInOrder(TreeNode *nodePtr);
void remove(int num);
void deleteNode(int num, TreeNode *&nodePtr);
void makeDeletion(TreeNode *&nodePtr);

int main()
{


   cout << "Inserting nodes.\n";
   insertNode(31);
   insertNode(19);
   insertNode(59);
   insertNode(43);
   insertNode(7);


  // Display the values.
   cout << "Here are the values in the tree:\n";
   displayInOrder(root);

   // Delete the value 19.
   cout << "Deleting 19...\n";
   remove(19);

   // Delete the value 12.
   cout << "Deleting 31...\n";
   remove(31);

   // Display the values.
   cout << "Now, here are the nodes:\n";
   displayInOrder(root);

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

void displayInOrder(TreeNode *nodePtr)
{
   if (nodePtr)
   {
      displayInOrder(nodePtr->left);
      cout << nodePtr->value << endl;
      displayInOrder(nodePtr->right);
   }
}

void remove(int num)
{
   deleteNode(num, root);
}


void deleteNode(int num, TreeNode *&nodePtr)
{
   if (num < nodePtr->value)
      deleteNode(num, nodePtr->left);
   else if (num > nodePtr->value)
      deleteNode(num, nodePtr->right);
   else
      makeDeletion(nodePtr);
}


void makeDeletion(TreeNode *&nodePtr)
{
   // Define a temporary pointer to use in reattaching
   // the left subtree.
   TreeNode *tempNodePtr = NULL;

   if (nodePtr == NULL)
      cout << "Cannot delete empty node.\n";
   else if (nodePtr->right == NULL)
   {
      tempNodePtr = nodePtr;
      nodePtr = nodePtr->left;   // Reattach the left child
      delete tempNodePtr;
   }
   else if (nodePtr->left == NULL)
   {
      tempNodePtr = nodePtr;
      nodePtr = nodePtr->right;  // Reattach the right child
      delete tempNodePtr;
   }
   // If the node has two children.
   else
   {
      // Move one node the right.
      tempNodePtr = nodePtr->right;
      // Go to the end left node.
      while (tempNodePtr->left)
         tempNodePtr = tempNodePtr->left;
      // Reattach the left subtree.
      tempNodePtr->left = nodePtr->left;
      tempNodePtr = nodePtr;
      // Reattach the right subtree.
      nodePtr = nodePtr->right;
      delete tempNodePtr;
   }
}



