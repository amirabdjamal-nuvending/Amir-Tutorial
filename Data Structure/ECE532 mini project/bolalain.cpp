#include <iostream>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <string>
#include <stdlib.h> //clear screen
#include <conio.h>
#include <windows.h>


using namespace std;
ifstream file;

char input;
int goals[170];
string clubs[170];
string playername[170];

struct nodeDataAsal{

    int goals;
    string clubs;
    string playername;
    nodeDataAsal *link;

};

struct nodeTree{

    int goals_tree;
    string clubs_tree;
    string playername_tree;
    nodeTree *left;
    nodeTree *right;


};
nodeTree *root;

void read_data_goals();
void read_data_clubs();
void read_data_playername();
void add_data_into_node(nodeDataAsal *head, int goalsvalue,string clubsvalue,string playernamevalue);
void construct_tree(int goalsvalue,string clubsvalue,string playernamevalue);
void insert(nodeTree *&, nodeTree *&);


int main(){


    read_data_goals();
    read_data_clubs();
    read_data_playername();

    nodeDataAsal *head;
    head->goals=goals[0];
    head->clubs=clubs[0];
    head->playername=playername[0];
    head->link=NULL;
cout<<"haiiiihlllo";


for(int i=1;i<540;i++){
        add_data_into_node(head, goals[i],clubs[i],playername[i]); //create link list
    }

for(int i=0;i<540;i++){
        construct_tree(goals[i],clubs[i],playername[i]); //create data into trees
    }


    nodeDataAsal *list=head;

    while(list){
        cout<<setw(18)<<list->clubs;
        cout<<setw(5)<<"|";
        cout<<setw(18)<<list->playername;
        cout<<setw(7)<<"|";
        cout<<setw(10)<<"| "<<list->goals<<endl;
        list=list->link;
    }


cout<<"Press any key to create link list for all data"<<endl;

}



void read_data_goals(){

    string data;
    int counter=0;

    file.open("goals.txt");

    while(getline(file, data)){
        stringstream convert(data);
        convert>> goals[counter];
        counter++;
    }
    file.close();
}

void read_data_clubs(){

    string data;
    int counter=0;

    file.open("clubs.txt");

    while(getline(file, data)){
        clubs[counter]=data;
        counter++;
    }
    file.close();

}

void read_data_playername(){

    string data;
    int counter=0;

    file.open("playername.txt");

    while(getline(file, data)){
        playername[counter]=data;
        counter++;
    }
    file.close();
}


//create link list
void add_data_into_node(nodeDataAsal *head, int goalsvalue,string clubsvalue,string playernamevalue){

nodeDataAsal *newNode=new nodeDataAsal;
newNode->goals=goalsvalue;
newNode->clubs=clubsvalue;
newNode->playername=playernamevalue;
newNode->link=NULL;

nodeDataAsal *cur=head;

        while(cur){
        if((cur->link)==NULL){
            cur->link= newNode;
            return;
        }
        cur=cur->link;
    }


}
//create data into trees
void construct_tree(int goalsvalue,string clubsvalue,string playernamevalue)
{
   nodeTree *newNode = NULL;	// Pointer to a new node.

   newNode = new nodeTree;
   newNode->goals_tree = goalsvalue;
   newNode->clubs_tree = clubsvalue;
   newNode->playername_tree = playernamevalue;
   newNode->left = newNode->right = NULL;

   // Insert kiri kanan.
   insert(root, newNode);

}
//asing kiri kanan
void insert(nodeTree *&nodePtr, nodeTree *&newNode)
{

   if (nodePtr == NULL){
      nodePtr = newNode;                  // Insert the node.
   }
   else if (newNode->goals_tree <= nodePtr->goals_tree){
      insert(nodePtr->left, newNode);     // Search the left branch
   }
   else if (newNode->goals_tree > nodePtr->goals_tree){
      insert(nodePtr->right, newNode);    // Search the right branch
   }
}
