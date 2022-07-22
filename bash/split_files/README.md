# Split Files

Split a text file into parts with simple shell utilities.

## Notes

### Split By Row Count

Given a text file with many rows, split it into multiple smaller files `n` lines in length

Simple solution is to use the split utility e.g.

    cd example1
    split -l 100 ../countries.csv part-

This produces three files with a maximum of 100 lines in each file:

    $ wc -l *
         100 part-aa
         100 part-ab
          49 part-ac
         249 total

However this was a CSV file, so it contains a header that might be good to strip first.
The `split` accepts piped data, so can first trim the file with `tail`:

    cd example2
    tail -n +2 ../countries.csv | split -l 100 - part-
    wc -l *
         100 part-aa
         100 part-ab
          48 part-ac
         248 total

## Credits and References

* [man split(1)](https://man7.org/linux/man-pages/man1/split.1.html)
* [man tail(1)](https://man7.org/linux/man-pages/man1/tail.1.html)
* [How to Split Large Text File into Multiple *.txt Files](https://www.linuxshelltips.com/split-large-file-into-multiple-files/)
* [Split text file into smaller multiple text file using command line](https://stackoverflow.com/questions/25249516/split-text-file-into-smaller-multiple-text-file-using-command-line) - stackoverflow
* [How can I remove the first line of a text file using bash/sed script?](https://stackoverflow.com/questions/339483/how-can-i-remove-the-first-line-of-a-text-file-using-bash-sed-script)
