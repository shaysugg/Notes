* To show stashed files you can use `git stash show`
* You can have different stashes at one time in order to see previous stashes use git stash list
```bash
stash@{0}: WIP on master: c60e8a6 Merge branch 'feature/f7'
stash@{1}: WIP on master: c60e8a6 Merge branch 'feature/f7'
stash@{2}: WIP on master: c60e8a6 Merge branch 'feature/f7'
```
* If you want to see the changes of a specific stash use `git stash show stash@{2}`
* If you want to see content of changes use `git stash show -p stash@{2}`

* You can bring back the last stash changes use `git stash pop` for a specific stash use `git stash pop stash@{2}`
* For also stashing untracked changes `use git stash -u`
