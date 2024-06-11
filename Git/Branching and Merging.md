## Different kind of merging
### Fast forward
`git merge feature-branch`
This one will bring all of the commits of the merging branch to the base branch.
### No fast forward
`git merge --no-ff feature-branch`
This one collect all the commits of the merging brach into the one commit and add that one commit to the main brach.
### Squash
`git merge --squash feature-branch`
this one brings the changes from the merging branch to base branch but doesn't commit anything. You have to commit changes by yourself. In the history there is no sign of branching and merging going to exists. It's going to appear as a normal commit.
### Example
From the bottom;
* The f21430b is a result of a merge with squash that is appeared as a typical commit.
* The a4922ab however is a result of merging the feature/f3 branch with no fast forward option.
* The 91f8ac5 is a result of fast forward merging. It brought all of the commits of the feature/f4 branch.
```bash
* 91f8ac5 (HEAD -> master, feature/f4) Finalized feature 4
* 54cd6e4 Fixed feature 4
* f714928 Added feature 4
*   a4922ab (HEAD -> master) Merge branch 'feature/f3'
|\
| * 78cc5ea (feature/f3) Added feature 3
|/
* f21430b Merged a new feature (squash)
# ....
```
