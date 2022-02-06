# Command Line Basics

## Basic Commands

<table>
<tr>
<th style = "width: 30%">Command</th>
<th>Explanation</th>
</tr>

<tr>
<td>mv [destination1] [destination2]</td>
<td>move , also can be used for renaming a file</td>
</tr>

<tr>
<td>man [command]</td>
<td>full description of command (more detailed than --help)</td>
</tr>

<tr>
<td>nano [text file path]</td>
<td>default linux <b>text editor</b></td>
</tr>

<tr>
<td>ps aux</td>
<td>summery of what system and its resources doing right now in <b>text</b></td>
</tr>

<tr>
<td>top</td>
<td>summery of what system and its resources doing right now in <b>live</b></td>
</tr>

<tr>
<td> [some command] | grep "[some text]"</td>
<td>search some text in the output of some command</td>
</tr>


</table>

## SYSADMIN Commands
<table>
<tr>
<th style = "width: 30%">Command</th>
<th style = "width: 20%">Arguments</th>
<th>Explanation</th>
</tr>

<tr>
<td>root -i</td>
<td> -- </td>
<td>become root user</td>
</tr>


<tr>
<td>useradd [username] OR adduser [username]</td>
<td> -m , -d, -u, -g, -s  </td>
<td>Add a user with username,
-m: create a home directory for the user, -d: define where the home dir is -u: define uid for the user, -g: define a group id for the user -s: define the default shell</td>
</tr>

<tr>
<td>userdel [username] OR deluser [username]</td>
<td> -- </td>
<td>Delete the user with username,
</td>
</tr>

</table>

### Notes
* `etc/passwd` where you can find bunch of info about different user the system has. *use **cat** or **tail** with it, use **grep** to find info about the user you searching for*
* ls ing `/home` would list all users home directories
* if you delete a user their home directory still gonna exists. * you need to manually delete it after a while*


## Processes

<table>
<tr>
<th style = "width: 20%">Command</th>
<th>Explanation</th>
</tr>

<tr>
<td>top</td>
<td>show processes live</td>
</tr>

<tr>
<td>htop</td>
<td>show processes live (more advance than htop, needs to be installed)</td>
</tr>


<tr>
<td>nice, renice</td>
<td>excecute or re-excecute a library with different nicess</td>
</tr>

</table>

### Notes
* the least nieces processes have the more important excruciation. *ex: system processes has something about -20, you shouldn't set anything lower than that.*


## FILE System
<table>
<tr>
<th style = "width: 20%">Dir</th>
<th>Explanation</th>
</tr>

<tr>
<td>/dev</td>
<td>infos about all hardware that connected to the devicce </td>
</tr>

<tr>
<td>/etc</td>
<td>configuration of the apps that installed on system. (if an app behaved weirdly we may be able to troubleshoting it by looking at its directory here) </td>
</tr>


<tr>
<td>/sbin</td>
<td>system bineries. (you need to be root to call one of them.)</td>
</tr>

<tr>
<td>/bin</td>
<td>regular bineries. every application that did installed have a binary in here.</td>
</tr>


<tr>
<td>/lib</td>
<td>shared libreries that different programs on system may use.</td>
</tr>

<tr>
<td>/proc</td>
<td>information about proccess that are running</td>
</tr>

<tr>
<td>/usr</td>
<td>none super essential files and commands.</td>
</tr>

<tr>
<td>/opt</td>
<td>optional softwares.</td>
</tr>

</table>

### Notes
* 🔥 executing `man heir` in one of the **system** file would give you an explanation of all sub directories it has.
* `tree .` gives you a graphical tree hierarchy of files you have in the directory.
* https://www.youtube.com/watch?v=TG5YJe9camA&list=PLtK75qxsQaMLZSo7KL-PmiRarU7hrpnwK&index=21

### File types and permissions

 in the long listing aka `ls -alh` you always have a format like this beside every file:
	 `drwxr-xr-x`
 it means **FileType** *1* | **User Permission** *2 - 4* | **User Group Permission** *5-7* | **Everyone permission** *8-10*

 #### File Types
 * d -> directory
 * l -> link to a file
 * b -> block device file
 * c -> character device file
 * s -> socket file
 
 ### Permissions
* r-> read
* w -> write
* x -> execute

## Scheduling tasks with cron
* `crontab -l` list of crons you have on your system
* `crontab -e` edit list of crones

a scheduled task in crone should has this format : 
**(min)  (hour) (which days) (which months) (which weekday) (command)

*example:*
`* * * * * echo "date now is $(date) >> /Users/me/Desktop/dates.txt"`
 *would write every minute the current date in the dates.txt file*

 * at /etc/crontab you find system wide crotabs. if you becoming the root you can definbe different crontabs for different users. you have one extra field to crontab formula before command and it is the user name that you want to define the crontab for
 * etc/cron.d for software cons

 **Further read**
 * etc/cron.allow ??
 * etc/cron.dany ??


## TMUX
TODO
*required a server machine*

## TAR
tar has a lots of arguments and options but two useful options are:

1) Archiving: `tar -zcvf [sometar.tar.gz] [directory that you want to archive]`
2) De-Archiving: `tar -zxvf [sometar.tar.gz]`
	* z -> using gzip *compress the archive too*
	* c -> create a new archive
	* v -> verbose *log the process*
	* f -> read the archive from the file

	
## Some notes about BASH Scripting
* putting a <b>``</b> in the echo string execute the command inside it:
	ex: `echo "there is  ['] wc -l < /etc/group ['] lines in the group file!" `*

* TODO: checkout **Source** command, (integrate the script to your current shell)

* ### Argument References
<table>
<tr>
<th style = "width: 30%">Argument</th>
<th>Explanation</th>
</tr>

<tr>
<td>$0</td>
<td>the file name of bash script</td>
</tr>

<tr>
<td>$#</td>
<td>number of argument that have been given to the script
</td>
</tr>


<tr>
<td>$@</td>
<td>all of the arguments (can be used like: for arg in $@) 
</td>
</tr>

<tr>
<td>$1 , $2 ... $n</td>
<td>the nth argument that have been given to the script
</td>
</tr>

</table>

* If statement
```bash
if [[condition]]; then
# do somthing
elif [[another condition]]; then
#do somthing
else 
#do something
fi
```

* for loop statement
```bash
for arg in "$@"; do 
echo "$arg"
done
```

* function 
```bash
#could be define without func keyword
function myfunc() {
# $1 is a first parameter that this function gets
echo "first param is $1"
echo "second param is $2"
}

myfunc "yo" "bye"

```

## What is $PATH ?
* if you `echo $path` it's gonna return list of path directories. these directories getting iterate through when you run a command and first command that have found in these directories gonna get executed.
	*example:*
```bash
echo $PATH
/Users/gig/myscripts:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Users/gig/.fig/bin:/Users/gig/desktop/flutter/flutter2.0.4/bin
```

* ### Changing Path
	* appending to path: `PATH=$PATH:/some/dir/path` *(usual safe way, because it would not override the default directories order)*
	* prepending to path: `PATH=$PATH:/some/dir/path` *(not a safe way because it would override the order of paths that are in $PATH, the dir that you prepend gonna get search before each one of these.)*
	* usually you put all your path in a bash profile like: `~/.bash_profile` *or if somebody like me using zshel you put the in '~/.zshrc' *

## Aliases
Can be use to be for:
* Short version of a command that is very long and you use it very repeatedly
	example:  `alias gcmsg="git commit -m"`
* Shadowing a command: changing a default behavior of a command to another.
	example `alias ls ="ls -a --color"`
* not that if you want to have this alias to be valid when you open another shell you should put aliases in a configuration file like `~/.bashrc`, `~/.zshrc`.
	

* if you type `alias` it would show a list of all the aliases.

## Vim Basics
* dd -> delete a line
* u -> undo
* ctrl+r -> redo
* / + your_text -> search your_text in the file (go to next result with n go to previous result with N)
* %s/text_you_looking_for/text_you_want_to_replace/g


<table>
<tr>
<th style = "width: 40%">Command</th>
<th>Explanation</th>
</tr>

<tr>
<td>dd</td>
<td>delete a line</td>
</tr>

<tr>
<td>u</td>
<td>undo changes</td>
</tr>

<tr>
<td>ctrl+r</td>
<td>redo changes</td>
</tr>


<tr>
<td>/ + [[your_text]] </td>
<td>search your_text in the file (go to next result with n go to previous result with N)</td>
</tr>

<tr>
<td>%s/[[search_text]]/[[replace_text]] </td>
<td>search and replace (g stands for greedy)</td>
</tr>



</table>
