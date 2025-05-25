Compiling objective-c main file with clang
```bash
clang -fobjc-arc main.m -o prog1
```
## Simple class implementation
```objective-c
@interface Fraction : NSObject
- (void) print;
- (void) setNumerator: (int) n;
- (void) setDenominator: (int) d;
- (void) setTo: (int) numerator over: (int) denominator;
@end

@implementation Fraction {
    int numerator;
    int denominator;
}

- (void)print {
    NSLog(@"%i/%i", numerator, denominator);
}

- (void) setNumerator: (int) n {
    numerator = n;
}

- (void) setDenominator: (int) d {
    denominator = d;
}

- (void) setTo: (int) numerator over: (int) denominator {
    self.numerator = numerator;
    self.denominator = denominator;
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *myFraction;
        myFraction = [Fraction alloc];
        myFraction = [myFraction init];
        //Alternatively this can be used
       //Fraction *myFraction = [Fraction new];

        [myFraction setNumerator:1];
        [myFraction setDenominator:5];
        [myFraction print];
    }
    return 0;
}
```
### Class / instance Methods
Only difference is + or - at the beggining.
```objective-c
//instance
- (void) setDenominator: (int) d;
//class
+ (Fraction) createNew;

```
## Data types
![[objc-types.png]]
### id
The id data type is used to store an object of any type
```objective-c
-(id) newObject: (int) type;
```
More on its usage at [[#Polymorphism]]
## Static local value
if we want to have retain a local value over multiple function calls (In swift and other programming languages I don't think such thing even exists!) we declare the value with static keyboard
```objective-c
-(int) showPage {
	static int pageCount = 0;
	++pageCount;
	return pageCount; 
}
```
## @class Directive
if you want to use a class inside another class either you can import a header file or use `@class clasName`. The latter is more preferable because it doesn't add all of the another file code on top of your file.
```objective-c
@class XYPoint;  
@interface Rectangle: NSObject @property int width, height;

-(XYPoint *) origin;  
-(void) setOrigin: (XYPoint *) pt;  
-(void) setWidth: (int) w andHeight: (int) h;
-(int) area;  
-(int) perimeter;  
@end
```
## Polymorphism
Polymorphism can be achieved on two levels;
Compile time:
You have two objects that have two methods with the same name. The compiler will understand what method belongs to what objects. (duh, it's simple!)
Run time:
You have two objects that have two methods with the same name. You hide the type of the objects with `id` an in runtime that type would be determined and corresponding method will be executed.
* You don't have compile time safety and it's possible to produce a lots of bugs and crashes!
* `id` acts like `Any` type in swift.
```objective-c
int main (int argc, char * argv[]) {

@autoreleasepool {  
	id dataValue;
	Fraction *f1 = [[Fraction alloc] init];
	Complex *c1 = [[Complex alloc] init];
	[f1 setTo: 2 over: 5];
	[c1 setReal: 10.0 andImaginary: 2.5];

	// first dataValue gets a fraction
	dataValue = f1; [dataValue print];

	// now dataValue gets a complex number
	dataValue = c1;
	[dataValue print]; }
	return 0; 
}
```
### Dynamic safety
#### Check for the abilities and types
If we hided a type behind an `id` for better safe usage we can check for the its type and the methods it has by using these methods.
![[dynamic-types-methods].png]]
#### Handle errors in try catch
It's also possible to invoke dynamic methods in try catch blocks to prevent crashes and handle the errors gracefully.
```objective-c
Rectangle *rectangle = [Rectangle new];
id shape = rectangle;
    
@try {
	[shape setRadius:5];
} @catch (NSException *exception) {
	NSLog(@"Can't set radius for rectangle");
}
```
## Init
All `NSObjects` inherit the default empty init. For writing a custom init use:
```objective-c
-(instancetype) initWith: (int) n over: (int) d {
self = [super init];
if (self)  
	[self setTo: n over: d];
return self; }
```
>If your class contains more than one initializer, one of them should be your designated initializer, and all the other initialization methods should use it. Typically, that is your most complex initialization method (usually the one that takes the most arguments).

so for writing an initializer with default values we can use
```objective-c
-(instancetype) init {
return [self initWith: 0 over: 0]; 
}
```
## Scopes
TODO
## Enums
```objective-c
//The associated number starts at 0
//you can alternate it by changing the previouse enum or assign numbers to each item specifically

enum month { january = 1, february, march, april, may, june,
july, august, september, october, november,
december };
enum month amonth;
```
## Type Casting
By using `(type)` you can cast types to another types
```objective-c
average = (float) total / n;
```
## Categories
These are equivalent to swift extensions and being used to add extra functionalities (publicly) to an interface of a class and implement it.
```objective-c
//Orginal class
@interface Shape: NSObject
//....
@end

//Category
@interface Shape (Render)
-(void) draw;
@end

//category can go either inside the original file or a seperate file.
```
Same as swift you can write categories in pre-existing classes in frameworks and places that you can't mutate the file.
### Class extensions
These are same as categories however the methods that they declare are only for the private use of the class. Class extensions are declared same as categories without a name in `()`.
```objective-c
@interface Shape: NSObject
//....
@end

//Extension
@interface Shape ()
-(void) recenter;
@end
```
## Protocols
Declaration 
```objective-c
@protocol AreaCalculator  
- (double) area;
- (double) bounds;
@optional
- (BOOL) hasEqualEra: (id <AreaCalculator>) shape;
@end
```
And can be applied on different types like:
```objective-c
@interface Shape: NSObject <AreaCalculator>
//...
@end

//or via a category
@interface Shape (Area) <AreaCalculator>
//...
@end
```
type can conform to multiple protocols like
```objective-c
@interface Person <Protocol1, Protocol2, Protocol3>
@end
```
You can specialize a generic type `id` with protocols like
```objective-c
id <AreaCalculator> *someAreaCalculator;
```
## Preprocessor
`#define`with and argument
```objective-c
#define IS_LEAP_YEAR(y) y % 4 == 0 && y % 100 != 0 \
|| y % 400 == 0

//later in code
if ( IS_LEAP_YEAR (year) ) {
//...
}
```
* Use `\` to have multiline defines.
### Careful about macro definitions
Assume this
```objective-c
#define SQUARE(x) x * x

//If we pass this
y = SQUARE(5+1)
//the result wont be 36 
//the above equation will be expanded to
y = 5 + 1 * 5 + 1; // = 11

//however if we define the macro like
#define SQUARE(x) ( (x) * (x) )

//the code will be expanded to this instead
//which is more expected
y = ( (5 + 1) * (5 + 1) ); // = 36
```
## C Features
### char arrays
If you put `\0` at the end of char array it will be treated as a c string in objective-c.
```objective-c
char word[] = {'H','e', 'l', 'l', 'o', '\0'};
NSLOG(@"%s", word);
```
### Blocks
Equivalent to closures.
```objective-c
void (^somework)(void) = ^(void){
//your code
};

somework();
```
typedfing blocks
```objective-c
typedef void (^QuestionAnsweredHandler)(NSInteger answer, NSString * questionID ,NSInteger index);
```
### Structs
```objective-c
struct Date {
int day;
int month;
int year;
};
```
Initialize:
```swift
struct Date yesterday = {22, 11, 2024}
//or init with labels for better readebility
struct Date yesterday = {.day = 22, .month = 11, .year = 2024}
//only init year and make others undefined.
struct Date yesterday = {.year = 2024}
```
You can also declare and define at the same time (good for temporarily structs)
```objective-c
struct Date {
int day;
int month;
int year;
}yesterday = {22, 11, 2024};

//also you can define an array of them
struct Date {
int day;
int month;
int year;
} date[100];
```
### Pointers
Array are kinda pointers and they have the address of their first element.
```objective-c
int values[10];
int* ptr;

//address of the first element
ptr = &values[0]
//which is equivalent to (And recommended)
ptr = values
```
you can get the address of the nth element with pointers like
```objective-c
*(ptr + n) //parantheses are important!
```

char arrays can be iterated with pointers like
```objective-c
char *str;
for (int i = 0; i != '\0', ++i) {
	//...
}
```
### Pointer to functions
TODO
```objective-c
int (*ptrName) (void);
```
### Compound literlas
Sometimes you want to create an unnamed value of a type. for example if you want to send a `struct date` to a function that accepts `struct date` you can declare it directly like
```objective-c
doSomethingWithDate ((struct Date) {.day = 22, .month = 11, .year = 2024});
```
### SizeOf
In objective-c can be useful for determine c array length.
```objective-c
struct date array[];
//...
int count = sizeof (array) / sizeof(struct date);
```
### Other points
* Instance variables are stored in structures.
* An object variable is really a pointer.
* Methods are functions and message  expressions are function calls.
* The id type is a generic pointer type.
## Foundation Framework
### NSNumbers
Make sure to init and retrieve with the same type. For example
```objective-c
NSNumber* myNumber = [NSNumber initWithInt: 5]
int numberValue = [myNumber numberWithInt] //5
```
It's also possible to init the NSNumbers like
```objective-c
NSNumber *center = @((start + end) / 2.0);
```
### NSString
*They're consist of unichar elements instead of char that are used in C, therefor they can cover more characters.*
```objective-c
NSString *text = @"Programming is fun"
//it's a NSConstantString which is a subclass of NSString
```
#### Description
You can NSLog any custom object if you override the `-(NSString *) description` method that they have.
```objective-c
-(NSString *) description {
return [NSString stringWithFormat: @"%i/%i", numerator, denominator]; 
}
NSLog (@"The sum of %@ and %@ is %@", f1, f2, sum);
```
#### Some functionalities
```objective-c
NSString *str1 = @"This is string A";
NSString *str2 = @"This is string B";

NSString *res = [NSString stringWithString: str1]; //copying
str2 = [str1 stringByAppendingString: str2];
BOOL isEqual = [str1 isEqualToString: str2];
NSString *uppercased = [str1 uppercaseString]
```
All the above functionalities returns strings. If you want to mutate a string you should use `NSMutableString`
```objective-c
NSMutableString *mstr = [NSMutableString stringWithString: str1];
mstr = [NSMutableString stringWithString: str1];
```
Replace a range of string
```swift
NSString *searc = "Something"
NSString *replace = "another thing"
substr = [mstr rangeOfString: search];
if (substr.location != NSNotFound) { 
	[mstr replaceCharactersInRange: substr withString: replace]; 
	NSLog (@"%@", mstr);
}
```
Comparing two strings
```objective-c
[str1 caseInsensitiveCompare: str2] == NSOrderedSame
```
#### Logging
```objective-c
NSString *hello = @"Hello World";
NSLog("%@", hello);
```
#### NSArray
NSArray mostly works with objects so if you have simple types it's required to turn them to their corresponding objects.
```objective-c
//array of nsstrings
NSArray *array = [NSArray arrayWithObjects: @"January", @"February"]

//it's also can be initialized like
NSArray *array = @[@"January", @"February"]
```
Create an empty array
```objective-c
NSMutableArray *book = [NSMutableArray array];
```
### Fast enumeration
```objective-c
NSArray *book;
for ( AddressCard *theCard in book ) {
//...
}

//also you can right something like for-each
[book enumerateObjectsUsingBlock:  
^(AddressCard *theCard, NSUInteger idx, BOOL *stop) {

} ];
```
### isEqual
For checking the equality of two objects override the NSObject `isEqual` method like
```objective-c
-(BOOL) isEqual: (Object *) object {
//...
}
```
### Dictionary
The easiest method for initing a dictionary;
```objective-c
NSDictionary *ages = @{ @"John": @22, @"Jane": @23 };
```
## Memory Management
The idea of cleanup and reuse the part of the memory that it's not needed. When you allocate memory to a variable if that variable is not needed you need to free that memory. There are 3 ways that memory managements is being done in objective-c;
1. ~~Automatic garbage collection(deprecated)~~
2. Manual reference counting and the autorelease pool
3. Automatic Reference Counting (ARC)
### Manual reference counting
It's quite tricky and in many objective-c codebases is not being used, however here are some important notes about it;
* Manually increment the object reference count by `[myObject retain]` and decrease with `[myObject release]`
* Some methods like `NSMutableArray’s addObject:` , `UIView’s addSubview:`, `removeObjectAtIndex:`, `removeFromSuperview` might increase or decrease the reference count
* Sometimes you get out of the scope of a method but you're returning an object, for preventing the deallocation of object the `@autoreleasepoool` is being used. Its main job is to delay the releasing and only release when the pool is drained. (more on this on the book at page 410)
* When using `@autoreleasepoool` instead of releasing explicitly like `[myObject release]`you should call `[myObject autorelease]`.
### Automatic reference counting
It's easy and the same as we have in Swift. You only need to watch for retain cycles most of the times, and for preventing it make sure to define properties weak like;
```objective-c
@property (weak, nonatomic) UIView *parentView;
```
### make self as weak
```objective-c
__weak ClassName *weakSelf = self;
```
## Multi-Threading
switching to main thread
```objective-c
dispatch_async(dispatch_get_main_queue(), ^{
	// ...
});
```