# Undoing Strategies 
https://www.atlassian.com/git/tutorials/undoing-changes
## 1. Checkout to previous commit
Imagine this scenario did happened.
![[01 2.png]]
1. we checkout to the commits that mistakes not happen yet. `git checkout [commit hash]`
2. we gonna create another branch from there.
3. we continue development on that branch and finally merge it our underlying branch.

![[03.png]]

## 2. Revert
by using `git revert [commit hash]` we undo what did happened in that specifice commit.
*Ex: if we add file A and change file B in commit with hash of 5220b2f if we `git revert 5220b2f` then a new commit created with file A is deleted and file B changes is undone.*
* Unstaged changes still remains.
* good for public branches (since it doesn’t change history)

### 3. Reset Hard
by using `git reset --hard [commit hash]` we remove **that commit and every other commit that happened after it** from history.
* not good for public branches since it would change the history.
* Unstaged changes gonna get **remove** also.

## 4. Reset
`git reset` use for undo **staging changes**. *ie undo whatevere staged by `git add`*

## 5. Clean
`git clean` use for undo **untracked files**. *mostly works like removing them*
* `git clean -n` show changes that gonna happened if we use git clean.
* `git clean -f` should be use if we sure about undoing changes.

## TLDR
-   Once changes have been committed they are generally permanent.
-   Use `git checkout` to move around and review the commit history.
-   `git revert` is the best tool for undoing shared public changes.
-   `git reset` is best used for undoing local private changes.