#!/bin/bash

targetBranch=develop
if (( $# > 1 ))
then
  targetBranch=$1
fi
git fetch
mergeBase=$(git merge-base HEAD "origin/$targetBranch")
git diff "$mergeBase"...
