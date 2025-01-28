#!/usr/bin/env bash
#

if [ -z "$1" ]; then
  echo "Warning: No remote specified. Usage: $0 <remote>"
  exit 1
else
  REMOTE=$1
fi

BRANCH=$(git rev-parse --abbrev-ref HEAD)
BATCH_SIZE=${BATCH_SIZE:-500}

# check if the branch exists on the remote
if git show-ref --quiet --verify refs/remotes/$REMOTE/$BRANCH; then
    # if so, only push the commits that are not on the remote already
    range=$REMOTE/$BRANCH..HEAD
    echo ">> remote branch already present. Only pushing new commits (${range})..."
else
    # else push all the commits
    range=HEAD
    echo ">> remote branch not found. Pushing all commits (${range})..."
fi

# count the number of commits to push
commits=$(git log --first-parent --format=format:x $range | wc -l)
echo ">> preparing to push ${commits} commits to ${REMOTE}/${BRANCH} in batches of ${BATCH_SIZE}..."

# push each batch
batch=1
for i in $(seq ${commits} -$BATCH_SIZE 1); do
    # get the hash of the commit to push
    commit=$(git log --first-parent --reverse --format=format:%H --skip $i -n1)
    echo ">> pushing batch ${batch} : ${commit}..."
    batch=$((batch + 1))
    git push $REMOTE ${commit}:refs/heads/$BRANCH
done

# push the final partial batch
commit="HEAD"
echo ">> pushing final batch ${batch} : ${commit}..."
git push $REMOTE ${commit}:refs/heads/$BRANCH
