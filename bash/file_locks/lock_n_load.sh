#!/bin/sh
#

resource=`basename "$0"`;
resource_lock="./${resource}.lock";

which flock > /dev/null
if [ $? -eq 0 ]
then
  exec 8>$resource_lock
  locker='flock -n -x 8'
else
  which lockfile > /dev/null
  if [ $? -eq 0 ]
  then
    locker='lockfile "${resource_lock}"'
  else
    echo "no flock or lockfile utility found.."
    locker='which lockfile'
  fi
fi

if eval $locker
then
  echo "[$$] Locked "
  echo "[$$] Doing something interesting here... $(date)"
  sleep 5
  echo "[$$] Loaded"
  rm -f "${resource_lock}"
else
  echo "[$$] Failed to lock"
fi
