#!/usr/bin/pwsh
write-host "git remote prune origin"
git remote prune origin
$(git branch -vv | Where-Object { $_.contains('gone') } ).foreach( { $a = $_ -split "\s+"; git branch -D $a[1] })
git branch -a
