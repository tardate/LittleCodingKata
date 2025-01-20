# #306 git rebase all

How to rebase all local branches on the current master/main branch

## Notes

When working with many local branches, I prefer to rebase on a published commit when preparing to push.
Only large projects, it can be quite intimidating to see how much history has passed one by from the initial ideation point to when you are ready to commit!

Maintaining many local branches can lead to lots of terminal typing to get once;s branches in to line.

Here's a script/procedure for automatically rebasing all branches on the current master/main branch

### Script outline

Most repos have switched from calling their primary branch 'master' to 'main'. So first we figure out what the main branch is called:

    # Determine if the base branch is called 'main' else assume 'master'
    if git show-ref --verify --quiet refs/heads/main; then
      base_branch="main"
    else
      base_branch="master"
    fi

Then we can iterate over all head branch commits using [git-for-each-ref](https://git-scm.com/docs/git-for-each-ref):

    git for-each-ref 'refs/heads/*' | \
      while read rev type ref; do
        branch=$(expr "$ref" : 'refs/heads/\(.*\)' )
        revs=$(git rev-list $rev..$base_branch)
        if [ -n "$revs" ]; then
          echo $branch needs update
          git checkout $branch && git rebase $base_branch
        fi
      done

We can tell if the branch has commits ahead of the primary branch by using [git rev-list](https://git-scm.com/docs/git-rev-list) and if needed, checkout the branch and rebase it.

Finally, it is nice to land on the main branch:

    # finish up on base branch
    git checkout $base_branch

The script [rebase_all.sh](./rebase_all.sh) demonstrates how this is done..

## Credits and References

* [git-for-each-ref](https://git-scm.com/docs/git-for-each-ref)
* [git rev-list](https://git-scm.com/docs/git-rev-list)
* [valid_atoms for ref filter](https://github.com/git/git/blob/master/ref-filter.c#L471)
