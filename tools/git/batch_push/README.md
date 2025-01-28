# #318 Git Batch Push

Using a batch push technique to overcome 2GB GitHub limits.

## Notes

GitHub has a maximum [2 GB limit](https://docs.github.com/en/get-started/using-git/troubleshooting-the-2-gb-push-limit) for a single push.

I've usually hit this problem when trying to upload very large repositories for the first time.
An example is the [LittleArduinoProjects archive](https://github.com/tardate/LittleArduinoProjects-archive-2014-2024) (prior to a 10th anniversary squash).

When the size is due to a long history of multiple smaller commits, the general solution is to break up the push into multiple steps - the "batch push".

The problem and solution is [discussed on stackoverflow](https://stackoverflow.com/questions/15125862/github-remote-push-pack-size-exceeded) and also covered in
[GitHub docs](https://docs.github.com/en/get-started/using-git/troubleshooting-the-2-gb-push-limit).

The following demonstrates the problem and a scripted solution.

### The Problem

The [LittleArduinoProjects-archive-2014-2024](https://github.com/tardate/LittleArduinoProjects-archive-2014-2024) repository is an example of one that
exceeds the 3 GB limit.

If I attempt to push it all in one go to a new repository (`example-big-repo-clone`), it fails with the error
`pack exceeds maximum allowed size (2.00 GiB)` error:

    $ git clone git@github.com:tardate/LittleArduinoProjects-archive-2014-2024.git example-big-repo
    Cloning into 'example-big-repo'...
    remote: Enumerating objects: 42502, done.
    remote: Counting objects: 100% (3/3), done.
    remote: Compressing objects: 100% (3/3), done.
    remote: Total 42502 (delta 0), reused 1 (delta 0), pack-reused 42499 (from 1)
    Receiving objects: 100% (42502/42502), 3.42 GiB | 7.34 MiB/s, done.
    Resolving deltas: 100% (20890/20890), done.
    Updating files: 100% (7798/7798), done.
    $ cd example-big-repo
    $ git branch -v
    * master 77830698 notes on the 10th anniversary archive and squash (#108)
    $ git remote add clone git@github.com:tardate/example-big-repo-clone.git
    $ git push -u clone master
    Enumerating objects: 42502, done.
    Counting objects: 100% (42502/42502), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (20568/20568), done.
    remote: fatal: pack exceeds maximum allowed size (2.00 GiB)
    error: remote unpack failed: index-pack failed
    To github.com:tardate/example-big-repo-clone.git
    ! [remote rejected]   master -> master (failed)
    error: failed to push some refs to 'github.com:tardate/example-big-repo-clone.git'
    $

### Batch Push Solution

There are various approaches to batching. The example I'll use take the relative naïve approach:

* count the number of commits
* use [seq](https://man7.org/linux/man-pages/man1/seq.1.html) to iterate the commits in batches of BATCH_SIZE (default: 500)
* for each batch:
    * find the commit corresponding to the batch point
    * push up to that specific commit
* push any remaining commits

I've scripted this in [git_batch_push.sh](./git_batch_push.sh). Let's try that push again, this time by batches:

    $ ../git_batch_push.sh clone
    >> remote branch not found. Pushing all commits (HEAD)...
    >> preparing to push     2392 commits to clone/master in batches of 500...
    >> pushing batch 1 : 876f8bf16cd52675fdc022b046b28e6240a31c21...
    Enumerating objects: 6, done.
    Counting objects: 100% (6/6), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (5/5), done.
    Writing objects: 100% (6/6), 1.21 KiB | 1.21 MiB/s, done.
    Total 6 (delta 0), reused 6 (delta 0), pack-reused 0
    To github.com:tardate/example-big-repo-clone.git
    * [new branch]        876f8bf16cd52675fdc022b046b28e6240a31c21 -> master
    >> pushing batch 2 : c51f3d216342436db22e3e353fd257b97b672cf3...
    Enumerating objects: 4504, done.
    Counting objects: 100% (4504/4504), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (2391/2391), done.
    Writing objects: 100% (4501/4501), 442.26 MiB | 2.63 MiB/s, done.
    Total 4501 (delta 2048), reused 4222 (delta 2042), pack-reused 0
    remote: Resolving deltas: 100% (2048/2048), done.
    To github.com:tardate/example-big-repo-clone.git
      876f8bf1..c51f3d21  c51f3d216342436db22e3e353fd257b97b672cf3 -> master
    >> pushing batch 3 : 21f91842c2b7abca6e732024359091826ee7b0c3...
    Enumerating objects: 6664, done.
    Counting objects: 100% (6664/6664), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (3374/3374), done.
    Writing objects: 100% (6368/6368), 525.89 MiB | 2.53 MiB/s, done.
    Total 6368 (delta 2954), reused 5714 (delta 2843), pack-reused 0
    remote: Resolving deltas: 100% (2954/2954), completed with 174 local objects.
    To github.com:tardate/example-big-repo-clone.git
      c51f3d21..21f91842  21f91842c2b7abca6e732024359091826ee7b0c3 -> master
    >> pushing batch 4 : 34f40da9d198d00a5858ed9323e9d044e60f6f77...
    Enumerating objects: 7636, done.
    Counting objects: 100% (7636/7636), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (3606/3606), done.
    Writing objects: 100% (7160/7160), 583.59 MiB | 2.64 MiB/s, done.
    Total 7160 (delta 3695), reused 6460 (delta 3404), pack-reused 0
    remote: Resolving deltas: 100% (3695/3695), completed with 402 local objects.
    To github.com:tardate/example-big-repo-clone.git
      21f91842..34f40da9  34f40da9d198d00a5858ed9323e9d044e60f6f77 -> master
    >> pushing batch 5 : 57ec544623bf57af76ae003758fc93044a6c66e3...
    Enumerating objects: 11284, done.
    Counting objects: 100% (11284/11284), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (5011/5011), done.
    Writing objects: 100% (10512/10512), 737.68 MiB | 2.60 MiB/s, done.
    Total 10512 (delta 5455), reused 9929 (delta 5174), pack-reused 0
    remote: Resolving deltas: 100% (5455/5455), completed with 606 local objects.
    To github.com:tardate/example-big-repo-clone.git
      34f40da9..57ec5446  57ec544623bf57af76ae003758fc93044a6c66e3 -> master
    >> pushing final batch 6 : HEAD...
    Enumerating objects: 15731, done.
    Counting objects: 100% (15731/15731), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (8464/8464), done.
    Writing objects: 100% (14345/14345), 1.32 GiB | 2.57 MiB/s, done.
    Total 14345 (delta 5545), reused 14218 (delta 5531), pack-reused 0
    remote: Resolving deltas: 100% (5545/5545), completed with 1149 local objects.
    To github.com:tardate/example-big-repo-clone.git
      57ec5446..77830698  HEAD -> master

All complete!

### The Script

See [git_batch_push.sh](./git_batch_push.sh)

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

## Credits and References

* [Github remote push pack size exceeded](https://stackoverflow.com/questions/15125862/github-remote-push-pack-size-exceeded)
* [Troubleshooting the 2 GB push limit](https://docs.github.com/en/get-started/using-git/troubleshooting-the-2-gb-push-limit)
* [seq man page](https://man7.org/linux/man-pages/man1/seq.1.html)
