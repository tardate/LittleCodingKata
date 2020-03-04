# Visual Archiver

An Archive Management Interface for OS/2 v2.0 written in REXX

## Notes

> NB: this was written (and last tested!) in 1992

### System Requirements

VArc requires REXX and VREXX to be properly installed on your system. VArc is
written for VREXX2 which requires IBM OS/2 v2.0.

### About VREXX

I'm sure that Richard B. Lam from IBM's T.J. Watson Research Center won't mind
me plugging VREXX (c) Copyright IBM Corp.  1992
I highly recommended the product - it adds the flair that makes REXX just that
more than a superb job control language.

I picked VREXX up by anonymous ftp from <ftp-os2.nmsu.edu> under the filename
VREXX2.ZIP, though it's surely available elsewhere (anywhere that archives or
mirrors an archive of comp.binaries.os2 for example).

### About VArc

I started writing VArc one night because I couldn't figure out how to force
PMZIP (an never-the-less excellent product by Nico Mak) to handle archives other than
ZIPs. At first I thought that writing an archive management front end with REXX
was sheer madness, but after pondering it for a while, I decided it could
be done reasonably well. I might note here that if it hadn't been for VREXX, the
project would have ended up in the circular file pronto!

### Performance

I was surprised how well VArc works. However, you will notice an appreciable
delay in getting a contents listing of larger archives. Not much I can do about
that though.

### Supported Archive Utilities

Currently VArc is setup for and has been tested (sort of) with the following
archive systems (in order of preference where extensions are the same):

| No. | filename  | archive programs                                                       |
| --- | --------  | -------------------                                                    |
| -1- |  *.LZH    | LH.EXE v2.0 by Peter Fitzsimmons                                       |
| -2- |  *.ZIP    | ZIP.EXE 1.9 (C) 1990-1992 Mark Adler, Richard B. Wales,                |
|     |           | Jean-loup Gailly and Kai Uwe Rommel. UNZIP.EXE v5.0 (c) 1989 S.H.Smith |
| -3- |  *.ZIP    | PKZIP2.EXE/PKUNZIP2.EXE v1.01-OS/2 Prot Mode 7-21-89 by PKWARE         |
|     |           | (used if -2- not available)                                            |
| -4- |  *.ZOO    | ZOO.EXE v2.1 by Rahul Dhesi                                            |
| -5- |  *.ARC    | ARC.EXE v5.21 by ???                                                   |

### Starting VArc

From the command line:

* `VArc [filemask]`    .... starts VArc and tries to interpret 'filemask' as an archive file
* `VArc /h`            .... starts VArc and displays an info screen (very brief!)

From the WPS:

* double click VArc.cmd  .... starts VArc, display dialog for selecting archive file
* drop archive file onto VArc.cmd  .... uses VArc to open the archive file

### VArc Options
============
Once an archive file has been specified, a radio box menu is displayed with the following options:
  'Show contents'
      - displays the contents of the selected archive
  'Add/update a file'
      - allows you to select a new file to add to an archive
  'Add/update some files'
      - provide a filemask for adding more than one file to archive
  'Extract all files'
      - explodes the archive into the working directory
  'Extract some files'
      - allows you to provide a filemask to control file extraction
  'Delete a file'
      - select a file to delete from archive
  'Set working directory'
      - change the 'home' directory used for adding/extracting files
  'Set options'
      - current options
      (1) Include subdirectories - when set will try to include subdirectories when
          adding/extracting files if supported by archive utility
      (2) Display archive utility output - after each archive operation will display
          a log file using the system editor
  'Another archive'
       - select a new archive

### Current Archiving Capabilities


Many of the archive utilities supported have quite complex capabilities. VArc brings
them all down to (at least) the lowest common denominator! Basic operations supported
are:

* list archive contents
* add (update where appropriate)
* extract (over-write by default)
* delete file(s) from archive

The "Include subdirectories" option combines the concept of storing relative pathnames
in an archive file, and extracting files to their original path relative to the
current working directory. Absolute pathnames are not supported.

When the "include subdirectories" option is not set:

* Only filenames (not paths) are stored when adding files to an archive.
* Files will be extracted into the current working directory.

When the "include subdirectories" option is set:

* File paths relative to the working directory are stored in the archive.
* Additionally, VArc will try to get the archive utility to recurse through all sub-directories and rchive matching files. NB: most archive utilities will only do this properly if "*" or "*.*" is the file specification.
* Files will be extracted with pathnames relative to the working directory.
* Directories will be created as required.

### Adding Support for New/Other Archive Utilities

I've tried to make VArc as independant of the archive utility used as I can.
All the settings regarding archive utilities are stored in a stem variable
as (what I call) archive utility prototypes. To add a new archive utility
or to modify/update existing utilities, it should simply be a matter of
tweeking the archive prototypes (which are stored in a stem variable and
all set in a procedure called "SetArcParams" in the VArc source).

The one big assumption I've made is that when getting a listing of archive
contents, the output from the archive utility separates header and footer
info from the meat of the output with lines that contain at least 3 consecutive
hyphens (i.e. "---"). If this no longer remains true, then the procedure
"LogArchive" will need updating.

Let's have a look at the archive prototype to see how archive utilities are
incorporated into the script. (All that follows can be found in the procedure
"SetArcParams").

```
  arcmask='*.*z*'    -this defines the file mask used in the file selection
                      box. Luckily all the supported archive utilities make
                      archives with the letter "z" in the extention
  arcselect=1        -this is a global variable used to indicated the current
                      archive type
```

All the details of archive utilities are contained in a stem variable called
"arcproto"

```
  arcproto.number=4  -tells us how many different utility configs are present
```

Each config is contained in a "sub-"stem identified by its config number. Let's
look at the config for Zoo (which is utility #4)

```
  arcproto.4.ext='.ZOO'
    -this is the file extention associated with the archive files. Must be uppercase.

  arcproto.4.arcexe='ZOO.EXE'
    -the filename of the executable used for archiving. No pathnames please!
     The utility *must* be on the PATH.

  arcproto.4.unarcexe='ZOO.EXE'
    -the filename of the executable used for unarchiving. No pathnames please!
     The utility *must* be on the PATH.

  arcproto.4.arc='zoo a ~archive~ ~filemask~'
    -the command line used to archive files. Relative paths are stored in the
     archive, and subdirectories are recursed if possible. "Variables" are defined:
     ~archive~ is the name of the current archive file
     ~filemask~ is the specification of files to be archived

  arcproto.4.arcnosub='zoo a: ~archive~ ~filemask~'
    -the command line used to archive files without paths or recursion.
     "Variables" are defined as for arcproto.x.arc

  arcproto.4.unarc='zoo x.O ~archive~ ~filemask~'
    -the command line used to unarchive files with path info. Paths stored in
     the archive are created relative to the current working directory.
     Subdirectories are extracted if possible.

  arcproto.4.unarcnosub='zoo x:O ~archive~ ~filemask~'
    -the command line used to extract files into the current directory without
     paths.

  arcproto.4.list='zoo -l ~archive~ ~filemask~'
    -the command line used to list the contents of an archive file.

  arcproto.4.del='zoo DP ~archive~ ~filemask~'
    -the command line used to delete files matching the filemask from an archive.

  arcproto.4.parse="fsize d.1 d.2 fdd fmm fyy d.3 d.4 fname"
    -tells the program how to interpret the output of a file list. This string
     is actually as a prototype for a Parse statement. Key variables are:
       fsize        -file size (actual)
       fyy,fmm,fdd  -file date (year, month and day)
       fname        -file name
       d.           -stem variable to hold any rubbish in the output

  arcproto.4.startdelim='---'
    -the starting delimiter used when interpreting "list" output. This is the unique
     string appearing in the line immediately prior to the actual file details.

  arcproto.4.enddelim='---'
    -the ending delimiter used when interpreting "list" output. This is the unique
     string appearing in the line immediately after the actual file details. It may be
     the same as the "startdelim", since the program only starts looking for an ending
     delimiter after finding a starting delimiter.
```

Adding a new archive utility should be as simple as incrementing the
"arcproto.number" counter, and adding a new arcproto.(new number) stem

## Credits and References

* [REXX](https://en.wikipedia.org/wiki/Rexx) - wikipedia
