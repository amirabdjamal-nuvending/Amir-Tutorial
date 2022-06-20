#include<iostream>
using namespace std;

int main(){
    cout<<"Hello World"<<endl;
    string fruit = "apple";
    string fruit[5] = {"orange", "pear", "strawberry", "banana"};
    for(int i = 0; i < 5; i++){
        cout<<fruit[i]<<endl;
    }
    return 0;
}