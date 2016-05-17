# Fix the First Line of a File

## Notes

I have a text file, but the first line might need modification. What to do?

Reach for `perl` of course!

This requires a variation of the generic [patch_file process described here](../patch_file).

The [examples.sh](./examples.sh) script demonstrates the principle.
The example is actually taking a file in Intel Hex format and pre-pending an Extended Linear Address record
if one is not already present.

### Example

```
$ ./examples.sh
Installing example.hex from template..

Original example.hex (head only)..
:10000000008000208D030000CD030000CF0300001E
:1000100000000000000000000000000000000000E0
:10002000000000000000000000000000D1030000FC
:100030000000000000000000D3030000D503000012
:10004000D7030000D7030000D7030000D703000048
:10005000D703000000000000D7030000D703000012
:10006000D7030000D7030000D7030000D703000028
:10007000D7030000D7030000D7030000D703000018
:10008000D7030000D7030000D7030000D703000008
:10009000D7030000D7030000D7030000D7030000F8

Step 1: Patching the first line (with file backup)

Cummulative diffs..
1d0
< :020000040000FA

Step 2: Try patching again - should not duplicate (without backup)

Cummulative diffs..
1d0
< :020000040000FA

Resulting example.hex (head only)..
:020000040000FA
:10000000008000208D030000CD030000CF0300001E
:1000100000000000000000000000000000000000E0
:10002000000000000000000000000000D1030000FC
:100030000000000000000000D3030000D503000012
:10004000D7030000D7030000D7030000D703000048
:10005000D703000000000000D7030000D703000012
:10006000D7030000D7030000D7030000D703000028
:10007000D7030000D7030000D7030000D703000018
:10008000D7030000D7030000D7030000D703000008
```

## Credits and References
* [How can I make changes to only the first line of a file?](http://stackoverflow.com/questions/548420/how-can-i-make-changes-to-only-the-first-line-of-a-file) - SO
* [The Perl Programming Language](https://www.perl.org/)
* [OSHChip/GccToolchain](https://github.com/tardate/LittleArduinoProjects/tree/master/OSHChip/GccToolchain) - where I used this recently
* [Intel HEX](https://en.wikipedia.org/wiki/Intel_HEX) - wikipedia
