## Abstraction
Abstraction is a model of a real-world object or phenomenon, limited to a specific context, which represents all details relevant to this context with high accuracy and omits all the rest.
**Example:**
Abstraction of an airplane:
**in flighting simulator**: has speed, roll angle and can fly
**in flighting book**: has seats numbers
## Enacpsulation
Encapsulation is the ability of an object to **hide** parts of its **state** and **behaviors** from other objects, exposing only a limited interface to the rest of the program.
To encapsulate something means to make it `private`
**Note:**
**Interfaces** and **abstract classes/methods** of most programming languages are based on the concepts of **abstraction** and **encapsulation**
## Inheritence
Inheritance is the ability to build new classes on top of existing ones. The main benefit of inheritance is code reuse.
It looks powerfull when it come to reuse codes but have a lots of disadvantages like:
- A subclass can’t reduce the interface of the superclass.
- When overriding methods you need to make sure that the new behavior is compatible with the base one.
- Inheritance breaks encapsulation of the superclass.
- Subclasses are tightly coupled to superclasses.
- Trying to reuse code through inheritance can lead to creating parallel inheritance hierarchies.
## Polymorphism
Polymorphism is the ability of a program to detect the real class of an object and call its implementation even when its real type is unknown in the current context.


