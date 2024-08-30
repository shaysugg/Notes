*from apple docs, A later clean up and summaries are needed*
#### Writability
These attributes specify whether or not a property has an associated set accessor. They are mutually exclusive.
`readwrite`
Indicates that the property should be treated as read/write. This attribute is the default.
Both a getter and setter method are required in the `@implementation` block. If you use the `@synthesize` directive in the implementation block, the getter and setter methods are synthesized.

`readonly`
Indicates that the property is read-only.
If you specify `readonly`, only a getter method is required in the `@implementation` block. If you use the `@synthesize` directive in the implementation block, only the getter method is synthesized. Moreover, if you attempt to assign a value using the dot syntax, you get a compiler error.

#### Setter Semantics
These attributes specify the semantics of a set accessor. They are mutually exclusive.

`strong`
Specifies that there is a strong (owning) relationship to the destination object.
`weak`
Specifies that there is a weak (non-owning) relationship to the destination object.
If the destination object is deallocated, the property value is automatically set to `nil`.
(Weak properties are not supported on OS X v10.6 and iOS 4; use `assign` instead.)

`copy`
Specifies that a copy of the object should be used for assignment.
The previous value is sent a `release` message.
The copy is made by invoking the `copy` method. This attribute is valid only for object types, which must implement the `NSCopying`  protocol.

`assign`
Specifies that the setter uses simple assignment. This attribute is the default.
You use this attribute for scalar types such as `NSInteger` and `CGRect`.

`retain`
Specifies that `retain` should be invoked on the object upon assignment.
The previous value is sent a `release` message.

In OS X v10.6 and later, you can use the `__attribute__` keyword to specify that a Core Foundation property should be treated like an Objective-C object for memory management:
```objective-c
@property(retain) __attribute__((NSObject)) CFDictionaryRef myDictionary;
```
#### Atomicity
You can use this attribute to specify that accessor methods are not atomic.

`nonatomic`
Specifies that accessors are nonatomic. _By default, accessors are atomic._

Properties are `atomic` by default so that synthesized accessors provide robust access to properties in a multithreaded environment—that is, the value returned from the getter or set via the setter is always fully retrieved or set regardless of what other threads are executing concurrently.

If you specify `strong`, `copy`, or `retain` and do not specify `nonatomic`, then in a reference-counted environment, a synthesized get accessor for an object property uses a lock and retains and autoreleases the returned value—the implementation will be similar to the following:
```objective-c
[_internal lock]; // lock using an object-level lock|
id result = [[value retain] autorelease];
[_internal unlock];
return result;
```
If you specify `nonatomic`, a synthesized accessor for an object property simply returns the value directly.