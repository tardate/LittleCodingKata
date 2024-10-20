# #011 Process a File/Stream Line-by-Line


## Notes

The bash `for..in` construct is useful for simple repetitive processing tasks.

When iterating character strings, the behaviour is governed by the internal field separator ($IFS),
which determines how Bash recognizes fields, or word boundaries.

$IFS defaults to whitespace (space, tab, and newline).

So when trying to process lines in a file (for example), it will iterate over each word.
This may be what you want. But if not, modifying the $IFS allows the behaviour to match what is required.

This is fine for simple text processing. For more complex manipulations,
its probably best **not** to attempt to bend Bash to your will, but instead reach
for a more suitable tool (sed, awk, perl, python, ruby etc..).

## Line-by-Line Processing Example

See [nevermores.sh](./nevermores.sh).

* it first demonstrates default `for..in` behaviour
* then modifies the IFS to scan [The Raven](./the_raven.txt) line by line and do some processing


```
$ ./nevermores.sh

Using for..in with default IFS, we get words not lines:
> The
> Raven
> -
> Edgar
> Allan
> Poe

Reset the IFS for newline, then for..in gives us lines:
> Quoth the Raven, "Nevermore."
> With such name as "Nevermore."
> Then the bird said, "Nevermore."
> Of 'Never- nevermore'."
> Meant in croaking "Nevermore."
> She shall press, ah, nevermore!
> Quoth the Raven, "Nevermore."
> Quoth the Raven, "Nevermore."
> Quoth the Raven, "Nevermore."
> Quoth the Raven, "Nevermore."
> Shall be lifted- nevermore!

```

## Credits and References
* [9.1. Internal Variables](http://www.tldp.org/LDP/abs/html/internalvariables.html) - Advanced Bash-Scripting Guide
* [11. Loops and Branches](http://tldp.org/LDP/abs/html/loops1.html) - Advanced Bash-Scripting Guide
* [7. Loops for, while and until](http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-7.html)
* [Octal Escape Sequences](http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/c583.html)
* [The extended ASCII table](http://www.ascii-code.com/)
* [The Raven](http://www.poetryloverspage.com/poets/poe/raven.html)
