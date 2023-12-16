## Redirection 
<table>
<tr>
<th style = "width: 30%">Command</th>
<th>Explanation</th>
</tr>

<tr>
<td>uniq</td>
<td>Report or omit repeated lines</td>
</tr>

<tr>
<td>head</td>
<td>Output the first part of file</td>
</tr>

<tr>
<td>tail</td>
<td>Output last part of file</td>
</tr>

</table>
## Shell Expansions
**{boundaries}**
```bash
	echo {Z..X}
	Z Y X
	
	echo {09..15}
	9 10 11 12 13 14 15
	
	echo a{A{1,2},B{3,4}}b
	aA1b aA2b aB3b aB4b
	
```

**$((Arithmetic Expansion))**
```shell
	echo $((2 + 2))
	4
```

## File Modes in Binary and Octal
<table>
<tr>
<th>Octal</th>
<th>Binary</th>
<th>File mode</th>
</tr>

<tr>
<td>0</td>
<td>000</td>
<td>---</td>
</tr>

<tr>
<td>1</td>
<td>001</td>
<td>--x</td>
</tr>

<tr>
<td>2</td>
<td>010</td>
<td>-w-</td>
</tr>

<tr>
<td>3</td>
<td>011</td>
<td>-wx</td>
</tr>

<tr>
<td>4</td>
<td>100</td>
<td>r--</td>
</tr>

<tr>
<td>5</td>
<td>101</td>
<td>r-x</td>
</tr>

<tr>
<td>6</td>
<td>110</td>
<td>rw-</td>
</tr>

<tr>
<td>7</td>
<td>111</td>
<td>rwx</td>
</tr>

</table>
