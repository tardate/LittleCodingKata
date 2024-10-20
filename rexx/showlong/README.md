# #132

Expose Long/HPFS filenames with REXX on OS/2

## Notes

> NB: this was written (and last tested!) in 1993


### System Requirements

ShowLong requires REXX to be properly installed on your system. It also
requires RXQUEUE.EXE which should be found in C:\OS2. It has been developed
under IBM OS/2 v2.x - I'm not sure how it will go under previous versions.

### About ShowLong

ShowLong is used to expose all of the files/directories in a specified direcory
tree that have names that don't conform to the DOS FAT 8.3 standard.
It simply lists all offending files with full path info - its up to you
to decide what you do with the information!

The utility was initially developed to provide a quick "DOS compatibility"
check for files being moved between environments, but has other uses such
as when preparing to migrate an HPFS partition to FAT.

### Using ShowLong

```
Getting help:     SHOWLONG /?
Usage:
       SHOWLONG [RootDir]
```

Output is a list of all files/directories with non-DOS FAT 8.3 names.

Where `RootDir` is the "root" directory from where to start the scan of files. The
default is the current directory. Note that scans will search all
sub-directories.
Eg: to scan all of D: drive:

```
  SHOWLONG D:\
```

NB: It is possible to use file masks if appropriate:

```
  SHOWLONG D:\*.doc
```

## Credits and References

* [REXX](https://en.wikipedia.org/wiki/Rexx) - wikipedia
