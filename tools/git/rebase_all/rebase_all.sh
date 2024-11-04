#!/usr/bin/env bash

# Determine if the base branch is called 'main' or 'master'
if git show-ref --verify --quiet refs/heads/main; then
  base_branch="main"
else
  base_branch="master"
fi

git for-each-ref 'refs/heads/*' | \
  while read rev type ref; do
    branch=$(expr "$ref" : 'refs/heads/\(.*\)' )
    revs=$(git rev-list $rev..$base_branch)
    if [ -n "$revs" ]; then
      echo $branch needs update
      git checkout $branch && git rebase $base_branch
    fi
  done

# finish up on base branch
git checkout $base_branch
