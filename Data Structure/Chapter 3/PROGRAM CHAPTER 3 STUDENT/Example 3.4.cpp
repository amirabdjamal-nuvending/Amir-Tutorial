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
void displayInOrder(TreeNode *);
void displayPreOrder(TreeNode *);
void displayPostOrder(TreeNode *);

int main()
{


   cout << "Inserting nodes.\n";
   insertNode(5);
   insertNode(8);
   insertNode(3);
   insertNode(12);
   insertNode(9);


   // Display inorder.
   cout << "Inorder traversal:\n";
   displayInOrder(root);

   // Display preorder.
   cout << "\nPreorder traversal:\n";
   displayPreOrder(root);

   // Display postorder.
   cout << "\nPostorder traversal:\n";
   displayPostOrder(root);

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


void displayPreOrder(TreeNode *nodePtr)
{
   if (nodePtr)
   {
      cout << nodePtr->value << endl;
      displayPreOrder(nodePtr->left);
      displayPreOrder(nodePtr->right);
   }
}


void displayPostOrder(TreeNode *nodePtr)
{
   if (nodePtr)
   {
      displayPostOrder(nodePtr->left);
      displayPostOrder(nodePtr->right);
      cout << nodePtr->value << endl;
   }
}
