#include <iostream>
using namespace std;
int arrsum(int *x,int y);

int main()
{
 int p=5;
 int arr[]={0,1,2,3,4};
 cout<<arrsum(arr,p);

   return 0;
}

int arrsum(int *x,int y){

int total=0;
for(int i=0;i<y;i++){
   if(x[i]>x[i+1]);
   {
       total=x[i];
   }

}
return total;

}
