## Header
```cpp
#ifndef MYCLASS_H
#define MYCLASS_H

class MyClass {
private:
    int myProperty;

public:
    // Constructors
    MyClass();  // Default constructor
    MyClass(int initialValue);  // Parameterized constructor

    // Destructor
    ~MyClass();

    // Setter and Getter
    void setMyProperty(int value);
    int getMyProperty() const;

    // Member function
    void regularFunction();

    // Static function
    static void staticFunction();
};

#endif // MYCLASS_H

```
## Implementation 
```cpp
#include "MyClass.h"
#include <iostream>

// Default constructor
MyClass::MyClass() : myProperty(0) {
    // Initialization code
}

// Parameterized constructor
MyClass::MyClass(int initialValue) : myProperty(initialValue) {
    // Initialization code
}

// Destructor
MyClass::~MyClass() {
    // Cleanup code
}

// Setter
void MyClass::setMyProperty(int value) {
    myProperty = value;
}

// Getter
int MyClass::getMyProperty() const {
    return myProperty;
}

// Member function
void MyClass::regularFunction() {
    std::cout << "Regular function called!\n";
}

// Static function
void MyClass::staticFunction() {
    std::cout << "Static function called!\n";
}
```
## Usage
```c++
#include "MyClass.h" // Include the header file

int main() {
	//Direct Instansiating
	MyClass obj;  // Instantiating an object of MyClass
	obj.setMyProperty(10); // Accessing member functions using dot operator

    ////Instansiating with pointer
    MyClass *ptr = new MyClass();
    ptr->setMyProperty(10); // Set the value of myProperty to 10
	// Don't forget to delete the dynamically allocated object
    delete ptr;

    return 0;
}
```
Pointers offer flexibility and control but require careful memory management, while direct object instantiation is simpler and safer but offers less flexibility in certain scenarios.