# #145 printf partial strings

Learning how printf can be instructed to select a limited number of characters from a string.

## Notes

I learned of this from the [Embedded Artistry](https://embeddedartistry.com/blog/2017/07/05/printf-a-limited-number-of-characters-from-a-string/) blog.
It could be useful when dealing with string buffers that are not null terminated.

Basically: the width parameter of the format string applies also the string.

e.g. `%.5s` limits output to a maximum of 5 characters:

    const char * mystr = "... long string ...";
    printf("Just 5 characters: %.5s\n", mystr);


Or the `*` width specifier can be used to take the length as an argument:

    printf("Just 5 characters: %.*s\n", 5, mystr);

This also works with related functions such as `sprintf`.

## Demo

[demo.c](./demo.c?raw=true) exercises various string format combinations.
Use make to compile and run:

```
$ make
gcc -Wall -O0    demo.c   -o demo
./demo

===== test_explicit_printf_format
> printf("Prints just 5 characters (should print 'ABCDE'): %.5s\n", long_string);
Prints just 5 characters (should print 'ABCDE'): ABCDE

===== test_printf_width_as_argument
> printf("Prints just %d characters (should print 'AB'): %.*s\n", 2, 2, long_string);
Prints just 2 characters (should print 'AB'): AB

===== test_explicit_printf_format
> printf("Asking for 5 characters, but only 4 available (should print 'ABCD'): %.5s\n", short_string);
Asking for 5 characters, but only 4 available (should print 'ABCD'): ABCD

===== test_explicit_sprintf_format
> sprintf(result, "%.5s", long_string);

===== test_sprintf_with_width_as_argument
> sprintf(result, "%.*s", 2, long_string);
```

## Credits and References

* [printf a Limited Number of Characters from a String](https://embeddedartistry.com/blog/2017/07/05/printf-a-limited-number-of-characters-from-a-string/)
* [printf](http://www.cplusplus.com/reference/cstdio/printf/)
* [sprintf](http://www.cplusplus.com/reference/cstdio/sprintf/)
