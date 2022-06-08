## Wildcards
<table>
<tr>
<th style = "width: 30%">WildCard</th>
<th>Meaning</th>
</tr>

<tr>
<td>*</td>
<td>Matches any character</td>
</tr>

<tr>
<td>?</td>
<td>Matches any single character</td>
</tr>


<tr>
<td>[characters]</td>
<td>Matches any character that is not a member of the set characters</td>
</tr>

<tr>
<td>![characters]</td>
<td>Matches any character that is not a member of the set characters</td>
</tr>

<tr>
<td>[[:class:]]</td>
<td>Matches any character that is a member of the specified class</td>
</tr>
</table>
## Character classes
<table>
<tr>
<th style = "width: 40%">Character class</th>
<th>Meaning</th>
</tr>

<tr>
<td>[:alnum:]</td>
<td>Matches any alphanumeric character</td>
</tr>

<tr>
<td>[:alpha:]</td>
<td>Matches any alphabetic character</td>
</tr>


<tr>
<td>[:digit:]</td>
<td>Matches any numeral</td>
</tr>

<tr>
<td>[:lower:]</td>
<td>Matches any lowercase letter</td>
</tr>

<tr>
<td>[[:upper:]]</td>
<td>Matches any uppercase letter</td>
</tr>
</table>

## Examples
* `g*` : All files begins with g
* `b*.txt`: Any files beginning with b followed by any characters and ending with .txt
* `Data???`: Any fike beginning with DAta followed by exactly three characters/
* `[abc]`: Any file beginning with either an a, ab, or a c
* `BACKUP.[0-9][0-9][0-9]` Any file beginning with BACKUP. followed by exactly three numerals
* `[[:upper:]]*`: Any file beginning with an uppercase letter
* `[![:digit:]]*` Any file not beginning with a numeral
* `*[[:lower:]123]`: Any file ending with a lowercase letter or the numerals 1, 2, or 3
