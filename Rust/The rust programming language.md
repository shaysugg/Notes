 [Source](https://doc.rust-lang.org/book/)
## Variables
immutable variables:  `let x = 5;`
mutable variables:  `let mut x = 5;`
constants:  `THREE_HOURS_IN_SECONDS: u32 = 60 * 60 * 3;`
constants differences with variables:
* `mut` isn't allowed with constants
* type of the value _must_ be annotated.
* constants may be set only to a constant expression, not the result of a value that could only be computed at runtime:?
*Shadowing* is define a multiple variable with a same name in a scope. It's helpful to avoid rewriting different name for variables.
```rust
    let spaces = "   ";
    let spaces = spaces.len();
```
## Data types
### Scalar
**Integers:**
signed: i8, i16, i32, ...
unsigned: u8, u16, u32, ...
isize = arch(?)
`i32` good to be used as default

**Floats:**
f64 and f32

**Characters**
Rust’s `char` type is four bytes in size and represents a Unicode Scalar Value: emojies, Chinese, ...
```rust
let c: char = 'z';
```
### Compound
>Compound types_ can group multiple values into one type.

**Tuple**
```rust
let tup: (i32, f64, u8) = (500, 6.4, 1);
let five_hundred = x.0;
```

**Array**
Arrays data are allocated on the stack
We always have a fixed number of elements
_vector_ is a similar collection type provided by the standard library that _is_ allowed to grow or shrink in size
```rust
//simple array
let a = [1, 2, 3, 4, 5];
//array with repeated items
let a = [3; 5]; //`[3, 3, 3, 3, 3]`
```
Rust arrays access have bounds check and prevent accessing unrelated memories.
## Functions
Function bodies are made up of a series of statements optionally ending in an expression
- **Statements** are instructions that perform some action and do not return a value.
- **Expressions** evaluate to a resultant value.
The following code are all expressions
* `5 + 6`
* in `let y = 6` the`6` is an expression.
* Calling a function is an expression. Calling a macro is an expression.
* A scope block is an expression
```rust
let y = {
        let x = 3;
        x + 1 //note that this line doesn't have ;
    };
```
*If you add a semicolon to the end of an expression, you turn it into a statement*
### Function with return values
```rust
fn plus_one(x: i32) -> i32 {
    x + 1 
}
```
## Control Flow
if in a let statement
```rust
let number = if condition { 5 } else { 6 };
```
return values from loop
```rust
let mut counter = 0;

    let result = loop {
        counter += 1;

        if counter == 10 {
            break counter * 2;
        }
    };
```
## OwnerShip
If we reassign a reference type to another variable instead of having two pointers in one scope rust move the reference to the new variable and the first variable will be invalid. (at compile time)
```rust
let s1 = String::from("yo");
let s2 = s1;
println!("{s1}"); //Error: borrow of moved value: `s1`
```
Same behavior  happens if we pass a value to a function. After passing the value, it's not going to be available in the scope!
```rust
fn main() {
    let s = String::from("hello");  // s comes into scope
	// s's value moves into the function...
	// ... and so is no longer valid here
    takes_ownership(s);             
    
    let x = 5;                      // x comes into scope
    
	// x would move into the function,
	// but i32 is Copy, so it's okay to still
	// use x afterward
    makes_copy(x);                  

} // Here, x goes out of scope, then s. But because s's value was moved, nothing
  // special happens.

fn takes_ownership(some_string: String) { 
	// some_string comes into scope
    println!("{some_string}");
} // Here, some_string goes out of scope and `drop` is called. The backing
  // memory is freed.

fn makes_copy(some_integer: i32) { 
	// some_integer comes into scope
    println!("{some_integer}");
} // Here, some_integer goes out of scope. Nothing special happens.
```
==Rust uses a feature for using a value without transferring ownership, called _references_.==
### References
```rust
fn main() {
    let s1 = String::from("hello");

    let len = calculate_length(&s1);

    println!("The length of '{s1}' is {len}.");
}

fn calculate_length(s: &String) -> usize {
    s.len()
}
```
In `calculate_length`we take `&String` rather than `String`. These ampersands represent _references_, and they allow you to **refer to some value without taking ownership of it.** 
You can only read the value of s if you want to change it you have to use `mut &String` for the type
```rust
fn main() {
    let mut s = String::from("hello");

    change(&mut s);
}

fn change(some_string: &mut String) {
    some_string.push_str(", world");
}
```
#### mutable references restrictions
Mutable references have **one big restriction**: ==if you have a mutable reference to a value, you can have no other references to that value==. The follow example will produce an error
```rust
let mut s = String::from("hello");
    let r1 = &mut s;
    let r2 = &mut s;
    println!("{}, {}", r1, r2);
//Error: cannot borrow `s` as mutable more than once at a time
```
This feature will prevent all source of data races at compile time.
> Data races happens when;
>- Two or more pointers access the same data at the same time.
>- At least one of the pointers is being used to write to the data.
>- There’s no mechanism being used to synchronize access to the data.

Same rule applied when we have two immutable references and one mutable reference;
```rust
    let mut s = String::from("hello");

    let r1 = &s; // no problem
    let r2 = &s; // no problem
    let r3 = &mut s; // BIG PROBLEM

    println!("{}, {}, and {}", r1, r2, r3);
//Error: cannot borrow `s` as mutable because it is also borrowed as immutable
```
However note that: ==a reference’s scope starts from where it is introduced and continues through the last time that reference is used.== which means the following code will be possible
```rust
    let mut s = String::from("hello");

    let r1 = &s; // no problem
    let r2 = &s; // no problem
    println!("{r1} and {r2}");
    // 🔴 variables r1 and r2 will not be used after this point

    let r3 = &mut s; // no problem
    println!("{r3}");
```

Rust also prevents dangling pointers
```rust
fn dangle() -> &String { // dangle returns a reference to a String

    let s = String::from("hello"); // s is a new String
    
    &s // we return a reference to the String, s
} // Here, s goes out of scope, and is dropped. Its memory goes away.
  // Danger!

fn no_dangle() -> String {
    let s = String::from("hello");
    s
}
```
### Slice
>_Slices_ let you reference a contiguous sequence of elements in a [collection](https://doc.rust-lang.org/book/ch08-00-common-collections.html) rather than the whole collection.

string slice type: `&str`
array with i32 elements: `&[i32]`

Consider the following example. `word` will be invalid after `s.clear()` is called.
```rust
fn main() {
    let mut s = String::from("hello world");
    let word = first_word(&s); // word will get the value 5
    
    s.clear(); 
    // this empties the String, making it equal to ""
    // word still has the value 5 here, but there's no more string that
    // we could meaningfully use the value 5 with. word is now totally invalid!
}

fn first_word(s: &String) -> usize {
//...
}
```
one way we can prevent this issue at compile time is to return a slice of string instead of `usize`.
```rust
fn first_word(s: &String) -> &str {
    let bytes = s.as_bytes();
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i]; //defining a slice
        }
    }
    &s[..]
}
```
if we applied this change to our first_word function then at s.clear we will get a compile error.
## Structs
```rust
struct User {
    active: bool,
    username: String,
    email: String,
    sign_in_count: u64,
}

// omit the parameter name of structs fields username and email
// because they match the function parameters
fn build_user(email: String, username: String) -> User {
    User {
        active: true,
        username,
        email,
        sign_in_count: 1,
    }
}

//if we want to only change some parameters of an existing struct
fn copy_user_with_a_new_email(base_user: User) {
    let user2 = User {
        email: String::from("another@example.com"),
        ..base_user
    };
}

//tuple structs
//they don't have name for their variiables
struct Color(i32, i32, i32);
let black = Color(0, 0, 0);
```
## enums
simple enums
```rust
enum IpAddrKind {
    V4,
    V6,
}
```
enums with associated values
```rust
enum IpAddr {
        V4(String),
        V6(String),
    }

    let home = IpAddr::V4(String::from("127.0.0.1"));

    let loopback = IpAddr::V6(String::from("::1"));
```
rust doesn't have null at language level. But for getting null traits we can use the [Option](https://doc.rust-lang.org/std/option/enum.Option.html) that has been defined in the standard library
```rust
enum Option<T> {
    None,
    Some(T),
}

let some_number = Some(5);
let some_char = Some('e');
let absent_number: Option<i32> = None;
```

### match and enums
handling an option with match
```rust
fn plus_one(x: Option<i32>) -> Option<i32> {
    match x {
        None => None,
        Some(i) => Some(i + 1),
    }
}
```
handling other matches or catch all using `_`
```rust
let dice_roll = 9;
    match dice_roll {
        3 => add_fancy_hat(),
        7 => remove_fancy_hat(),
        _ => reroll(),
    }
```
If we want to get the catch all value 
```rust
match dice_roll {
        3 => add_fancy_hat(),
        7 => remove_fancy_hat(),
        other => move_player(other),
    }
```
a match that nothings happens within it
```rust
//...
_ => (),
```
### if let
we can use if let to only match one specific pattern
```rust
let mut count = 0;
    if let Coin::Quarter(state) = coin {
        println!("State quarter from {state:?}!");
    } else {
        count += 1;
    }
```
this also can be really useful for handling `Option`s
```rust
let config_max = Some(3u8);
    if let Some(max) = config_max {
        println!("The maximum is configured to be {max}");
    }
```
## Code organization
- **Packages:** A Cargo feature that lets you build, test, and share crates
- **Crates:** A tree of modules that produces a library or executable
- **Modules** and **use:** Let you control the organization, scope, and privacy of paths
- **Paths:** A way of naming an item, such as a struct, function, or module
==TODO==
## Collections
types that are stored on heap and can have dynamic allocated memory
### Vectors
creating vectors
```rust
let v: Vec<i32> = Vec::new();
let v = vec![1, 2, 3];
```
Reading elements
```rust
//note that you borrow a reference

let third: &i32 = &v[2]; 
//if the index is out of range rust will panic

let third: Option<&i32> = v.get(2);
//this is an option that can be none if the index is not in range
```
mutating while having a reference
```rust
let mut v = vec![1, 2, 3, 4, 5];
let first = &v[0];
v.push(6);
println!("The first element is: {first}");

//Error: cannot borrow `v` as mutable because it is also borrowed as immutable
```
Reason of not being able to borrow:
>Adding a new element onto the end of the vector might require allocating new memory and copying the old elements to the new space, if there isn’t enough room to put all the elements next to each other where the vector is currently stored. In that case, the reference to the first element would be pointing to deallocated memory.

Iterating over the values
```rust
let v = vec![100, 32, 57];
for i in &v {
    println!("{i}");
}

let mut v = vec![100, 32, 57];
    for i in &mut v {
        *i += 50;
    }
```
enums for storing multiple type in vector
```rust
enum SpreadsheetCell {
    Int(i32),
    Float(f64),
    Text(String),
}
let row = vec![
    SpreadsheetCell::Int(3),
    SpreadsheetCell::Text(String::from("blue")),
    SpreadsheetCell::Float(10.12),
];
```
## String
Different methods to create `String`
```rust
let mut s = String::new();
let s = "initial contents".to_string();
let s = String::from("initial contents");
```
Change strings
```rust
s1.push_str(s2);
s1.push('l');
let s3 = s1 + &s2; //the second one is slice
```
Complex formats
```rust
let s = s1 + "-" + &s2 + "-" + &s3;
let s = format!("{s1}-{s2}-{s3}"); //works like println!
```

indexing with numbers in string is not possible
Also pay attention when slicing a string because some characters can be more than one byte. It's up to us to decide
```rust
let hello = "Здравствуйте";
let s = &hello[0..4]; //will produce Зд
```

Iterating through strings
```rust
for c in "Зд".chars() {
    println!("{c}");
}
// З, д

for b in "Зд".bytes() {
    println!("{b}");
}
//208, 151, 208, 180
```
## HashMaps
we need to `use` the `HashMap`
```rust
use std::collections::HashMap;
```
No shortcuts or macro for building them. we have to build them like
```rust
let mut scores = HashMap::new();

scores.insert(String::from("Blue"), 10);
scores.insert(String::from("Yellow"), 50);

let team_name = String::from("Blue");
//this will copy and unwrap the Option with a default value of 0
let score = scores.get(&team_name).copied().unwrap_or(0);
```
HasMap will take the **ownership of its keys**

Updating HashMap values can be done with
Overwriting
```rust
 scores.insert(String::from("Blue"), 25);
```
Adding a Key and Value Only If a Key Isn’t Present
```rust
scores.entry(String::from("Yellow")).or_insert(50);
```
Updating a value based on the old value
```rust
let text = "hello world wonderful world";
let mut map = HashMap::new();

for word in text.split_whitespace() {
    let count = map.entry(word).or_insert(0);
    *count += 1; //note the *!
}
```
>Here, we store that mutable reference in the `count` variable, so in order to assign to that value, we must first dereference `count` using the asterisk (`*`)

## Errors
none recoverable
`panic!("message")`

recoverable
```rust
enum Result<T, E> {
    Ok(T),
    Err(E),
}
```
Handling a results
with match:
```rust
let greeting_file = match greeting_file_result {
	Ok(file) => file,
	Err(error) => panic!("Problem opening the file: {error:?}"),
};
```
unwrap or expect for panicing and  stop the execution
```rust
File::open("hello.txt").unwrap();
File::open("hello.txt").expect("hello.txt should be included in this project");
```
Propagating errors: if the error matches with and function return error result type or can be converted to then we can use `?` at the end of function call that returns result to return the error and make sure if the execution is continued then the result was `OK`
```rust
fn read_username_from_file() -> Result<String, io::Error> {
    let mut username_file = File::open("hello.txt")?;
    let mut username = String::new();
    username_file.read_to_string(&mut username)?; //<-
    Ok(username)
}
```
## Generics
Function definition
```rust
fn largest<T>(list: &[T]) -> &T 
```
Struct defination
```rust
struct Point<T, U> {
    x: T,
    y: U,
}
```
enum definition `Result<T, E>`
Method definition
```rust
struct Point<T> {
    x: T,
    y: T,
}

impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
}
```
generics in rust doesn't have impacts on performance
### Traits
```rust
pub trait Summary {
    fn summarize(&self) -> String;
}

//with default implementation
pub trait Summary {
    fn summarize(&self) -> String {
        String::from("(Read more...)")
    }
}
```
Implementing a trait on type
```rust
impl Summary for NewsArticle {
	fn summarize(&self) -> String {
		format!("{}, by {} ({})", self.headline, self.author, self.location)
	}
}
```
One restriction to note is that we can implement a trait on a ==type only if either the trait or the type, or both, are local to our crate==
*For example we can’t implement the `Display` trait on `Vec<T>` in our local crate*

Use traits as parameters
```rust
pub fn notify(item: &impl Summary) {
    println!("Breaking news! {}", item.summarize());
}

//previouse example is a syntax suger for this one
pub fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}
```
combining multiple traits
```rust
pub fn notify(item: &(impl Summary + Display)) 
//or
pub fn notify<T: Summary + Display>(item: &T) {
```
use where to apply conditions on generics
```rust
fn some_function<T, U>(t: &T, u: &U) -> i32
where
    T: Display + Clone,
    U: Clone + Debug,
{
    
```
conditionally implement methods
```rust
struct Pair<T> {
    x: T,
    y: T,
}

impl<T: Display + PartialOrd> Pair<T> {
    fn cmp_display(&self) {
        if self.x >= self.y {
            println!("The largest member is x = {}", self.x);
        } else {
            println!("The largest member is y = {}", self.y);
        }
    }
}
```
### Lifetimes
Since rust is a language that determines the time of a reference existence by lifetimes sometimes we need to provide some guidance for compiler when defining our functions and structs.
let's say we have this function that wont compile
```rust
fn longest(x: &str, y: &str) -> &str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
==Rust can’t tell whether the reference being returned refers to `x` or `y`.==
to fix this problem we can use lifetime annotations: `'a`
```rust
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
>The function signature now tells Rust that for some lifetime `'a`, the function takes two parameters, both of which are string slices that live at least as long as lifetime `'a`. The function signature also tells Rust that the string slice returned from the function will live at least as long as lifetime `'a`. In practice, it means that the lifetime of the reference returned by the `longest` function is the same as the smaller of the lifetimes of the values referred to by the function arguments.

As a result this code will work
```rust
fn main() {
    let string1 = String::from("long string is long");

    {
        let string2 = String::from("xyz");
        let result = longest(string1.as_str(), string2.as_str());
        println!("The longest string is {result}");
    }
}
```
whereas this code won't
```rust
fn main() {
    let string1 = String::from("long string is long");
    let result;
    {
        let string2 = String::from("xyz");
        result = longest(string1.as_str(), string2.as_str());
    }
    println!("The longest string is {result}"); 
    // 🔴 for `result` to be valid for the `println!` statement `string2` would need to be valid until the end of the outer scope!
}
```

Lifetime is structs
```rust
struct ImportantExcerpt<'a> {
    part: &'a str, //<- an instance of `ImportantExcerpt` can’t outlive the reference it holds in its `part` field.
}

fn main() {
    let novel = String::from("Call me Ishmael. Some years ago...");
    let first_sentence = novel.split('.').next().unwrap();
    let i = ImportantExcerpt {
        part: first_sentence,
    };
    //✅ i and novel exists in the sam scope and will leave the scope together
}
```
#### Three lifetime rules
these rules helps the compiler to indicate lifetimes and we don't need to specify timelines in these situations
1) The compiler assigns a lifetime parameter to each parameter that’s a reference.
2) If there is exactly one input lifetime parameter, that lifetime is assigned to all output lifetime parameters
3) if there are multiple input lifetime parameters, but one of them is `&self` or `&mut self` because this is a method, the lifetime of `self` is assigned to all output lifetime parameters.
that's why we don't need to provide lifetime for this
```rust
fn first_word(s: &str) -> &str {
```
as the compiler will provide the lifetime and the signature will be
```rust
fn first_word<'a>(s: &'a str) -> &str {
```
another example that would work
```rust
impl<'a> ImportantExcerpt<'a> {
    fn announce_and_return_part(&self, announcement: &str) -> &str {
        println!("Attention please: {announcement}");
        self.part
    }
}
```

lifetime can be defined static which means they're going to exist for the entire duration of program
```rust
let s: &'static str = "I have a static lifetime.";
```
### A complete example
Generics + Traits Bounds+ Lifetimes
```rust
fn longest_with_an_announcement<'a, T>(
    x: &'a str,
    y: &'a str,
    ann: T,
) -> &'a str
where
    T: Display,
{
    println!("Announcement! {ann}");
    if x.len() > y.len() {
        x
    } else {
        y
    }
}
```
## Tests
A simple test
```rust
pub fn add(left: usize, right: usize) -> usize {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn exploration() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
```
`assert!` `assert_eq!` `assert_nq!` can be evaluate results

If panic should be expected behavior of a function then we can use
```rust
#[test]
#[should_panic(expected = "less than or equal to 100")]
fn greater_than_100() {
    Guess::new(200);
}
```
expected in should panic can be a `substring` of panic message.

`Result`s can be used as an evaluation of tests:
```rust
#[test]
fn it_works() -> Result<(), String> {
//...
}
```
### Controlling how tests are run
for making test to not be executed in pararell
```console
cargo test -- --test-threads=1
```
showing function outputs like `println!`
```console
cargo test -- --show-output
```
filtering which tests to run 
```shell
cargo test test_name
#test_name can be a substring of multiple tests or exact name of a test
```
## closures
```rust
fn  add_one_v1   (x: u32) -> u32 { x + 1 }
let add_one_v2 = |x: u32| -> u32 { x + 1 };
let add_one_v3 = |x|             { x + 1 };
let add_one_v4 = |x|               x + 1  ;
```

If we don't define types for closures once they're evaluated by compiler they cannot be changed furthermore, in the below example the `let n` would failed because compiler considered x type in closure to be a `String`
```rust
let example_closure = |x| x;

    let s = example_closure(String::from("hello"));
    let n = example_closure(5);
```
### Capturing values
Closures can capture values from their environment in three ways:
- borrowing immutably,
- borrowing mutably,
- and taking ownership.

borrowing `list` immutably:
```rust
let list = vec![1, 2, 3];
    println!("Before defining closure: {list:?}");

    let only_borrows = || println!("From closure: {list:?}");

    println!("Before calling closure: {list:?}");
    only_borrows();
    println!("After calling closure: {list:?}");
```
It's valid because we can have multiple immutable reference to a variable

borrowing `list` mutably:
```rust
fn main() {
    let mut list = vec![1, 2, 3];
    println!("Before defining closure: {list:?}");

    let mut borrows_mutably = || list.push(7);

    borrows_mutably();
    println!("After calling closure: {list:?}");
}
```
It's valid because we didn't read the value between capturing and calling the closure. After closure is called it's ok to reference it.

taking the owner ship by using `move`
```rust
fn main() {
    let list = vec![1, 2, 3];
    println!("Before defining closure: {list:?}");

    thread::spawn(move || println!("From thread: {list:?}"))
        .join()
        .unwrap();
}
```
note that `list` ownership is taken by the closure and it's no longer usable in the scope
### Closure Traits
1. `FnOnce` applies to closures that can be called once. All closures implement at least this trait, because all closures can be called. **A closure that moves captured values out of its body** will only implement `FnOnce` and none of the other `Fn` traits, because it can only be called once.
2. `FnMut` applies to closures that **don’t move captured values out of their body, but that might mutate the captured values**. These closures can be called more than once.
3. `Fn` **applies to closures that don’t move captured values out of their body and that don’t mutate captured values, as well as closures that capture nothing from their environment**. These closures can be called more than once without mutating their environment, which is important in cases such as calling a closure multiple times concurrently.
### Iterators
By calling `.iter` on types that have Iterator traits we get the iterator and we can cal functions like map or filter on it
to turn an iterator to a vector we use `collect()`
## Smart pointers
>Rust, with its concept of ownership and borrowing, has an additional difference between references and smart pointers: while references only borrow data, in many cases, smart pointers _own_ the data they point to.

some common smart pointers in standard library
- `Box<T>` for allocating values on the heap
- `Rc<T>`, a reference counting type that enables multiple ownership
- `Ref<T>` and `RefMut<T>`, accessed through `RefCell<T>`, a type that enforces the borrowing rules at runtime instead of compile time
### `Box<T>`
- When you have a type whose size can’t be known at compile time and you want to use a value of that type in a context that requires an exact size

- When you have a large amount of data and you want to transfer ownership but ensure the data won’t be copied when you do so
- When you want to own a value and you care only that it’s a type that implements a particular trait rather than being of a specific type
```rust
trait Shape {
    fn area(&self) -> f64;
}

struct Circle {
    radius: f64,
}

impl Shape for Circle {
    fn area(&self) -> f64 {
        std::f64::consts::PI * self.radius * self.radius
    }
}

let shapes: Vec<Box<dyn Shape>> = vec![Box::new(Circle { radius: 2.0 })];

```

#### Implementing `cons` with `Box<T>`
`cons` are like linked list. Each item knows the next item. If we want to store a data of `cons` on stack rust will give us an error because it can compute the recursive total amount of memory that it needs.
```rust
enum List {
    Cons(i32, List), //<- recurrsion
    Nil,
}
```
by using boxes *as an address of some place in heap* we can tell the compiler that consider the size of an address which is determined, instead of size of a type
```rust
enum List {
    Cons(i32, Box<List>),
    Nil,
}

use crate::List::{Cons, Nil};

fn main() {
    let list = Cons(1, Box::new(Cons(2, Box::new(Cons(3, Box::new(Nil))))));
}
```
## `Rc<T>`
Multiple point to a data on heap with reference counting
The previous example won't allow us to point multiple time to a the same `List`. Here we used Rc to achieve that.
```rust
fn main() {
    let a = Rc::new(Cons(5, Rc::new(Cons(10, Rc::new(Nil)))));
    let b = Cons(3, Rc::clone(&a));
    let c = Cons(4, Rc::clone(&a));
}
```
key difference with box
1. **Ownership**:
    - `Box` has single ownership.
    - `Rc` allows multiple owners.
2. **Use Case**:
    - Use `Box` when you need a single owner for heap-allocated data.
    - Use `Rc` when you need shared ownership of data.
3. **Performance**:
    - `Box` has no overhead for reference counting.
    - `Rc` incurs some overhead due to maintaining the reference count.
4. **Mutability**:
    - `Box` can be mutable if you use `Box<T>` where `T` is mutable.
    - `Rc` does not allow mutable access directly. If you need mutable access, you can use `Rc<RefCell<T>>`, which allows interior mutability.
**`Rc<T>` only used for single-thread scenarios.**
### `RefCell<T>`
TODO
### `Weak<T>`
TODO
## Concurrency
make threads with `thread::spawn`
wait for threads to be finished with `join`
```rust
let handle = thread::spawn(|| {
    for i in 1..10 {
        println!("hi number {i} from the spawned thread!");
        thread::sleep(Duration::from_millis(1));
    }
});

handle.join().unwrap(); //<- code exe will be stopped here until the thread work finishes
```
move reference of value that we need in a thread by move
```rust
let v = vec![1, 2, 3];

let handle = thread::spawn(move || {
    println!("Here's a vector: {v:?}");
});

//v ownership was taken and would not be available here  
```
### Transferring data between threads
>“Do not communicate by sharing memory; instead, share memory by communicating.”

#### Sending values to a channel instead of modifying a shared variable directly
Create a channel and get a tuple of transmitter and reciever
`mpsc` stands for _multiple producer, single consumer_
```rust
use std::sync::mpsc;
use std::thread;

fn main() {
    let (tx, rx) = mpsc::channel();


thread::spawn(move || {
        let val = String::from("hi");
        tx.send(val).unwrap();
    });

    let received = rx.recv().unwrap();
    println!("Got: {received}");
}
```
`recv` will block the current thread's execution and wait for the value. the value that will be received is a `Result` type where it's errors can happen when no more values will be coming.
`try_recv` will not block. but you need to call it until you get an `Ok`. *usually in a loop or something*

by `tx.clone()` we can send multiple transmitters to different threads and have one receiver that receives their event. 

#### Mutex for allowing access to data from one thread at a time
- You must attempt to acquire the lock before using the data.
- When you’re done with the data that the mutex guards, you must unlock the data so other threads can acquire the lock.
```rust
use std::sync::Mutex;

fn main() {
    let m = Mutex::new(5);

    {
        let mut num = m.lock().unwrap();
        *num = 6; //<- Dereferencing, num type is `MutexGuard`
    }

    println!("m = {m:?}");
}
```

##### Using `Arc` to handle multiple reference to a Mutex

Sum from 0 to 10 with different threads
Use `Arc` so we can have multiple ownership to a same data by holding its reference
```rust
fn main() {
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];

    for _ in 0..10 {
        let counter = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            let mut num = counter.lock().unwrap();

            *num += 1;
        });
        handles.push(handle);
    }

    for handle in handles {
        handle.join().unwrap();
    }

    println!("Result: {}", *counter.lock().unwrap());
}
```

`Refcell` -> `Mutex`
`Rc` -> `Arc`
### Rust language Concurrency features
* The `Send` marker trait indicates that ownership of values of the type implementing `Send` can be transferred between threads.
* The `Sync` marker trait indicates that it is safe for the type implementing `Sync` to be referenced from multiple threads.