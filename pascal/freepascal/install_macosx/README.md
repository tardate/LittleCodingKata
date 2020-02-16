# Installing Free Pascal

Installing and running the Free Pascal compiler on MacOSX.

## Notes

I haven't written or used any [Pascal](https://en.wikipedia.org/wiki/Pascal_(programming_language)) code for decades.
But it was my first love when it comes to computer languages.
It's where I first learned structured and object-oriented programming techniques.

I'm curious about the state of PAscal. Does anyone still use it much? CAN you even use it on modern machines?

First step is obviously just to try and get it installed...

### Documentation

The [documentation](https://www.freepascal.org/docs.html) page points to HTML online guides and PDF downloads.

I found the HTML rendering of the documentation to be a bit too fragmented, so went for downloads.
At the time I tried, the FTP server was down, but I could find the files in
[sourceforge](https://sourceforge.net/projects/freepascal/files/Documentation/3.0.4/)


### Compiling the Source [FAIL]

The [sourceforge files page](https://sourceforge.net/projects/freepascal/files/Source/3.0.4/) offers

* fpc-3.0.4.source.tar.gz - just the compiler source
* fpcbuild-3.0.4.tar.gz - entire project, including compiler source, documentation, examples etc

I didn't get far however...

```
$ tar zxvf fpc-3.0.4.source.tar.gz
$ cd fpc-3.0.4
$ make all
make: -iVSPTPSOTO: Command not found
Makefile:2790: *** The only supported starting compiler version is 3.0.2. You are trying to build with ..  Stop.
```

I haven't dug further to find out what is going on here.

### Binary Installation

The [sourceforge files page](https://sourceforge.net/projects/freepascal/files/Source/3.0.4/)
offered `fpc-3.0.4a.intel-macosx.dmg` (108.4 MB) for download.

![installed](./assets/installed.png?raw=true)

### Test Drive

```
$ which fpc
/usr/local/bin/fpc
$ fpc -h
Free Pascal Compiler version 3.0.4 [2018/09/30] for x86_64
Copyright (c) 1993-2017 by Florian Klaempfl and others
fpc [options] <inputfile> [options]
 Only options valid for the default or selected platform are listed.
  [... lots of option documentation ...]
  -?     Show this help
  -h     Shows this help without waiting
```

Looks like I have a few free pascal compiler bits installed:

```
$ ls -1 /usr/local/bin/fpc*
/usr/local/bin/fpc
/usr/local/bin/fpcjres
/usr/local/bin/fpclasschart
/usr/local/bin/fpcmake
/usr/local/bin/fpcmkcfg
/usr/local/bin/fpcres
/usr/local/bin/fpcreslipo
/usr/local/bin/fpcsubst
```

### Compiling Hello World!

```
$ fpc hello.pp
Free Pascal Compiler version 3.0.4 [2018/09/30] for x86_64
Copyright (c) 1993-2017 by Florian Klaempfl and others
Target OS: Darwin for x86_64
Compiling hello.pp
Assembling (pipe) hello.s
Linking hello
10 lines compiled, 0.1 sec
$ ./hello
What the Blaises is going on here?
```

All good!

## Credits and References

* [freepascal](https://www.freepascal.org/)
* [sourceforge files page](https://sourceforge.net/projects/freepascal/files/Source/3.0.4/)
* [Pascal](https://en.wikipedia.org/wiki/Pascal_(programming_language))
