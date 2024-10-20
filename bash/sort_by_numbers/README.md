# #037 by Numbers

Sorting text numerically in the shell using the special "version sort" mode of the sort utility.

## Notes

Version strings and other text with embedded integers don't sort nicely by default, so natural alphabetical sorting will mess us up.

Generating some version numbers to be sorted:

```
$ printf "v1.%d.0\n" $(seq 20 -1 0) > version_strings.txt
$ cat version_strings.txt
v1.20.0
v1.19.0
v1.18.0
v1.17.0
v1.16.0
v1.15.0
v1.14.0
v1.13.0
v1.12.0
v1.11.0
v1.10.0
v1.9.0
v1.8.0
v1.7.0
v1.6.0
v1.5.0
v1.4.0
v1.3.0
v1.2.0
v1.1.0
v1.0.0
```

Piping this through [sort](https://man7.org/linux/man-pages/man1/sort.1.html) mixes this up as would be expected:

```
$ cat version_strings.txt | sort
v1.0.0
v1.1.0
v1.10.0
v1.11.0
v1.12.0
v1.13.0
v1.14.0
v1.15.0
v1.16.0
v1.17.0
v1.18.0
v1.19.0
v1.2.0
v1.20.0
v1.3.0
v1.4.0
v1.5.0
v1.6.0
v1.7.0
v1.8.0
v1.9.0
```

Howerver [sort](https://man7.org/linux/man-pages/man1/sort.1.html) has a special "version sort" mode `--version-sort` or `-V` that
magically handles this correctly:

```
$ cat version_strings.txt | sort -V
v1.0.0
v1.1.0
v1.2.0
v1.3.0
v1.4.0
v1.5.0
v1.6.0
v1.7.0
v1.8.0
v1.9.0
v1.10.0
v1.11.0
v1.12.0
v1.13.0
v1.14.0
v1.15.0
v1.16.0
v1.17.0
v1.18.0
v1.19.0
v1.20.0
```

Although intend for sorting version srtings, it handles many simple integer sort tasks:

```
$ printf "dog-%d.txt\n" $(seq 20 -1 0) > numbered_strings.txt
$ printf "cat-%d.txt\n" $(seq 20 -1 0) >> numbered_strings.txt
$ cat numbered_strings.txt
dog-20.txt
dog-19.txt
dog-18.txt
dog-17.txt
dog-16.txt
dog-15.txt
dog-14.txt
dog-13.txt
dog-12.txt
dog-11.txt
dog-10.txt
dog-9.txt
dog-8.txt
dog-7.txt
dog-6.txt
dog-5.txt
dog-4.txt
dog-3.txt
dog-2.txt
dog-1.txt
dog-0.txt
cat-20.txt
cat-19.txt
cat-18.txt
cat-17.txt
cat-16.txt
cat-15.txt
cat-14.txt
cat-13.txt
cat-12.txt
cat-11.txt
cat-10.txt
cat-9.txt
cat-8.txt
cat-7.txt
cat-6.txt
cat-5.txt
cat-4.txt
cat-3.txt
cat-2.txt
cat-1.txt
cat-0.txt
```

Sorting by version produces the expected result:
```
$ cat numbered_strings.txt | sort -V
cat-0.txt
cat-1.txt
cat-2.txt
cat-3.txt
cat-4.txt
cat-5.txt
cat-6.txt
cat-7.txt
cat-8.txt
cat-9.txt
cat-10.txt
cat-11.txt
cat-12.txt
cat-13.txt
cat-14.txt
cat-15.txt
cat-16.txt
cat-17.txt
cat-18.txt
cat-19.txt
cat-20.txt
dog-0.txt
dog-1.txt
dog-2.txt
dog-3.txt
dog-4.txt
dog-5.txt
dog-6.txt
dog-7.txt
dog-8.txt
dog-9.txt
dog-10.txt
dog-11.txt
dog-12.txt
dog-13.txt
dog-14.txt
dog-15.txt
dog-16.txt
dog-17.txt
dog-18.txt
dog-19.txt
dog-20.txt
```

## Credits and References

* [sort](https://man7.org/linux/man-pages/man1/sort.1.html) man page
* [bash: sorting strings with numbers](https://stackoverflow.com/questions/17061948/bash-sorting-strings-with-numbers?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa)
