## Fetch + Merge instead of pull
After calling `git fetch` you can see all the branches that have been fetched with `git branch -a`. In order to update the current branch you need to merge `remotes/origin/currentbranch`
let's say we are at main branch and instead of integrating changes directly with `git pull`we want to investigate the changes first  and if they're fine then perform merge.
```bash
git fetch origin
git branch -a #to see list of branches
git checkout remotes/origin/main #investigate changes
git checkout main
git merge remotes/origin/main #merge the fetched changes
```
## Overwrite local changes
If you want to roll back to the version that is on upstream.
```bash
git fetch  
git reset --hard origin/master
```