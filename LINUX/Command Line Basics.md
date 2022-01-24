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
* executing `man heir` in one of system file hierarchy would give you an explanation of all sub directories it has.
* https://www.youtube.com/watch?v=TG5YJe9camA&list=PLtK75qxsQaMLZSo7KL-PmiRarU7hrpnwK&index=21