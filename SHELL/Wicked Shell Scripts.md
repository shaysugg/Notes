# Notes from Wicked Shell Scripts

## Sed

very useful for subscripts strings.
for example `sed -e 's/[^[:alnum:]]//g'` removes any other charecters **except** alpha numeric ones.

more: https://www.howtogeek.com/666395/how-to-use-the-sed-command-on-linux/

## Stream of functions

perform some tasks devised by `|` while sending result of each task to another inline for example:

```shell
$(echo $1|cut -c1|tr '[:lower:]' '[:upper:]')
```

1.will make first input aka $1 to string .
2.then grab the first charecter of it.
3.then make the character uppercase.





