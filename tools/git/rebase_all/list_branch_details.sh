#!/usr/bin/env bash

git for-each-ref --shell --format="ref=%(refname);upstream=%(upstream)" 'refs/heads/*' | \
while read entry
do
  eval "$entry"
  echo "entry = $entry"
  echo "ref = $ref"
  echo "upstream = $upstream"
  echo `dirname $ref`
done
