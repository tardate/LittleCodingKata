# Finding Files

Examples of various ways to find files

## Notes

The [find](http://man7.org/linux/man-pages/man1/find.1.html) utility is quite flexible for
searching a folder tree for files matching various conditions and then chaining actions if required.

### Using Find

Finding files under a root matching a name:

```
$ find .. -name .catalog*
../finding_files/.catalog_metadata
../function_inference/.catalog_metadata
../case_statement/.catalog_metadata
../sync_folder/.catalog_metadata
../file_locks/.catalog_metadata
../parse_env_setting/.catalog_metadata
../select_menu/.catalog_metadata
../loops/.catalog_metadata
../process_lines/.catalog_metadata
```

With a max depth constraint:

```
$ find ../.. -name *catalog* -maxdepth 2
../../catalog
../../catalog/.catalog_metadata
../../catalog/catalog.json
../../_site/catalog
```

With a max depth and only files constraint:

```
$ find ../.. -name *catalog* -maxdepth 2  -type f
../../catalog/.catalog_metadata
../../catalog/catalog.json
```

Performing an action with each file:

```
$ find .. -name .catalog* -exec ls -s {} \;
8 ../finding_files/.catalog_metadata
8 ../function_inference/.catalog_metadata
8 ../case_statement/.catalog_metadata
8 ../sync_folder/.catalog_metadata
8 ../file_locks/.catalog_metadata
8 ../parse_env_setting/.catalog_metadata
8 ../select_menu/.catalog_metadata
8 ../loops/.catalog_metadata
8 ../process_lines/.catalog_metadata
```

With a modified time constraint:

$ find .. -name .catalog* -mtime +60 -exec ls -s {} \;
8 ../function_inference/.catalog_metadata
8 ../case_statement/.catalog_metadata
8 ../sync_folder/.catalog_metadata
8 ../file_locks/.catalog_metadata
8 ../parse_env_setting/.catalog_metadata
8 ../select_menu/.catalog_metadata
8 ../loops/.catalog_metadata
8 ../process_lines/.catalog_metadata
```

[Sort](http://man7.org/linux/man-pages/man1/sort.1.html) results by size (reverse order):

```
$ find ../.. -name *.jpg -exec ls -s {} \; | sort -k 1 -g -r
2896 ../../security/metasploit_penetration_testing_cookbook/metasploit-framework/data/exploits/pfsense_clickjacking/background.jpg
2896 ../../_site/security/metasploit_penetration_testing_cookbook/metasploit-framework/data/exploits/pfsense_clickjacking/background.jpg
616 ../../design/programming_interactivity/book_sources/ch13/13_12/data/earthbumps.jpg
616 ../../_site/design/programming_interactivity/book_sources/ch13/13_12/data/earthbumps.jpg
304 ../../design/programming_interactivity/book_sources/ch09/0904/streetbw.jpg
304 ../../_site/design/programming_interactivity/book_sources/ch09/0904/streetbw.jpg
264 ../../design/programming_interactivity/book_sources/ch13/13_12/data/earth.jpg
264 ../../_site/design/programming_interactivity/book_sources/ch13/13_12/data/earth.jpg
216 ../../staticweb/punch/testsite/templates/banner.jpg
216 ../../staticweb/punch/testsite/output/banner.jpg
152 ../../catalog/assets/images/nav-bg.jpg
152 ../../_site/catalog/assets/images/nav-bg.jpg
120 ../../design/programming_interactivity/book_sources/ch09/0905/streetrgb.jpg
120 ../../_site/design/programming_interactivity/book_sources/ch09/0905/streetrgb.jpg
64 ../../staticweb/jekyll/gh-pages-auto/images/highlight-bg.jpg
24 ../../staticweb/jekyll/gh-pages-auto/images/header-bg.jpg
8 ../../staticweb/jekyll/gh-pages-auto/images/sidebar-bg.jpg
8 ../../staticweb/jekyll/gh-pages-auto/images/body-bg.jpg
```

### Finding setuid/setgid Binaries

From [Linux Server Hacks #11](https://learning.oreilly.com/library/view/linux-server-hacks/0596004613/).

Binaries with [setuid/setgid permission](https://en.wikipedia.org/wiki/Setuid)
allow users to run an executable with the permissions of the executable's owner or group respectively,
and can thus be a security issue.

```
$ find /usr/bin -perm +6000 -type f -exec ls -ld {} \;
-r-xr-sr-x  1 root  tty  23920 Mar 28  2018 /usr/bin/write
-r-sr-xr-x  1 root  wheel  88400 Jul  4  2018 /usr/bin/top
-r-sr-xr-x  1 root  wheel  83680 Jan 24 17:50 /usr/bin/atq
-rwsr-xr-x  1 root  wheel  39216 Jul  4  2018 /usr/bin/crontab
-r-sr-xr-x  1 root  wheel  83680 Jan 24 17:50 /usr/bin/atrm
-r-sr-xr-x  1 root  wheel  52512 Jan 24 17:50 /usr/bin/newgrp
-rwsr-xr-x  1 root  wheel  25488 Jul  4  2018 /usr/bin/su
-r-sr-xr-x  1 root  wheel  83680 Jan 24 17:50 /usr/bin/batch
-r-sr-xr-x  1 root  wheel  83680 Jan 24 17:50 /usr/bin/at
-r-sr-xr-x  1 root  wheel  23568 Mar 28  2018 /usr/bin/quota
-r-s--x--x  1 root  wheel  438656 Jan 24 17:50 /usr/bin/sudo
-r-sr-xr-x  1 root  wheel  76288 Jan 24 17:50 /usr/bin/login
```

## Credits and References

* [man find](http://man7.org/linux/man-pages/man1/find.1.html)
* [man sort](http://man7.org/linux/man-pages/man1/sort.1.html)
* [Sorting strings with numbers in Bash](https://stackoverflow.com/questions/17061948/sorting-strings-with-numbers-in-bash)
* [Linux Server Hacks](https://learning.oreilly.com/library/view/linux-server-hacks/0596004613/) - O'Reilly
