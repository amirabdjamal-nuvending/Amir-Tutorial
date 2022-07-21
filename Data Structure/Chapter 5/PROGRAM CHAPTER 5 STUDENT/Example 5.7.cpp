//This is a C++ Program to Sort an Array using Insertion Sort

#include <iostream>
using namespace std;

void print (int [], int);
void insertion_sort (int [], int);

//Driver Function
int main ()
{
  int min_ele_loc;
  int ar[] = {10, 2, 45, 18, 16, 30, 29, 1, 1, 100};
  cout << "Array initially : ";
  print (ar, 10);
  insertion_sort (ar, 10);
  cout << "Array after selection sort : ";
  print (ar, 10);
  return 0;
}

// Insertion Sort
void insertion_sort (int arr[], int length){
	 	int j, temp;

	for (int i = 0; i < length; i++){
		j = i;

		while (j > 0 && arr[j] < arr[j-1]){
			  temp = arr[j];
			  arr[j] = arr[j-1];
			  arr[j-1] = temp;
			  j--;
			  }
		}
}

//Print the array
void print (int temp_ar[], int size)
{
  for (int i = 0; i < size; ++i)
  {
    cout << temp_ar[i] << " ";
  }
  cout << endl;
}


