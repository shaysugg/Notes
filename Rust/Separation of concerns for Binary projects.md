- Split your program into a _main.rs_ file and a _lib.rs_ file and move your program’s logic to _lib.rs_.
- As long as your command line parsing logic is small, it can remain in _main.rs_.
- When the command line parsing logic starts getting complicated, extract it from _main.rs_ and move it to _lib.rs_.
The responsibilities that remain in the `main` function after this process should be limited to the following:
-  Calling the command line parsing logic with the argument values
- Setting up any other configuration
- Calling a `run` function in _lib.rs_
- Handling the error if `run` returns an error