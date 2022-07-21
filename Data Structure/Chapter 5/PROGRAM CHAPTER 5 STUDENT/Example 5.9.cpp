//This is a C++ Program to Sort an Array using Bubble Sort

#include <iostream>
using namespace std;

void print (int [], int);
void bubble_sort (int [], int);

//Driver Function
int main ()
{
  int min_ele_loc;
  int ar[] = {10, 2, 45, 18, 16, 30, 29, 1, 1, 100};
  cout << "Array initially : ";
  print (ar, 10);
  bubble_sort(ar, 10);
  cout << "Array after selection sort : ";
  print (ar, 10);
  return 0;
}

// Bubble Sort
void bubble_sort (int arr[], int n)
 {
  for (int i = 0; i < n; ++i)
    for (int j = 0; j < n - i - 1; ++j)
      if (arr[j] > arr[j + 1])
     {
        int temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
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


