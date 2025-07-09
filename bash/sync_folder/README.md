# #047 Sync Folder

Comparing methods for synchronizing local folders - cp, rsync.

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

```sh
$ ./make_example_source.sh
Making a fresh copy of ./tmp/original
$ ./use_recursive_copy.sh
Making a copy of ./tmp/original in ./tmp/copy
```

The [make_example_source.sh](./make_example_source.sh) script just creates some files and folders under `./tmp/original` for the test:

```bash
source_path=./tmp/original

echo "Making a fresh copy of ${source_path}"
rm -fR ${source_path}
mkdir -p ${source_path}
echo "1" > ${source_path}/1.txt
echo "2" > ${source_path}/2.txt
mkdir ${source_path}/sub1
echo "sub1 1" > ${source_path}/sub1/1.txt
echo "sub1 2" > ${source_path}/sub1/2.txt
mkdir ${source_path}/sub2
echo "sub2 2" > ${source_path}/sub2/1.txt
echo "sub2 2" > ${source_path}/sub2/2.txt
```

The [use_recursive_copy.sh](./use_recursive_copy.sh) script makes a copy of `./tmp/original` in `./tmp/copy`:

```bash
source_path=./tmp/original
destination_path=./tmp/copy
if [ -e ${destination_path} ] ; then
  rm -fR ${destination_path}
fi
echo "Making a copy of ${source_path} in ${destination_path}"
cp -R ${source_path} ${destination_path}
```

### Using rsync

Most *nix-type systems will have an `rsync` program available (or it can be installed).
See [#338 rsync](../../tools/rsync/) for more.
Advantages:

* can do a proper mirror, including propagating deletions
* efficient - only copies differences

Disadvantages:

* may not be natively available
* a little more unusual - need to read the man page

Example:

```sh
$ ./make_example_source.sh
Making a fresh copy of ./tmp/original
$ ./use_rsync.sh
Performing pristine copy of ./tmp/original/ to ./tmp/copy
Transfer starting: 9 files
./
1.txt
2.txt
sub1/
sub1/1.txt
sub1/2.txt
sub2/
sub2/1.txt
sub2/2.txt

sent 667 bytes  received 170 bytes  270000 bytes/sec
total size is 32  speedup is 0.04
Adding 3.txt to source and removing 1.txt from dest
And update with sync..
Transfer starting: 10 files
1.txt
3.txt

sent 467 bytes  received 64 bytes  482727 bytes/sec
total size is 34  speedup is 0.06
```

The [use_rsync.sh](./use_rsync.sh) script uses rsync and demonstrates how it:

* performs the initial sync
* incrementally updates with changes
* handles new files added to the source
* handles files removed from the destination

```bash
source_path=./tmp/original/
destination_path=./tmp/copy

echo "Performing pristine copy of ${source_path} to ${destination_path}"
rm -fR ${destination_path}
rsync -av ${source_path} ${destination_path}

echo "Adding 3.txt to source and removing 1.txt from dest"
echo "3" > ${source_path}3.txt
rm ${destination_path}/1.txt

echo "And update with sync.."
rsync -av ${source_path} ${destination_path}
```

## Credits and References

* [cp man page](https://linux.die.net/man/1/cp)
* [rsync man page](https://linux.die.net/man/1/rsync)
