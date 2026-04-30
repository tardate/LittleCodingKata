#!/usr/bin/env bash

function runExample() {
  local method="$1"
  perl example.pl "$method"
  local rc=$?
  echo "Exit code: $rc"
}

echo "Running carp examples..."
runExample "carp"
runExample "cluck"
runExample "croak"
runExample "confess"
runExample "read-file-ok"
runExample "read-file-bad"
runExample "settings"
