- Create a Symbolic Breakpoint in Xcode
- for Symbol, add **`-[UIViewController viewWillAppear:]`**
- for Action, add a Debugger Command and the following expression:  
    **`expr -- (void) printf("🔘 %s\n", (char *)object_getClassName($arg1))`**