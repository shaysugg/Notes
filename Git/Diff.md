* `git diff` only show differences of un staged files. For showing differences for staged files `git diff --staged` should be used and For seeing all of the changes `git diff HEAD`.
* Changes between two commits `git diff 1234abc..6789def`
* Changes made in the last three commits `git diff @~3..@`
* `git diff --stat` show a summery of file changes (change line numbers and types) without showing the actual changes.