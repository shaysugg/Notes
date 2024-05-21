# Undoing Strategies 
https://www.atlassian.com/git/tutorials/undoing-changes
## 1. Checkout to previous commit
*This solution probably most suitable for some mistakes on **features** branches that you can easily delete them later on after you merged the fixed branch into develop. In other scenarios it's best to consider other solutions*

Imagine this scenario did happened.
![[01 2.png]]
1. we checkout to the commits that mistakes not happen yet. `git checkout [commit hash]`
2. we gonna create another branch from there.
3. we continue development on that branch and finally merge it our underlying branch.

![[03.png]]

## 2. Revert
by using `git revert [commit hash]` we undo what did happened in that specific commit.
*Ex: if we add file A and change file B in commit with hash of 5220b2f if we `git revert 5220b2f` then a new commit created with file A is deleted and file B changes is undone.*
* Unstaged changes still remains.
* good for public branches (since it doesn’t change history)
#### Example of fixing a f up on remote
You just merged a feature and pushed it to remote and realized something is not right (You're breaking your teammates code). Here is the steps you need to take to undo this without affecting history and introducing issues to others that are using the same repo
Fixing their side
1) First revert the merge commit like: `git revert 12dfrrfrgt`
2) push again (now repo is fixed and everybody can use it)
Fixing your side
1) Checkout on your feature branch
2) Merge the base branch right away
3) Revert the commit that was causing problems (you can also do other undoing strategies i guess??)
4) Go back to the base branch and merge the feature branch that has been corrected.
5) Push
### 3. Reset Hard
by using `git reset --hard [commit hash]` we remove all the commits that happened after that specific commit with commit hash from history.
* ==not good for public branches== since it would change the history.
* Unstaged changes are going to be **==removed==** also.
* It's good to create a backup branch and then do the git reset hard
* git reset also available with --soft option. In that case it will remove the **commits** but will keep the **changes** as uncommitted files. you have the options to commit the changes in a different format or discard them. It's still not safe to be used with public branches though.
## 4. Reset
`git reset` use for undo **staging changes**. *ie undo whatever staged by `git add`*
*`git restore --staged` may be a more nicer equivalent*
## 5. Clean
`git clean` use for undo **untracked files**. *mostly works like removing them*
* `git clean -n` show changes that gonna happened if we use git clean.
* `git clean -f` should be use if we sure about undoing changes.

## TLDR
-   Once changes have been committed they are generally permanent.
-   Use `git checkout` to move around and review the commit history.
-   `git revert` is the best tool for undoing shared public changes.
-   `git reset` is best used for undoing local private changes.