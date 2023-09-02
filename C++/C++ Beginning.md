* `sizeof(double)` will give us 8, double is 8 byte
* char is a number just like int and float as a matter of a you can do something like this
```c++
char a = 65;
std::cout << a; // prints A
```

* Because things can get duplicated when we defining header files we put the `ifndef` means if not define at the beginning of the file and then define it.
``` c++
#ifndef Log_h
#define Log_h
log(const char* message); 
#endif /* Log_h */
```
we can also use `#pragma once` which will do the same thing
```c++
#pragme once
log(const char* message); 
```

* A **pointer** is just an **integer** which holds a memory address.
* A pointer **doesn't** need a **type**. however if we give it a type we are telling that a data at that address presumed to have this type.
```c++
//valid syntax, not a valid pointer though
void* ptr = nullptr; 
```
* **References** like syntax sugars for **pointers**
```c++
int a = 10;
int& ref = a;
```

* Passing a ref into a function
```c++
void Increament(int& number) {
	number++;
}

int a = 10
Increament(a);
LOG(a) //prints 11

```

## Statics
* `static` outside of class means **private to the specific file**. linker wont consider it when searching for a **definition** or when it's checking for duplication code.
*  `static` vars inside a class or struct means they are in a **same memory** in **every instance** of that class. `static` functions are the same. They don't have access to the state of the class.
```c++
struct Entity {
	static int x;
	static int Y;
};

//define static vars
int Entity::x;
int Entity::y;

//we can refering the vars like this
Entity::x = 5
Entity::y = 10
```

* If you want to override a function in base class you have to mark the base class function with `virtual`
```c++
class Entity {
 virtual std::string HelloWorld() { return "hello world entity" }
};

class Player: public Entity {
	std::string HelloWordl() override { return "hello from player" }
	//the override is not required but it's a best practice to put it there
}
```
* Interfaces
```c++
class Printable {
public:
    virtual std::string GetName() = 0;
};

class Player: public Printable {
public:
    std::string GetName() override { return "Player"; }
};

void NameOf(Printable* obj) {
    std::cout << obj->GetName() << std::endl;
}
```
## Strings
There are two ways of representing string in c++: `const char*` and `std::string`
if we declare it only with `char*` we can do something like this
```c++
char* hello = "Hello World"
hello[1] = 3 //Undefined behaviour though (compile error?)
```
* The end of the string determined by a `\0` which is telling the pointer that this is the end of the memory of array of chars.
* the standard library of c++ has also `std::string` which is actually a `const char*` underneath 
### some of the key differences 
1. Mutability: `const char*` points to constant characters, so the string it represents cannot be modified. In contrast, `std::string` objects can be modified using member functions.

3. Memory Management: With `const char*`, you are responsible for managing memory manually, whereas `std::string` automatically manages memory for you.
 
3. Length handling: For `const char*`, you need to use C-string functions like `strlen` to get the length of the string. `std::string` has a `length()` member function to get the length directly.

For appending a string at the end of another you can do this
```c++
using namespace std::string_literals;
std::string helloPWorld = "Hello"s + "World";
```
* the `s` after Hello is a `function`
* `using namespace` will bring the names with the particular namespace in current scope like:
```c++
#include <iostream>

using namespace std;

int main() {
    cout << "Hello, world!" << endl;
    return 0;
}
```
## Const
a promise that the value of a variable not going to change
```c++
const int x = 5;
```
* const for pointers
```c++
const int y = 5
const int* x = nullptr;
*x = 2 //NOT possuble
x = (int*)&y; //possible
```

```c++
const int y = 5
int* const x = nullptr;
*x = 2 //possuble
x = (int*)&y; //NOT possible
```
* consts in class
```c++
class Entity {
int x, y 
public:
	int GetX() const {
	//the const keyword ensures that we are not gonna change any state of the class
	return x;
	}
};
```
* Member wise Initializers
```c++
class Entity {
	int x, inty;
	std::string m_name;

	//Order of them shoud be EXACTLY like the properties that we declare in the class
	Entity(std::string& name) 
		: x(0),
		y(0),
		m_name(name)
	{}
};
```

## `new`
new looks for specific amounts of size based on data in memory and return a pointer and then we can do some operations with that pointer.
* if we use new we have to use `delete` when our work finished with the pointer
``` c++
int* x = new int;
x += 2;
delete x;
```