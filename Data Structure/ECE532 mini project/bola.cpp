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

int option;
int goals[500];
string clubs[500];
string playername[500];

struct node{

    int goals;
    string clubs;
    string playername;
    node *link;

};
struct nodeTree{

    int goals1;
    string clubs1;
    string playername1;
    nodeTree *left;
    nodeTree *right;

};
nodeTree *root;

void read_Data_Goals();
void read_Data_Clubs();
void read_Data_Playername();
void addnode(node *head, int value1, string value2, string value3);
void addNodeMenu(node *head);
void insertNode(int value1, string value2, string value3);
void firstpagemenu(node *head);




int main()
{

   read_Data_Goals();
   read_Data_Clubs();
   read_Data_Playername();

    node *head;
    head= new node;
    head->goals=goals[0];
    head->clubs=clubs[0];
    head->playername=playername[0];
    head->link=NULL;

    for(int i=1;i<624;i++){
        addnode(head, goals[i],clubs[i],playername[i]);
    }

    //menuLL(head);

//-------------------tree-------------------

    for(int i=0;i<624;i++){
        insertNode(goals[i],clubs[i],playername[i]);
    }

    //menuDisplayTree();

//-----------------sorting array------------------

    //menuSorting();

    firstpagemenu(head);

      return 0;
}

void firstpagemenu(node *head){

cout<<"\n\n\n\t      ________________________________________________________"<<endl;
    cout<<"\n\t     |                                                        |"<<endl;
    cout<<"\n\t     |_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+|"<<endl;
    cout<<"\n\t     |                                                        |"<<endl;
    cout<<"\n\t     |*****************TOP SCORERS IN FOOTBALL****************|"<<endl;
    cout<<"\n\t     |                                                        |"<<endl;
    cout<<"\n\t     |########################################################|\n"<<endl;
    cout<<"\t     |                                                        |"<<endl;
    cout<<"\n\t     |\t\t       Please Make A Choice:\t              |\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |                    1-Display Ranking                   |\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |                    2-Add/Delete Player                 |\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |                    3-All Scorers                       |\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |                    4-Exit program                      |\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+_+|\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |********************************************************|\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t     |########################################################|\n"<<endl;
    cout<<"\t     |                                                        |\n"<<endl;
    cout<<"\t      -------------------------------------------------------- \n\n\n"<<endl;

    cout<<"PLEASE MAKE YOUR CHOICE:"<<endl;
    cin>>option;


switch(option){

    case 1:
    system("cls");
    addNodeMenu(head);
    break;

}

}


void read_Data_Goals(){

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

void read_Data_Clubs(){

    string data;
    int counter=0;

    file.open("clubs.txt");

    while(getline(file, data)){
        clubs[counter]=data;
        counter++;
    }
    file.close();

}

void read_Data_Playername(){

    string data;
    int counter=0;

    file.open("playername.txt");

    while(getline(file, data)){
        playername[counter]=data;
        counter++;
    }
    file.close();
}

void addnode(node *head, int value1, string value2, string value3){
    node *newNode=new node;
    newNode->goals=value1;
    newNode->clubs=value2;
    newNode->playername=value3;
    newNode->link=NULL;

    node *cur=head;

    while(cur){
        if((cur->link)==NULL){
            cur->link= newNode;
            return;
        }
        cur=cur->link;
    }

}

void addNodeMenu(node *head){
    int goals;
    string clubs;
    string playername;

    cin.ignore();
    cout<<"Please enter the player's name: ";
    getline(cin, playername);

    cout<<endl<<"Please enter the club name: ";
    getline(cin, clubs);

    cout<<endl<<"Please enter the no. of goals scored: ";
    cin>>goals;

    addnode(head, goals, clubs, playername);
}

void insert(nodeTree *&nodePtr, nodeTree *&newNode)
{

   if (nodePtr == NULL){
      nodePtr = newNode;                  // Insert the node.
   }
   else if (newNode->goals1 <= nodePtr->goals1){
      insert(nodePtr->left, newNode);     // Search the left branch
   }
   else if (newNode->goals1 > nodePtr->goals1){
      insert(nodePtr->right, newNode);    // Search the right branch
   }
}

void insertNode(int value1, string value2, string value3)
{
   nodeTree *newNode = NULL;	// Pointer to a new node.

   newNode = new nodeTree;
   newNode->goals1 = value1;
   newNode->clubs1 = value2;
   newNode->playername1 = value3;
   newNode->left = newNode->right = NULL;

   // Insert the node.
   insert(root, newNode);
}

