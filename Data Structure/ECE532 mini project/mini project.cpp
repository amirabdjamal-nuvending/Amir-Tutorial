#include <iostream>
using namespace std;
const int arraySize = 50;
struct nodeType
{
  int info;
  float ride_price;
  int ride_distance;
  nodeType *link;
};

struct ride_details
{
  float ride_price;
  int ride_distance;
};

//ride_details ride_jenis [10];

int main()
{
    //cout<< ride_number [3].ride_price;
  //  cout<< ride_number [3].ride_distance;
   nodeType *head;

   // Create first node
   head = new nodeType;    // Allocate new node
   head->info=1;     // Store the value
   head->ride_price=11;
   head->ride_distance=111;
   head->link = new nodeType;      // Signify end of list

   // Create second node
   head->link->info = 2;     // Store the value
   head->link->ride_price = 22;
   head->link->ride_distance= 222;
   head->link->link = new nodeType;

   head->link->link->info = 63;     // Store the value
   head->link->link->link = new nodeType;

   head->link->link->link->info = 45;     // Store the value
   head->link->link->link->link  = NULL;

   // Print the list
   cout << "Head =" << head<< "--->";
   cout << "Info = " << head->info << "||";
   cout << "price = " << head->ride_price << "||";
   cout << "dist = " << head->ride_distance << "||";
   cout << "Link=" << head->link << "--->";
   cout << "Info = " << head->link->info << "||";
   cout << "Link=" << head->link ->link<< "--->";
   cout << "Info = " << head->link->link->info << "||";
   cout << "Link=" << head->link ->link->link<< "--->";
   cout << "Info = " << head->link->link->link->info << "||";
   cout << "Link=" << head->link ->link->link->link;
   return 0;
}
