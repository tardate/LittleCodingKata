# sync_folder

Comparing methods for synchronizing local folders - cp, rsync.

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

Problem: need to make or update a copy of a folder to another local folder.
This may be for deployment purposes or just some disk management.

### Recursive Copy

On *nix-type systems, the `cp -R` makes a recursive copy.

Advantages:

* simple
* built-in shell command (no dependencies)

Disadvantages:

* does not help making a true mirror (i.e. deletions do not propagate)
* inefficient - copies everything even if redundant

Example:

```
$ ./make_example_source.sh
Making a fresh copy of ./original
$ ./use_recursive_copy.sh
Making a copy of ./original in ./copy
```

### Using rsync

Most *nix-type systems will have an `rsync` program available (or it can be installed).

Advantages:

* can do a proper mirror, including propagating deletions
* efficient - only copies differences

Disadvantages:

* may not be natively available
* a little more unusual - need to read the man page


Example:

```
$ ./make_example_source.sh
Making a fresh copy of ./original
$ ./use_rsync.sh
Performing pristine copy of ./original/ to ./copy
building file list ... done
created directory ./copy
./
1.txt
2.txt
sub1/
sub1/1.txt
sub1/2.txt
sub2/
sub2/1.txt
sub2/2.txt

sent 512 bytes  received 170 bytes  1364.00 bytes/sec
total size is 32  speedup is 0.05
Adding 3.txt to source and removing 1.txt from dest
And update with sync..
building file list ... done
1.txt
3.txt

sent 305 bytes  received 64 bytes  738.00 bytes/sec
total size is 34  speedup is 0.09
```

## Credits and References
* [cp man page](https://linux.die.net/man/1/cp)
* [rsync man page](https://linux.die.net/man/1/rsync)
