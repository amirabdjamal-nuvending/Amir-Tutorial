#include<iostream>
    using namespace std;

    bool LinSearch(double x[ ], int n, double item){

		for(int i=0;i<n;i++){
			if(x[i]==item) return true;
			else return false;
		}
		return false;
	}



    int main() {

      cout<<"Enter The Size Of Array:   ";
    int size;
    cin>>size;
    double array[size], key,i;

    // Taking Input In Array
    for(int j=0;j<size;j++){
    cout<<"Enter "<<j<<" Element : ";
    cin>>array[j];
    }
    //Your Entered Array Is
    for(int a=0;a<size;a++){
       cout<<"array[ "<<a<<" ]  =  ";
       cout<<array[a]<<endl;
    }
    cout<<"Enter Key To Search  in Array";
    cin>>key;
    bool result;
    result=LinSearch(array,size,key);
    if(result==1){
    cout<<"Key Found in Array  ";
    }
    else{
    cout<<"Key NOT Found in Array  ";
    }
       return 0;
    }
