* After rebase the ==changes that have committed on the source branch will have different commit hash==, That's the reason you should not rebase on the branch that has commits that have been already pushed to remote.
## Interactive Changing History
 `git rebase -i HEAD~3` can be used for manipulating last 3 commits
  It's a pretty **dangerous command be careful!** ( you can remove commits and their changes & ...)
 After entering the command a text editor will be appeared like this
 ```bash
pick 677215d Add fix for feature 2
pick 88249e0 Fix feature 3
pick 4f759d0 Add fix for feature 4
```
You can either choose `pick` or use other commands that's possible such as `reword`, `edit` `squash`  and more (each has its own description in the text editor) and the required further steps will be shown to you on the text editor
### Examples
A common example can be when we have multiple commits that we want to combine some of them together because they are not meaningful on their own. for instance if we `git log --oneline` we're going to have a history like this:
```bash
677215d Add another fix for feature 2
88249e0 Add fix for feature 2
4f759d0 Add feature 2
52345d0 Add something 
...
```
we can use `git rebase -i HEAD~3` and then 
```bash
pick 4f759d0 Add feature 2
s 88249e0 Add fix for feature 2
s 677215d Add another fix for feature 2 
```
By changing the last two commit command with s or squash the commits will be squashed to the previous commit therefore the history will be changed to
``` bash
4e46982 Add feature 2 
52345d0 Add something 
```
Note that the past three commits turned to one commit with the first commit message but a ==different commit hash==!
## Aborting interactive rebase
If all the actions removed then rebase going to be considered as aborted (the comments are not required to be deleted)