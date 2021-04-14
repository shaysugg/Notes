# Commands
## git diff
* `git diff` **only** works for **unstaged** changes.
* `git diff [commitID]` different between current commit and another commit with commitID
* `git diff [brnach-1] [branch-2]` differents between branch-1 and branch-2
* `git diff [branch-1] [branch-2] [fileName]`  file with fileName difference between branch-1 and branch-2

## git stash
* `git stash -u` for stashing unstaged files.

## git commit
* `git commit --amend -m "new message"` replace the previouse commit message with new message.
* `git commit --amend --no-edit` add staged changes to previouse commit *ie: mostly when we forgot to add a file befor commit. we use `git add` to add the forgoten file to thr staged area and then we use this command to add forgoten file to the previous commit.*

## git remote
* `git remote add [repo name] [repo url]` create a shortcut with name of **repo name** for **repo url** *(don't need to type repo url each time)*
* `git remote rm [repo name]` delete the remote.
* `git remote rename [old name] [new name]` rename the remote.
* `git remote show [repo name]` show more detail of remote.

## git push
* `git push [remote name] --all` push all branches + tags.
* `git push [remote name] --tags` push all tags.
* `git push origin:[branch name]` remove branch remotely.
* It's okay to use force push for --amend commits.

**Standard git push** *(prevents push confilicts)*
```
git checkout master
git fetch origin master
git rebase -i origin/master
# Squash commits, fix up commit messages etc.
git push origin master
```

## git pull
* `git pull --rebase [remote name]` moves your local changes onto the top of what everybody else has already contributed.
![[pull01.png]]
![[pull02.png]]

## git rebase
### what is rebasing
imagine we want to sync changes in this scenario
![[mvr.png]]
**Merging**
![[merge mvr.png]]
**Rebasing**
![[rebase mvr.png]]

### notes
* **NEVER** use rebase on a **public branch**
* `git rebase -i [branch name]` open up an editor that would show us which commit about to change and some option to edit them.
* for cleaning up history we can use `git rebase -i [commit hash]` to **edit** commits that happends **after** the commit with comit hash.

