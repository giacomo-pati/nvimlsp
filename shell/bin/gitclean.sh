#!/bin/sh
echo "git remote prune origin"
git remote prune origin
for i in $(git branch -vv | grep gone | awk '{print $1}'); do
  git branch -D "$i"
done
git gc --auto --aggressive
GIT_PAGER="cat" git branch -a
