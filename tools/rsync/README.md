# #xxx rsync

All about rsync - a fast, versatile, local and remote file-copying tool

## Notes

The [rsync](https://rsync.samba.org/) utility is available on Linux and macOS (and other platforms).

It is primarily used to backup/mirror files to another location.
The destination may be local, or remote (over SSH).

The main benefits of rsync over other methods:

* it is smart enough to only copy modifications (making it far superior to `cp` for example)
* it is incremental, and can resume partial replications (making it superior to say `sftp`)

The command has [many options](https://linux.die.net/man/1/rsync) to modify its behaviour.
Let's look at 3 main scenarios:

* simple backup
* pure mirror
* remote sync

### Simple Backup

By simple backup, I mean we want to copy all files to the destination,
but don't care if the destination has additional files (they should be preserved).

The `-a, --archive` "super" option configures a decent backup mode, equating to:

* `-r, --recursive` : recurse into directories
* `-l, --links` : copy symlinks as symlinks
* `-p, --perms` : preserve permissions
* `-t, --times` : preserve modification times
* `-g, --group` : preserve group
* `-o, --owner` : preserve owner (super-user only)
* `-D` : same as `--devices` (transfer character and block device files) and `--specials` (transfer special files such as named sockets and fifos)

Additional options that may be added:

* `-u, --update` : skip files that are newer on the receiver
* `-v, --verbose` : increase verbosity

So for a simple backup command I will often just use the `-av` options.

```sh
user@rsync1> rsync -av backup-source/ backup-dest/
```

The [backup-example.sh](./backup-example.sh) script uses rsync to demonstrate how it:

* performs the initial sync
* incrementally updates with changes
    * handles new files added to the source
    * handles modified files in to the source
    * handles files removed from the destination
    * ignores additional files in the destination
    * updates modified files in the destination

Running the example:

```sh
$ ./backup-example.sh
Making a fresh copy of ./tmp/original
## performs the initial sync: ./tmp/original/ to ./tmp/copy/
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

sent 667 bytes  received 170 bytes  760909 bytes/sec
total size is 32  speedup is 0.04
## handles new files added to the source: add 3.txt to source
Transfer starting: 10 files
3.txt

sent 419 bytes  received 42 bytes  419090 bytes/sec
total size is 34  speedup is 0.07
## handles modified files in to the source: update 2.txt in source
Transfer starting: 10 files
2.txt

sent 429 bytes  received 42 bytes  428181 bytes/sec
total size is 44  speedup is 0.09
## handles files removed from the destination: removing 1.txt from dest
Transfer starting: 10 files
1.txt

sent 419 bytes  received 42 bytes  4610000 bytes/sec
total size is 44  speedup is 0.10
## ignores additional files in the destination: add bogus.txt to dest
Transfer starting: 10 files
./

sent 377 bytes  received 26 bytes  4030000 bytes/sec
total size is 44  speedup is 0.11
## updates modified files in the destination: update 2.txt in dest
Transfer starting: 10 files
2.txt

sent 429 bytes  received 42 bytes  428181 bytes/sec
total size is 44  speedup is 0.09
## shows the differences between source and destination
Only in ./tmp/copy: bogus.txt
Common subdirectories: ./tmp/original/sub1 and ./tmp/copy/sub1
Common subdirectories: ./tmp/original/sub2 and ./tmp/copy/sub2
```

### Pure Mirror

For a mirror, we want the destination to match the source exactly.
This can be achieved by adding the `--delete` option:

* `--delete` : delete extraneous files from dest dirs

```sh
user@rsync1> rsync -av --delete backup-source/ backup-dest/
```

The [mirror-example.sh](./mirror-example.sh) script uses rsync to demonstrate how it:

* performs the initial sync
* incrementally updates with changes
    * handles new files added to the source
    * handles modified files in to the source
    * handles files removed from the destination
    * removes additional files in the destination
    * updates modified files in the destination

Running the example:

```sh
$ ./mirror-example.sh
Making a fresh copy of ./tmp/original
## performs the initial sync: ./tmp/original/ to ./tmp/copy/
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

sent 671 bytes  received 170 bytes  764545 bytes/sec
total size is 32  speedup is 0.04
## handles new files added to the source: add 3.txt to source
Transfer starting: 10 files
3.txt

sent 423 bytes  received 42 bytes  422727 bytes/sec
total size is 34  speedup is 0.07
## handles modified files in to the source: update 2.txt in source
Transfer starting: 10 files
2.txt

sent 433 bytes  received 42 bytes  431818 bytes/sec
total size is 44  speedup is 0.09
## handles files removed from the destination: removing 1.txt from dest
Transfer starting: 10 files
1.txt

sent 423 bytes  received 42 bytes  422727 bytes/sec
total size is 44  speedup is 0.09
## removes additional files in the destination: add bogus.txt to dest
Transfer starting: 10 files
./bogus.txt: deleting

sent 375 bytes  received 20 bytes  359090 bytes/sec
total size is 44  speedup is 0.11
## updates modified files in the destination: update 2.txt in dest
Transfer starting: 10 files
2.txt

sent 433 bytes  received 42 bytes  431818 bytes/sec
total size is 44  speedup is 0.09
## shows the differences between source and destination
Common subdirectories: ./tmp/original/sub1 and ./tmp/copy/sub1
Common subdirectories: ./tmp/original/sub2 and ./tmp/copy/sub2
```

### Remote Sync

To sync remotely, specify the destination in an ssh-compatible form e.g.

```sh
user@rsync1> rsync -av rsync-test/ user@rsync2:rsync-test/
```

Setup ssh no-password by adding public key to `.ssh/authorized_hosts` on the remote server.

Note the `-e, --rsh=COMMAND` can be used to choose an alternative remote shell program, but `ssh` is the default.

## Credits and References

* [rsync web pages](https://rsync.samba.org/)
* [rsync man page](https://linux.die.net/man/1/rsync)
* [Linux Server Hacks](../../infrastructure/linux_server_hacks/) - chapter 3: Backups
* [#047 Sync Folder](../../bash/sync_folder/)
