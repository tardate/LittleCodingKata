# #133

Directory Size Scanner for OS/2 v2.0 written in REXX

## Notes

> NB: this was written (and last tested!) in 1993

### System Requirements

DirSize requires REXX to be properly installed on your system. It also
requires RXQUEUE.EXE which should be found in C:\OS2. It has been developed
under IBM OS/2 v2.0 - I'm not sure how it will go under previous versions.

### About DirSize

DirSize started off as a simple utility to find out who the hell was using
up the space on our file server. It still is a simple utility!
All it does is list directories/sub-directories and tell you how much space each
consumes. It is possible to get the list sorted by size, and also to prevent
the reporting of directories that do not meet a "minimum size" for reporting.

Note that the DIR command can give you all the size details that DirSize reports.
DirSize simply reports the info better.

### Using DirSize

```
Getting help:     DIRSIZE /?

Usage:
       DIRSIZE [filespec] [dir options] [/D] [/Mxxx]
```

Output is generally a list with each line having the form:
`<full directory path><tab><size used><space>"bytes"`

Use the standard options you would use with the DIR command to tell DIRSIZE
where and what to scan. For example, to scan all of C:\OS2PROJ\REXX use

Example:
```
DIRSIZE C:\os2proj\rexx
  DirSize v1.0 (c) Paul Gallagher 1993 {paulg@a1.resmel.bhp.com.au}

  C:\os2proj\rexx 45815 bytes
  C:\os2proj\rexx\chat    15518 bytes
  C:\os2proj\rexx\db2inf  10721 bytes
  C:\os2proj\rexx\db2inf\test     193466 bytes
  C:\os2proj\rexx\rps     235995 bytes
  C:\os2proj\rexx\VArc    37497 bytes

  Size of directory tree: 539012 bytes
```

Note that DirSize *always* scans and reports on subdirectories under the directory
specified. If you just want to know how much space the directory c:\os2 uses, then
shit, use DIR!
Although you can use all of the parameters permitted by DIR, many don't make sense
when using DirSize (such as /O, /L or /S).


The /D parameter requests DirSize to order the directories in order of space used.
By default, most hungry dirs are shown first!

Example:
```
DIRSIZE C:\os2proj\rexx /D
  DirSize v1.0 (c) Paul Gallagher 1993 {paulg@a1.resmel.bhp.com.au}

  C:\os2proj\rexx\rps     235995 bytes
  C:\os2proj\rexx\db2inf\test     193466 bytes
  C:\os2proj\rexx 45815 bytes
  C:\os2proj\rexx\VArc    37497 bytes
  C:\os2proj\rexx\chat    15518 bytes
  C:\os2proj\rexx\db2inf  10721 bytes

  Size of directory tree: 539012 bytes
```

The /M parameter is used to mask the output listing based upon space used. For
a parameter /Mxxx, only directories using more than 'xxx' bytes are displayed.
However, all directories regardless of size are still scanned - only the report is
affected.
The /M paramter must appear last on the command line.
The /M can appear with or without the /D parameter.

Example:
```
DIRSIZE C:\os2proj\rexx /D /M40000
  DirSize v1.0 (c) Paul Gallagher 1993 {paulg@a1.resmel.bhp.com.au}

  C:\os2proj\rexx\rps     235995 bytes
  C:\os2proj\rexx\db2inf\test     193466 bytes
  C:\os2proj\rexx 45815 bytes

  Size of listed directories: 475276 bytes
  Size of directory tree: 539012 bytes
```

## Credits and References

* [REXX](https://en.wikipedia.org/wiki/Rexx) - wikipedia
