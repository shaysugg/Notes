>When the software has attempted to access a restricted area of memory (a memory access violation).
## Causes
* Dereference a null pointer
```cpp
int *p = NULL;
*p = 1;
```
* Write to a portion of memory that was marked as read-only
```c++
char *str = "Foo"; // Compiler marks the constant string as read-only
*str = 'b'; // Which means this is illegal and results in a segfault
```
* Dangling pointer points to a thing that does not exist anymore, like here:
```cpp
char *p = NULL;
{
    char c;
    p = &c;
}
// Now p is dangling
```
The pointer `p` dangles because it points to the character variable `c` that ceased to exist after the block ended. And when you try to dereference dangling pointer (like `*p='A'`), you would probably get a `segfault`.