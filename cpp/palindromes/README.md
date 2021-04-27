# Palindromes

Examples of how to code a palidrome check in C++.

## Notes

## Naïve Reversal

The most basic way of checking: reverse the string and then compare to the original.
The [std::swap](https://en.cppreference.com/w/cpp/algorithm/swap) function
can be used to swap (reverse) all the characters in a string:

```
string reverse(string s) {
   int n = s.size();
   for (int i = 0; i < n / 2; ++i) swap(s[i], s[n - i - 1]);
   return s;
}
```

## Range Comparison

The [std::equal](https://en.cppreference.com/w/cpp/algorithm/equal)
function can be used to write a one-line palindrome check by comparing two iterators over the input string:

* one iterator starts at the [begin](https://en.cppreference.com/w/cpp/string/basic_string/begin) of the string
* the other iterator starts at the [rbegin](https://en.cppreference.com/w/cpp/string/basic_string/rbegin) (reverse-beginning) of the string
* the comparison stops when the first iterator reaches the [end](https://en.cppreference.com/w/cpp/string/basic_string/end) of the string.

So the following call will iterate through all characters and return true if palindromic:

```
equal(given.begin(), given.end(), given.rbegin())
```

This approach has the advantage of not creating any copies of the given string.
It does suffer from checking all characters in the string, when it only needs to check to the halfway point.

### Running the Example

See [example.cpp](./example.cpp) for details. A makefile compiles and runs:

```
$ make
c++ -std=c++17 -g -Wall -O3    example.cpp   -o example
./example
If you type in a word, I'll tell you if it is a palindrome.
abc33cba
Checking by explicitly reversing the string: Yes, abc33cba is a palindrome.
Checking with a range comparison: Yes, abc33cba is a palindrome.
```

```
$ make
./example
If you type in a word, I'll tell you if it is a palindrome.
abc
Checking by explicitly reversing the string: No, abc is not a palindrome.
Checking with a range comparison: No, abc is not a palindrome.
```

## Credits and References

* [std::swap](https://en.cppreference.com/w/cpp/algorithm/swap)
* [std::equal](https://en.cppreference.com/w/cpp/algorithm/equal)
* [std::begin](https://en.cppreference.com/w/cpp/iterator/begin) - Returns an iterator to the beginning of the given range.
  * [std::basic_string<CharT,Traits,Allocator>::begin](https://en.cppreference.com/w/cpp/string/basic_string/begin)
* [std::rbegin](https://en.cppreference.com/w/cpp/iterator/rbegin) - Returns an iterator to the reverse-beginning of the given range
  * [std::basic_string<CharT,Traits,Allocator>::rbegin](https://en.cppreference.com/w/cpp/string/basic_string/rbegin)
* [std::end](https://en.cppreference.com/w/cpp/iterator/end)
  * [std::basic_string<CharT,Traits,Allocator>::end](https://en.cppreference.com/w/cpp/string/basic_string/end)
