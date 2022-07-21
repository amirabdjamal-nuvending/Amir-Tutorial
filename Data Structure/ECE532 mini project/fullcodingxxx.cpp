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
#define COUNT 10
int counter=0;
int counter2=0;
int pilihan;
float cost[630];
string departure[630];
string arrival[630];

struct node{

    float cost;
    string departure;
    string arrival;
    node *link;

};

struct nodeTree{

    float cost1;
    string departure1;
    string arrival1;
    nodeTree *left;
    nodeTree *right;

};
nodeTree *root;

void readDataCost();
void readDataDeparture();
void readDataArrival();
void addnode(node *head, float value1, string value2, string value3);
void addNodeMenu(node *head);
void displayNode(node *head);
void searchNode(node *head, string location);
void deleteNode(struct node **head);
void insertNode(float value1, string value2, string value3);
void insert(nodeTree *&, nodeTree *&);
void searchTree(nodeTree *root);
void displayTreeLeft();
void displayTreeRight();
void displayInOrder(nodeTree *nodePtr);
void displayPreOrder(nodeTree *nodePtr);
void displayPostOrder(nodeTree *nodePtr);
void menuDisplayTree(node *head);
void menuLL(node *head);
string menuDisplayLL(node *head);
void menuSorting(node *head);
void ascendingSorting();
void descendingSorting();
void frontmenu(node *head);
void frontmenu2(node *head);

HANDLE color = GetStdHandle(STD_OUTPUT_HANDLE);

int main(){

//-----------linked list-------------

    readDataCost();
    readDataDeparture();
    readDataArrival();

    node *head;
    head= new node;
    head->cost=cost[0];
    head->departure=departure[0];
    head->arrival=arrival[0];
    head->link=NULL;

    for(int i=1;i<624;i++){
        addnode(head, cost[i],departure[i],arrival[i]);
    }

    //menuLL(head);

//-------------------tree-------------------

    for(int i=0;i<624;i++){
        insertNode(cost[i],departure[i],arrival[i]);
    }

    //menuDisplayTree();

//-----------------sorting array------------------

    //menuSorting();

    frontmenu(head);
}

void frontmenu(node *head){

do{
    system("CLS");

    for(counter=0;counter<counter2;counter++){
    cout<<" ";
    }
    //for(counter=0;counter<30;counter++){
    //cout<<" ";
    //}
    cout<<"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"<<endl;

    for(counter=0;counter<counter2;counter++){
    cout<<" ";
    }
    //for(counter=0;counter<30;counter++){
    //cout<<" ";
    //}
    cout<<"            WELCOME TO TRAIN SYSTEM PROGRAM                "<<endl;

    for(counter=0;counter<counter2;counter++){
    cout<<" ";
    }
    //for(counter=0;counter<30;counter++){
    //cout<<" ";
    //}
    cout<<"                        MADE BY:                           "<<endl;

    for(counter=0;counter<counter2;counter++){
    cout<<" ";
    }
    //for(counter=0;counter<30;counter++){
    //cout<<" ";
    //}
    cout<<"          ASYRAF FAHMI BIN ARSAD (2018673972)              " <<endl;

    for(counter=0;counter<counter2;counter++){
    cout<<" ";
    }
    //for(counter=0;counter<30;counter++){
    //cout<<" ";
    //}
    cout<<"          AFNAN BIN BAHARIN (2018292174)                   "<<endl;

    for(counter=0;counter<counter2;counter++){
    cout<<" ";
    }
    //for(counter=0;counter<30;counter++){
    //cout<<" ";
    //}
    cout<<"          NORSAHIDA BINTI KAMAL (2018440776)               "<<endl;

    for(counter=0;counter<counter2;counter++){
    cout<<" ";
    }
    //for(counter=0;counter<30;counter++){
    //cout<<" ";
    //}
    cout<<"          GIBSON PANYAU (2018657494)                       "<<endl;






    for(counter=0;counter<counter2;counter++){
    cout<<" ";
    }
    //for(counter=0;counter<30;counter++){
    //cout<<" ";
    //}
    cout<<"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"<<endl;

            //cout<<"PRESS ANY BUTTON TO CONTINUE";


    counter2++;

    for(counter=0;counter<1000*1000;counter++){
    }

}while(counter2!=25);
cout<<endl;
system("PAUSE");
counter2=0;
frontmenu2(head);

}

void frontmenu2(node *head){

system("CLS");
for(counter=0;counter<=23;counter++){
        cout<<" ";
}
cout<<"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
cout<<"            WELCOME TO TRAIN SYSTEM PROGRAM               "<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
cout<<"                        MADE BY:                            "<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
cout<<"          ASYRAF FAHMI BIN ARSAD (2018673972)              "<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
cout<<"          AFNAN BIN BAHARIN (2018292174)                   "<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
cout<<"          NORSAHIDA BINTI KAMAL (2018440776)                "<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
cout<<"          GIBSON PANYAU (2018657494)                       "<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
cout<<"%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
cout<<"PLEASE MAKE YOUR CHOICE:"<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
SetConsoleTextAttribute(color, 2);
cout<<"1) LINKED LIST"<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
SetConsoleTextAttribute(color, 3);
cout<<"2) TREE"<<endl;
for(counter=0;counter<=23;counter++){
    cout<<" ";
}
SetConsoleTextAttribute(color, 4);
cout<<"3) SORTING"<<endl;

SetConsoleTextAttribute(color, 7);
cin>>pilihan;

switch(pilihan){

    case 1:
    system("cls");
    menuLL(head);
    break;

    case 2:
    system("cls");
    menuDisplayTree(head);
    break;

    case 3:
    system("cls");
    menuSorting(head);
    break;

}

}

void readDataCost(){

    string data;
    int counter=0;

    file.open("goals.txt");

    while(getline(file, data)){
        stringstream convert(data);
        convert>> cost[counter];
        counter++;
    }
    file.close();
}

void readDataDeparture(){

    string data;
    int counter=0;

    file.open("clubs.txt");

    while(getline(file, data)){
        departure[counter]=data;
        counter++;
    }
    file.close();

}

void readDataArrival(){

    string data;
    int counter=0;

    file.open("playername.txt");

    while(getline(file, data)){
        arrival[counter]=data;
        counter++;
    }
    file.close();
}

void addnode(node *head, float value1, string value2, string value3){
    node *newNode=new node;
    newNode->cost=value1;
    newNode->departure=value2;
    newNode->arrival=value3;
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
    string departure;
    string arrival;
    float cost;

    cin.ignore();
    cout<<"Please enter the departure location: ";
    getline(cin, departure);

    cout<<endl<<"Please enter the arrival location: ";
    getline(cin, arrival);

    cout<<endl<<"Please enter the cost: ";
    cin>>cost;

    addnode(head, cost, departure, arrival);
}

void displayNode(node *head){

    node *list=head;
    SetConsoleTextAttribute(color, 9);
    cout<<setw(15)<<"DEPARTURE";
    SetConsoleTextAttribute(color, 7);
    cout<<setw(8)<<"|";
    SetConsoleTextAttribute(color, 10);
    cout<<setw(16)<<"ARRIVAL";
    SetConsoleTextAttribute(color, 7);
    cout<<setw(9)<<"|";
    SetConsoleTextAttribute(color, 12);
    cout<<setw(10)<<"COST"<<endl;
    SetConsoleTextAttribute(color, 7);
    cout<<"-----------------------------------------------------------------"<<endl;

    while(list){
        SetConsoleTextAttribute(color, 9);
        cout<<setw(18)<<list->departure;
        SetConsoleTextAttribute(color, 7);
        cout<<setw(5)<<"|";
        SetConsoleTextAttribute(color, 10);
        cout<<setw(18)<<list->arrival;
        SetConsoleTextAttribute(color, 7);
        cout<<setw(7)<<"|";
        SetConsoleTextAttribute(color, 12);
        cout<<setw(10)<<"RM "<<list->cost<<endl;
        list=list->link;
    }

}

void searchNode(node *head, string location){

    system("cls");

    node *list=head;
    SetConsoleTextAttribute(color, 9);
    cout<<setw(15)<<"DEPARTURE";
    SetConsoleTextAttribute(color, 7);
    cout<<setw(8)<<"|";
    SetConsoleTextAttribute(color, 10);
    cout<<setw(16)<<"ARRIVAL";
    SetConsoleTextAttribute(color, 7);
    cout<<setw(9)<<"|";
    SetConsoleTextAttribute(color, 12);
    cout<<setw(10)<<"COST"<<endl;
    SetConsoleTextAttribute(color, 7);
    cout<<"-----------------------------------------------------------------"<<endl;

    while(list){
        if((list->departure)== location){
            SetConsoleTextAttribute(color, 9);
            cout<<setw(18)<<list->departure;
            SetConsoleTextAttribute(color, 7);
            cout<<setw(5)<<"|";
            SetConsoleTextAttribute(color, 10);
            cout<<setw(18)<<list->arrival;
            SetConsoleTextAttribute(color, 7);
            cout<<setw(7)<<"|";
            SetConsoleTextAttribute(color, 12);
            cout<<setw(10)<<"RM "<<list->cost<<endl;
        }
        list=list->link;
    }

    SetConsoleTextAttribute(color, 7);
}

string menuDisplayLL(node *head){

    string location;
    int pilihan=0;
    cout<<"       Welcome to LINKED LIST menu"<<endl<<endl;
    cout<<"  Please choose your departure location:"<<endl<<endl;
    cout<<"     ---------------------------------------"<<endl<<endl;
    Sleep(250);
    cout<<"     1) PEL.KLANG         2) JLN.KASTAM"<<endl;
    Sleep(250);
    cout<<"     3) KG. RAJA UDA      4) TELUK GADONG"<<endl;
    Sleep(250);
    cout<<"     5) TELUK PULAI       6) KLANG"<<endl;
    Sleep(250);
    cout<<"     7) BUKIT BADAK       8) PADANG JAWA"<<endl;
    Sleep(250);
    cout<<"     9) SHAH ALAM         10) BATU TIGA"<<endl;
    Sleep(250);
    cout<<"     11) SUBANG JAYA      12) SETIA JAYA"<<endl;
    Sleep(250);
    cout<<"     13) SERI SETIA       14) KG DATO HARUN"<<endl;
    Sleep(250);
    cout<<"     15) JLN.TEMPLER      16) PETALING"<<endl;
    Sleep(250);
    cout<<"     17) PANTAI DALAM     18) ANGKASAPURI"<<endl;
    Sleep(250);
    cout<<"     19) KL SENTRAL       20) KUALA LUMPUR"<<endl;
    Sleep(250);
    cout<<"     21) BANK NEGARA      22) PUTRA"<<endl;
    Sleep(250);
    cout<<"     23) SENTUL           24) BATU KENTONMEN"<<endl<<endl;
    SetConsoleTextAttribute(color, 10);
    cout<<"     Other options:"<<endl<<endl;
    cout<<"     25) DISPLAY ALL"<<endl;
    cout<<"     26) ADD NODE"<<endl;
    cout<<"     27) DELETE NODE"<<endl;
    cout<<"     0) MAIN MENU"<<endl<<endl;
    SetConsoleTextAttribute(color, 7);
    cout<<"     ---------------------------------------"<<endl<<endl;

    cout<<"YOUR CHOICE:";
    cin>>pilihan;

    switch(pilihan)
    {
        case 1:
            location="PEL.KLANG";
            break;

        case 2:
            location="JLN.KASTAM";
            break;

        case 3:
            location="KG.RAJA UDA";
            break;

        case 4:
            location="TELUK GADONG";
            break;

        case 5:
            location="TELUK PULAI";
            break;

        case 6:
            location="KLANG";
            break;

        case 7:
            location="BUKIT BADAK";
            break;

        case 8:
            location="PADANG JAWA";
            break;

        case 9:
            location="SHAH ALAM";
            break;

        case 10:
            location="BATU TIGA";
            break;

        case 11:
            location="SUBANG JAYA";
            break;

        case 12:
            location="SETIA JAYA";
            break;

        case 13:
            location="SERI SETIA";
            break;

        case 14:
            location="KG DATO HARUN";
            break;

        case 15:
            location="JLN.TEMPLER";
            break;

        case 16:
            location="PETALING";
            break;

        case 17:
            location="PANTAI DALAM";
            break;

        case 18:
            location="ANGKASAPURI";
            break;

        case 19:
            location="KL SENTRAL";
            break;

        case 20:
            location="KUALA LUMPUR";
            break;

        case 21:
            location="BANK NEGARA";
            break;

        case 22:
            location="PUTRA";
            break;

        case 23:
            location="SENTUL";
            break;

        case 24:
            location="BATU KENTONMEN";
            break;

        case 25:
            location="";
            displayNode(head);
            break;

        case 26:
            location="";
            addNodeMenu(head);
            break;

        case 27:
            location="";
            deleteNode(&head);
            break;

        case 0:
            location="mainmenu";
            break;

    }

    return location;

}

void menuLL(node *head){
    string tempat;
    char y;
    tempat=menuDisplayLL(head);
    if(tempat!="" && tempat!="mainmenu"){
        searchNode(head, tempat);
    }
    if(tempat=="mainmenu"){
        frontmenu2(head);
    }else{
        SetConsoleTextAttribute(color, 7);
        cout<<endl<<"Do you want to return to LINKED LIST menu? (y/n)"<<endl<<endl;
        cout<<"Your choice:";
        cin>>y;
        if(y=='y'){
            system("cls");
            menuLL(head);
        }else if(y=='n'){
            exit(0);
        }

    }

}

void deleteNode(node **head){
    string departure;
    string arrival;
    bool status= FALSE;

    node *tmp;
    node *cur = *head;

    cin.ignore();
    cout<<"Please choose a departure and an arrival that you want to delete"<<endl<<endl;
    cout<<"Departure:";
    getline(cin,departure);
    cout<<endl<<endl<<"Arrival:";
    getline(cin,arrival);

    cout<<"Departure:"<<departure<<"\tArrival:"<<arrival<<endl<<endl;
    if((departure==cur->departure)&&(arrival==cur->arrival)){
        tmp=cur;
        cur->departure=cur->link->departure;
        cur->arrival=cur->link->arrival;
        cur->cost=cur->link->cost;
        cur->link=cur->link->link;
        tmp=NULL;
        delete tmp;
        status= TRUE;
        cout<<"NODE DELETE!!!"<<endl;
        return;
    }else{
        do{
            if((cur->link->departure==departure)&&(cur->link->arrival==arrival)){
                tmp=cur->link;
                cur->link=tmp->link;
                delete tmp;
                status= TRUE;
                cout<<"NODE DELETED!!!"<<endl;
                return;
            }else{
                status = FALSE;
            }
            cur=cur->link;
        }while(cur->link!=NULL);

    }

    if(status== FALSE){
        cout<<"Node not found!!!"<<endl;
    }

}

void insert(nodeTree *&nodePtr, nodeTree *&newNode)
{

   if (nodePtr == NULL){
      nodePtr = newNode;                  // Insert the node.
   }
   else if (newNode->cost1 <= nodePtr->cost1){
      insert(nodePtr->left, newNode);     // Search the left branch
   }
   else if (newNode->cost1 > nodePtr->cost1){
      insert(nodePtr->right, newNode);    // Search the right branch
   }
}

void insertNode(float value1, string value2, string value3)
{
   nodeTree *newNode = NULL;	// Pointer to a new node.

   newNode = new nodeTree;
   newNode->cost1 = value1;
   newNode->departure1 = value2;
   newNode->arrival1 = value3;
   newNode->left = newNode->right = NULL;

   // Insert the node.
   insert(root, newNode);
}

void displayTreeRight()
{
     nodeTree *var=root;
     if(var!=NULL)
     {
          cout<<"\nElements are as:\n";
          while(var!=NULL)
          {
               SetConsoleTextAttribute(color, 9);
               cout<<setw(18)<<var->departure1;
               SetConsoleTextAttribute(color, 7);
               cout<<setw(5)<<"|";
               SetConsoleTextAttribute(color, 10);
               cout<<setw(18)<<var->arrival1;
               SetConsoleTextAttribute(color, 7);
               cout<<setw(7)<<"|";
               SetConsoleTextAttribute(color, 12);
               cout<<setw(10)<<"RM "<<var->cost1<<endl;
               var=var->right;
          }

     cout<<"\n";
     }
     else
     cout<<"\nStack is Empty";
}

void displayTreeLeft()
{
     nodeTree *var=root;
     if(var!=NULL)
     {
          cout<<"\nElements are as:\n";
          while(var!=NULL)
          {
               SetConsoleTextAttribute(color, 9);
               cout<<setw(18)<<var->departure1;
               SetConsoleTextAttribute(color, 7);
               cout<<setw(5)<<"|";
               SetConsoleTextAttribute(color, 10);
               cout<<setw(18)<<var->arrival1;
               SetConsoleTextAttribute(color, 7);
               cout<<setw(7)<<"|";
               SetConsoleTextAttribute(color, 12);
               cout<<setw(10)<<"RM "<<var->cost1<<endl;
               var=var->left;

          }
     cout<<"\n";
     }
     else
     cout<<"\nStack is Empty";
}

void displayInOrder(nodeTree *nodePtr)
{
   if (nodePtr)
   {
      displayInOrder(nodePtr->left);
      SetConsoleTextAttribute(color, 9);
      cout<<setw(18)<<nodePtr->departure1;
      SetConsoleTextAttribute(color, 7);
      cout<<setw(5)<<"|";
      SetConsoleTextAttribute(color, 10);
      cout<<setw(18)<<nodePtr->arrival1;
      SetConsoleTextAttribute(color, 7);
      cout<<setw(7)<<"|";
      SetConsoleTextAttribute(color, 12);
      cout<<setw(10)<<"RM "<<nodePtr->cost1<<endl;
      displayInOrder(nodePtr->right);
   }
}

void displayPreOrder(nodeTree *nodePtr)
{
   if (nodePtr)
   {
      SetConsoleTextAttribute(color, 9);
      cout<<setw(18)<<nodePtr->departure1;
      SetConsoleTextAttribute(color, 7);
      cout<<setw(5)<<"|";
      SetConsoleTextAttribute(color, 10);
      cout<<setw(18)<<nodePtr->arrival1;
      SetConsoleTextAttribute(color, 7);
      cout<<setw(7)<<"|";
      SetConsoleTextAttribute(color, 12);
      cout<<setw(10)<<"RM "<<nodePtr->cost1<<endl;
      displayPreOrder(nodePtr->left);
      displayPreOrder(nodePtr->right);
   }
}

void displayPostOrder(nodeTree *nodePtr)
{
   if (nodePtr)
   {
      displayPostOrder(nodePtr->left);
      displayPostOrder(nodePtr->right);
      SetConsoleTextAttribute(color, 9);
      cout<<setw(18)<<nodePtr->departure1;
      SetConsoleTextAttribute(color, 7);
      cout<<setw(5)<<"|";
      SetConsoleTextAttribute(color, 10);
      cout<<setw(18)<<nodePtr->arrival1;
      SetConsoleTextAttribute(color, 7);
      cout<<setw(7)<<"|";
      SetConsoleTextAttribute(color, 12);
      cout<<setw(10)<<"RM "<<nodePtr->cost1<<endl;
   }
}

void searchTree(nodeTree *root){

    nodeTree *list=root;
    float cost=0;
    bool status= FALSE;

    cout<<endl<<"Please enter the cost that you want:";
    cin>>cost;
    cout<<endl;

    while(list){
        if((list->cost1)==cost){
            SetConsoleTextAttribute(color, 9);
            cout<<setw(18)<<list->departure1;
            SetConsoleTextAttribute(color, 7);
            cout<<setw(5)<<"|";
            SetConsoleTextAttribute(color, 10);
            cout<<setw(18)<<list->arrival1;
            SetConsoleTextAttribute(color, 7);
            cout<<setw(7)<<"|";
            SetConsoleTextAttribute(color, 12);
            cout<<setw(10)<<"RM "<<list->cost1<<endl;
            status= TRUE;
        }else{
            status= FALSE;
        }

        if(cost<=(list->cost1)){
            list=list->left;
        }else if(cost>(list->cost1)){
            list=list->right;
        }

    }

    if(status== FALSE){
        cout<<"NODE CANNOT BE FOUND!!!"<<endl<<endl;
    }

}

void menuDisplayTree(node *head){

    int choice=0;

    cout<<" Welcome to TREE menu, please make your choice:"<<endl<<endl;
    Sleep(250);
    cout<<"     1) Display Tree left side"<<endl;
    Sleep(250);
    cout<<"     2) Display Tree right side"<<endl;
    Sleep(250);
    cout<<"     3) Display Preorder traversal"<<endl;
    Sleep(250);
    cout<<"     4) Display Inorder traversal"<<endl;
    Sleep(250);
    cout<<"     5) Display Postorder traversal"<<endl;
    Sleep(250);
    cout<<"     6) Search Tree"<<endl;
    Sleep(250);
    cout<<"     0) Main Menu"<<endl<<endl;
    cout<<" Your choice:";

    cin>>choice;
    switch(choice){

        case 1:
            displayTreeLeft();
            break;

        case 2:
            displayTreeRight();
            break;

        case 3:
            displayPreOrder(root);
            break;

        case 4:
            displayInOrder(root);
            break;

        case 5:
            displayPostOrder(root);
            break;

        case 6:
            searchTree(root);
            break;

    }

    if(choice==0){
        frontmenu2(head);
    }else{
        SetConsoleTextAttribute(color, 7);
        char y;
        cout<<endl<<"Do you want to return to TREE menu? (y/n)"<<endl<<endl;
        cout<<"Your choice:";
        cin>>y;
        if(y=='y'){
            system("cls");
            menuDisplayTree(head);
        }else if(y=='n'){
            exit(0);
        }
    }
}

void menuSorting(node *head){

    int choice=0;

    cout<<"    Welcome to SORTING MENU"<<endl<<endl;
    Sleep(250);
    cout<<"     1) ASCENDING SORTING"<<endl;
    Sleep(250);
    cout<<"     2) DESCENDING SORTING"<<endl;
    Sleep(250);
    cout<<"     0) MAIN MENU"<<endl<<endl;
    Sleep(250);
    cout<<" Please make your choice:"<<endl<<endl;
    cout<<" Your choice: ";
    cin>>choice;

    switch(choice){

        case 1:
            ascendingSorting();
            break;

        case 2:
            descendingSorting();
            break;

    }

    if(choice==0){
        frontmenu2(head);
    }else{
        SetConsoleTextAttribute(color, 7);
        char y;
        cout<<endl<<"Do you want to return to SORT menu? (y/n)"<<endl<<endl;
        cout<<"Your choice:";
        cin>>y;
        if(y=='y'){
            system("cls");
            menuSorting(head);
        }else if(y=='n'){
            exit(0);
        }
    }

}

void ascendingSorting(){

    int size=624;
    int counter=0;
    int x=0;
    float tempCost;
    string tempDeparture;
    string tempArrival;

    while(counter!=622){

        for(int i=0;i<size-1;i++){
            if(cost[i]>=cost[i+1]){
                tempDeparture=departure[i+1];
                tempArrival=arrival[i+1];
                tempCost=cost[i+1];

                departure[i+1]=departure[i];
                arrival[i+1]=arrival[i];
                cost[i+1]=cost[i];

                departure[i]=tempDeparture;
                arrival[i]=tempArrival;
                cost[i]=tempCost;

            }
            x=0;
        }
        for(int i=0;i<623-counter;i++){
            if(cost[623-counter]>=cost[i]){
                x++;
            }

            if(x==(622-counter)){
                counter++;
            }

        }

    }

    SetConsoleTextAttribute(color, 9);
    cout<<setw(15)<<"DEPARTURE";
    SetConsoleTextAttribute(color, 7);
    cout<<setw(8)<<"|";
    SetConsoleTextAttribute(color, 10);
    cout<<setw(16)<<"ARRIVAL";
    SetConsoleTextAttribute(color, 7);
    cout<<setw(9)<<"|";
    SetConsoleTextAttribute(color, 12);
    cout<<setw(10)<<"COST"<<endl;
    SetConsoleTextAttribute(color, 7);
    cout<<"-----------------------------------------------------------------"<<endl;

    for(int i=0; i<size;i++){
        SetConsoleTextAttribute(color, 9);
        cout<<setw(18)<<departure[i];
        SetConsoleTextAttribute(color, 7);
        cout<<setw(5)<<"|";
        SetConsoleTextAttribute(color, 10);
        cout<<setw(18)<<arrival[i];
        SetConsoleTextAttribute(color, 7);
        cout<<setw(7)<<"|";
        SetConsoleTextAttribute(color, 12);
        cout<<setw(10)<<"RM "<<cost[i]<<endl;
    }

}


void descendingSorting(){

    int size=624;
    int counter=0;
    int x=0;
    float tempCost;
    string tempDeparture;
    string tempArrival;

    while(counter!=622){

        for(int i=0;i<size-1;i++){
            if(cost[i]<=cost[i+1]){
                tempDeparture=departure[i+1];
                tempArrival=arrival[i+1];
                tempCost=cost[i+1];

                departure[i+1]=departure[i];
                arrival[i+1]=arrival[i];
                cost[i+1]=cost[i];

                departure[i]=tempDeparture;
                arrival[i]=tempArrival;
                cost[i]=tempCost;

            }
            x=0;
        }
        for(int i=0;i<623-counter;i++){
            if(cost[623-counter]<=cost[i]){
                x++;
            }

            if(x==(622-counter)){
                counter++;
            }

        }

    }

    SetConsoleTextAttribute(color, 9);
    cout<<setw(15)<<"DEPARTURE";
    SetConsoleTextAttribute(color, 7);
    cout<<setw(8)<<"|";
    SetConsoleTextAttribute(color, 10);
    cout<<setw(16)<<"ARRIVAL";
    SetConsoleTextAttribute(color, 7);
    cout<<setw(9)<<"|";
    SetConsoleTextAttribute(color, 12);
    cout<<setw(10)<<"COST"<<endl;
    SetConsoleTextAttribute(color, 7);
    cout<<"-----------------------------------------------------------------"<<endl;

    for(int i=0; i<size;i++){
        SetConsoleTextAttribute(color, 9);
        cout<<setw(18)<<departure[i];
        SetConsoleTextAttribute(color, 7);
        cout<<setw(5)<<"|";
        SetConsoleTextAttribute(color, 10);
        cout<<setw(18)<<arrival[i];
        SetConsoleTextAttribute(color, 7);
        cout<<setw(7)<<"|";
        SetConsoleTextAttribute(color, 12);
        cout<<setw(10)<<"RM "<<cost[i]<<endl;
    }


}

