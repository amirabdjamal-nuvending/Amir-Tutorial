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

int main()
{
   nodeType *head;

   // Create first node
   head = new nodeType;    // Allocate new node
   head->info = 17;     // Store the value
   head->link = new nodeType;      // Signify end of list

   // Create second node
   head->link->info = 92;     // Store the value
   head->link->link = new nodeType;

   head->link->link->info = 63;     // Store the value
   head->link->link->link = new nodeType;

   head->link->link->link->info = 45;     // Store the value
   head->link->link->link->link  = NULL;

   // Print the list
   cout << "Head =" << head<< "--->";
   cout << "Info = " << head->info << "||";
   cout << "Link=" << head->link << "--->";
   cout << "Info = " << head->link->info << "||";
   cout << "Link=" << head->link ->link<< "--->";
   cout << "Info = " << head->link->link->info << "||";
   cout << "Link=" << head->link ->link->link<< "--->";
   cout << "Info = " << head->link->link->link->info << "||";
   cout << "Link=" << head->link ->link->link->link;
   return 0;
}
