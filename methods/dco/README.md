# #354 DCO

About the Developer Certificate of Origin and how to support it with git

## Notes

The Developer Certificate of Origin (DCO) is a mechanism for contributors to certify that they wrote or otherwise have the right to submit the code they are contributing to the project.

It appears increasingly common for open-source projects to require DCO compliance,
perhaps largely to address concerns over supply-chain attacks.

The DCO was created in 2004 by the Linux Foundation for the Linux kernel project, following licensing and copyright concerns. Instead of requiring every contributor to sign a legal document, the DCO allowed developers to simply include a "Signed-off-by" statement in each commit message.

The [full text of the DCO](https://developercertificate.org/):

> Developer Certificate of Origin
>
> Version 1.1
>
>Copyright (C) 2004, 2006 The Linux Foundation and its contributors.
>
> Everyone is permitted to copy and distribute verbatim copies of this
> license document, but changing it is not allowed.
>
> Developer's Certificate of Origin 1.1
>
> By making a contribution to this project, I certify that:
>
> (a) The contribution was created in whole or in part by me and I
> have the right to submit it under the open source license
> indicated in the file; or
>
> (b) The contribution is based upon previous work that, to the best
> of my knowledge, is covered under an appropriate open source
> license and I have the right under that license to submit that
> work with modifications, whether created in whole or in part
> by me, under the same open source license (unless I am
> permitted to submit under a different license), as indicated
> in the file; or
>
> (c) The contribution was provided directly to me by some other
> person who certified (a), (b) or (c) and I have not modified
> it.
>
> (d) I understand and agree that this project and the contribution
> are public and that a record of the contribution (including all
> personal information I submit with it, including my sign-off) is
> maintained indefinitely and may be redistributed consistent with
> this project or the open source license(s) involved.

## How to comply using git

Git has a `-s` command line option to append this automatically to your commit message:

```sh
git commit -s -m 'This is my commit message'
```

To ensure sign-off is applied to every commit in a repo, can add a hook template as follows.

```sh
$ cat > .git/hooks/prepare-commit-msg << EOT
#!/bin/sh
SOB=\$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
grep -qs "^\$SOB" "\$1" || echo "\\n\$SOB" >> "\$1"
EOT
$ chmod u+x .git/hooks/prepare-commit-msg
$ cat .git/hooks/prepare-commit-msg
#!/bin/sh
SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
grep -qs "^$SOB" "$1" || echo "\n$SOB" >> "$1"
```

## Credits and References

* <https://developercertificate.org/>
* <https://github.com/apps/dco>
