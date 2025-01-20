# #169 std::string::find

A closer look at the find function for strings in C++.

## Notes

[std::string::find](http://www.cplusplus.com/reference/string/string/find/)
Searches the string for the first occurrence of the sequence specified by its arguments:

* string (1)    : `size_t find (const string& str, size_t pos = 0) const noexcept;`
* c-string (2)  : `size_t find (const char* s, size_t pos = 0) const;`
* buffer (3)    : `size_t find (const char* s, size_t pos, size_type n) const;`
* character (4) : `size_t find (char c, size_t pos = 0) const noexcept;`


### Running the Examples

See [example.cpp](./example.cpp) for details. A makefile compiles and runs the examples:

```
$ make
c++ -std=c++17 -g -Wall -O3    example.cpp   -o example
./example
'needle' #1 found at: 14
'needle' #2 found at: 44
```

## Credits and References

* [std::string::find](http://www.cplusplus.com/reference/string/string/find/)
