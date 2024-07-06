1. Accessing array elements using pointers:
```c
int arr[] = {1, 2, 3, 4, 5};
int *ptr = arr; // ptr points to the first element of the array

printf("%d", *ptr); // Output: 1
printf("%d", *(ptr + 1)); // Output: 2
```

2. Iterating through an array using pointers:
```c
int arr[] = {1, 2, 3, 4, 5};
int *ptr = arr;
int i;

for (i = 0; i < 5; i++) {
    printf("%d ", *ptr);
    ptr++;
}
// Output: 1 2 3 4 5
```

3. Passing an array to a function using pointers:
```c
void printArray(int *arr, int size) {
    int i;
    for (i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
}

int main() {
    int arr[] = {1, 2, 3, 4, 5};
    printArray(arr, 5);
    // Output: 1 2 3 4 5
    return 0;
}
```

4. Dynamic memory allocation for arrays using pointers:
```c
int *allocateArray(int size) {
    int *arr = (int *)malloc(size * sizeof(int));
    return arr;
}

int main() {
    int *myArray = allocateArray(5);
    // Use the dynamically allocated array
    free(myArray); // Don't forget to free the memory
    return 0;
}
```

5. Pointer arithmetic with arrays:
```c
int arr[] = {1, 2, 3, 4, 5};
int *ptr = arr;

printf("%d", *ptr); // Output: 1
printf("%d", *(ptr + 2)); // Output: 3
printf("%d", *(arr + 3)); // Output: 4
```

These examples demonstrate how pointers and arrays work together in C programming, allowing you to access, manipulate, and pass arrays using pointer arithmetic and pointer-based operations.