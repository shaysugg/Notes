
1. Syntax:
   - Pointers: Pointers are variables that store memory addresses. They are declared using the `*` symbol and need to be explicitly dereferenced to access the value they point to.
   ```cpp
   int* ptr; // Declaration of a pointer to an integer
   ```
   - References: References are essentially aliases to existing variables. They are declared using the `&` symbol and do not require explicit dereferencing. References must be initialized at the point of declaration and cannot be re-assigned to point to another variable after initialization.
   ```cpp
   int num = 42;
   int& ref = num; // Declaration of a reference to an integer, ref is an alias to num
   ```

2. Nullability:
   - Pointers: Pointers can be assigned a null value (nullptr) to indicate that they are not pointing to any valid memory address.
   ```cpp
   int* ptr = nullptr; // ptr is a null pointer
   ```
   - References: References must always be initialized and cannot be null. Once a reference is bound to a variable, it remains bound to that variable for its lifetime.

3. Reassignment:
   - Pointers: Pointers can be re-assigned to point to different memory locations throughout their lifetime.
   ```cpp
   int num1 = 10, num2 = 20;
   int* ptr = &num1;
   ptr = &num2; // ptr now points to num2
   ```
   - References: References cannot be re-assigned to point to a different variable after initialization. Once a reference is initialized, it acts as an alias to that variable for the remainder of its scope.
   ```cpp
   int num1 = 10, num2 = 20;
   int& ref = num1;
   // ref = &num2; // Error: References cannot be re-assigned to another variable
   ```

4. Memory Manipulation:
   - Pointers: Pointers allow direct manipulation of memory, including pointer arithmetic and manual memory allocation/deallocation with `new` and `delete`.
   - References: References do not provide direct access to memory manipulation. They are mainly used as a convenient way to access and modify the underlying variable.

5. Function Parameters:
   - Pointers: Pointers are commonly used to pass arguments to functions, especially when you need to modify the original value inside the function.
   ```cpp
   void modifyValue(int* ptr) {
       *ptr = 100; // Modifies the value at the memory address pointed to by ptr
   }
   ```
   - References: References are used for the same purpose as pointers, but they provide a more readable syntax. They are often preferred for passing parameters when no nullability is required.
   ```cpp
   void modifyValue(int& ref) {
       ref = 100; // Modifies the original value directly
   }
   ```