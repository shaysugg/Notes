# Git Workflows
## Centeralized workflow
* linear workflow, all the development done on one branch
* before every push we need to pull the changes and rebase our changes on top of them using `git pull --rebase [remote name] [remote branch]`.
* we may have conflict, if we solve them and stage them then we run `git rebase --continue` to back to branch, if we can't solve them we run `git rebase --abort` to abort rebase and back to branch.

## Feature Branch workflow
* make sure to **pull** all the changes **before create a new branch.**
* create a branch for each feature.
* **pull** the changes **before merge the branch**, and push changes.

## GitFlow Workflow
![[gitflow.png]]
* **release**: steps that needed for a release done on this branch.
branched from develop and will merge to develop and master

* **hotfix**: quickly patch production releases.
branched from master and will merge to develop and master

* **feature**: for developing feature.
branched from develop and will merge to develop

## Forking Workflow
* usually use for open source projects.
* developers each have their own fork which they can push and pull changes but other developers only can pull.
* requeirs two remotes:
	1. origin: Forked repo url. use for pushing and pulling changes
	2. upstream: original repo. use for pulling the last changes.
* when a feature development branch finished we push it to remote and fill a pull request with the pushed branch. then mainteiner decide to merge the feature into the original repo or not.