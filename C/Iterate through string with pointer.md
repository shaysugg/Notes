```c
const char *fmt = "hello world";
char *p;
for (p = fmt; *p; p++) {
	//*p is a character in order
}
```
## Without pointer
```c
int main() {
    char sample[] = "From whence cometh my help?\n";
    int index = 0;
    while(sample[index] != '\0')
    {
        putchar(sample[index]);
		index++; 
	}

	return(0); 
}
```
## Notes
* Better to declare string with `const char *str`