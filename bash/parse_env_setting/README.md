# #059 Parsing Environment Settings

Techniques for parsing environment variables with bash built-in features only.


## Notes

In a script, we may want to parse an environment variable and do something with the resulting parts.

If the structure is known ahead of time,
[Parameter Substitution](http://www.tldp.org/LDP/abs/html/parameter-substitution.html)
may be all that is required.

If the structure is variable, then we can parse the variable into an
[Array](http://www.tldp.org/LDP/abs/html/arrays.html)
by setting the appropriate field separator (IFS).

## Test Script

The [parse_env_setting.sh](./parse_env_setting.sh) script demonstrates
parsing an invented syntax from an environment variable.

It uses both IFS and parameter substitution techniques.

```
$ ./parse_env_setting.sh

This script demonstrates parsing an environment variable
Uses an invented encoding:
 - major parts delimited by /
 - minor parts delimited by :

parse_with_ifs: part1:part2
Major parts count: 1
loop with major_part==part1:part2
  loop with minor_part==part1
  loop with minor_part==part2

parse_with_ifs: part1:part2/part3:part4/part5:part6
Major parts count: 3
loop with major_part==part1:part2
  loop with minor_part==part1
  loop with minor_part==part2
loop with major_part==part3:part4
  loop with minor_part==part3
  loop with minor_part==part4
loop with major_part==part5:part6
  loop with minor_part==part5
  loop with minor_part==part6

parse_with_ifs_and_parameter_substitution: part1:part2
Major parts count: 1
loop with major_part==part1:part2
  first_part==part1
  second_part==part2

parse_with_ifs_and_parameter_substitution: part1:part2/part3:part4/part5:part6
Major parts count: 3
loop with major_part==part1:part2
  first_part==part1
  second_part==part2
loop with major_part==part3:part4
  first_part==part3
  second_part==part4
loop with major_part==part5:part6
  first_part==part5
  second_part==part6
```

## Credits and References
* [Bash split string on delimiter, assign segments to array](https://stackoverflow.com/questions/15777996/bash-split-string-on-delimiter-assign-segments-to-array)
* [Arrays](http://www.tldp.org/LDP/abs/html/arrays.html) - Advanced Bash-Scripting Guide
* [Parameter Substitution](http://www.tldp.org/LDP/abs/html/parameter-substitution.html) - Advanced Bash-Scripting Guide
