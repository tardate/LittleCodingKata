#!/bin/sh
# invoke this from the directory you want to flake8/blame...

flake8 | awk -F ':' '{print $2 "," $2, $1}' | xargs -n2 git blame -f -L
