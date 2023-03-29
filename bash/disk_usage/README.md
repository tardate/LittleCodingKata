# disk usage

How to survey disk usage on linux systems.

## Notes

Using [du](https://man7.org/linux/man-pages/man1/du.1.html)
to get folder sizes on Linux-like systems (including macOS).

### Summary of a Specific Folder

The `s` option summarizes the content of a named folder:

```bash
$ sudo du -sh /sbin
1.2M /sbin
```

Or for all sub-directories:

```bash
$ sudo du -sh /sbin/*
  0B /sbin/apfs_hfs_convert
 16K /sbin/autodiskmount
 16K /sbin/disklabel
8.0K /sbin/dmesg
8.0K /sbin/dynamic_pager
156K /sbin/emond
 20K /sbin/fibreconfig
 12K /sbin/fsck
  0B /sbin/fsck_apfs
136K /sbin/fsck_cs
```

### Sorting the Results

The output of `du` is quite suitable for piping via `sort` and `head` to get a top 5 (for example):

```bash
$ sudo du -sh /sbin/*  | sort -rh | head -5
200K /sbin/launchd
156K /sbin/emond
136K /sbin/pfctl
136K /sbin/fsck_cs
 52K /sbin/nfsd
```

## Credits and References

* [How to Get the Size of a Directory in Linux](https://linuxize.com/post/how-get-size-of-file-directory-linux/)
* [du(1) — Linux manual page](https://man7.org/linux/man-pages/man1/du.1.html)
* [sort(1) — Linux manual page](https://man7.org/linux/man-pages/man1/sort.1.html)
* [head(1) — Linux manual page](https://man7.org/linux/man-pages/man1/head.1.html)
