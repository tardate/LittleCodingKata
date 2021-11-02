# #060 File Locks

How to implement simple resource semaphores with file locks.


## Notes

For when we want to ensure that only one instance of a shell script can be run at the same time.

Operating system locks/semaphores can be used to traffic-light an operation.
From a scripting environment, a utility must be used to get a lock - for example
[flock](https://linux.die.net/man/1/flock)
or [man lockfile](https://linux.die.net/man/1/lockfile).

### flock / lockfile

The `flock` utility should be available by default in most Linux distros.
It used to be in MacOS also, but not since at least Yosemite.
On MacOS, `lockfile` should be available though. The test script will look for either.

### TestScript

The [lock_n_load.sh](./lock_n_load.sh) script demonstrates locking with either `flock`
parsing an invented syntax from an environment variable.

```
$ ./lock_n_load.sh & ./lock_n_load.sh
[27428] Locked
[27428] Doing something interesting here... Mon Oct  9 23:13:27 SGT 2017
[27428] Loaded
[27427] Locked
[27427] Doing something interesting here... Mon Oct  9 23:13:35 SGT 2017
[27427] Loaded
$
```

## Credits and References
* [man flock](https://linux.die.net/man/1/flock)
* [man lockfile](https://linux.die.net/man/1/lockfile)
* [using flock to protect critical sections in shell scripts  ](http://jdimpson.livejournal.com/5685.html)
* [Mac OS X equivalent of Linux flock(1) command](https://stackoverflow.com/questions/10526651/mac-os-x-equivalent-of-linux-flock1-command)
