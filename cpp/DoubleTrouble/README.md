# DoubleTrouble

Investigting some of the pitfalls of directly reading doubles from a stream,
then going down the rabbit hole of bugs and variations in the LLVM/Clang and GCC
implementations of the C++ standard library.

## Notes

The C++ [std::basic_istream::operator>>](https://en.cppreference.com/w/cpp/io/basic_istream/operator_gtgt)
is a great convenience for parsing a stream directly into variables of specific types.

For example, to read a double:

    double d;
    cin >> d;

If the input provided cannot be converted to a double, then `d` will be 0 and the stream will
be in a failed state that needs clearing before continuing to read.

But what happens with the stream content that failed to convert?
I was surprised to discover that the answer is: it depends!


### Where it all Started

There's a trivial bit of input stream reading used in some C++ courses that expects input like this:

    Smith 93 91 47 90 92 73 100 87
    Carpenter 75 90 87 92 93 60 0 98

.. but strangely drops characters from some of the names (i.e. `rpenter` is read instad of `Carpenter`).
A cut down example is in [first_example.cpp](./first_example.cpp):

    $ g++ -o first_example.exe first_example.cpp && cat first_example.in | ./first_example.exe
    Name: Smith 93 91 47 90 92 73 100 87
    Name: rpenter 75 90 87 92 93 60 0 98
    Name: Jones 1 2 3 4 5 6 7 8 9 10

That's the result I get when I run it on MacOSX (that bit of information became significant later).
I added Jones just to show its not a repeating pattern for all subsequent lines.


### Starting the Investigation: The Simplest Example

I couldn't let the unexpected result stand. My initial attemps at searching for an explanation failed,
though I did later discover
[I'm not the first](https://www.reddit.com/r/learnprogramming/comments/26hvy6/accelerated_c_chapter_4_bug_how_to_stop_reading/)
to stumble upon this.


So I first paired down the example to the basics.
[simplest_example.cpp](./simplest_example.cpp) tries to read a double followed by a string:

    #include <iostream>
    using namespace std;

    int main() {
        cout << "Enter a double and a string: ";
        double d = 42; // canary value so can tell if has been changed
        string s;
        cin >> d;
        if(!cin) cin.clear();
        cin >> s;
        cout << "Thanks. I read double: " << d << " and string: " << s << endl;
        return 0;
    }

When the data entered is compatible with the types expected, it works correctly of course:

    $ g++ -o simplest_example.exe simplest_example.cpp && ./simplest_example.exe
    Enter a double and a string: 99 bottles
    Thanks. I read double: 99 and string: bottles

If we provide a string where the double is expected, the type conversion fails. Because we clear the error before
trying to read the string, the data that failed to convert is then read as the string:

    $ ./simplest_example.exe
    Enter a double and a string: truck stop
    Thanks. I read double: 0 and string: truck

The makes sense. but what about this:

    $ ./simplest_example.exe
    Enter a double and a string: car port
    Thanks. I read double: 0 and string: r

The initial characters `ca` of `car` have disappeared into the ether!

It appears that all characters that **might** be part of a valid double (e.g. hex 0-9,a-f)
are consumed by the `operator>>` until it actually fails (when it hits the `r`).
the earlier example of `truck` never got so far, as `t` is never part of a valid double.

So surely this means we can enter doubles in hex? Yes, as long as they are correctly qualified:

    $ ./simplest_example.exe
    Enter a double and a string: 0x1a hexelent
    Thanks. I read double: 26 and string: hexelent


### Replicating the Issue: Can I Reproduce it Elsewhere?


I started to wonder if this might be a platform or C++ version issue: [Runtime error for CLang compiled program (Mac) reading double type with std::cin](https://stackoverflow.com/questions/24487481/runtime-error-for-clang-compiled-program-mac-reading-double-type-with-stdcin)

> std::basic_istream::operator>> calls std::num_get::get to extract the value from input. Until C++11, the behaviour of std::num_get::get was like that of scanf with the appropriate formatting string. C++11 onwards, std::num_get::get ends up calling strto* functions, which have a more flexible matching than the one based on scanf


I put the [simplest_example on coliru](http://coliru.stacked-crooked.com/a/1e67803bee03b4e0) and it produces what I would consider to be
the "correct" result - no characters get mysteriously gobbled up:

```
g++ --version && g++ -std=c++17 -Wall -Wextra -Werror -pedantic main.cpp && echo "car port" | ./a.out && echo "truck stop" | ./a.out && echo "99.1234 bottles" | ./a.out && echo "abcdefgh ijk" | ./a.out
g++ (GCC) 8.1.0
Copyright (C) 2018 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Enter a double and a string: Thanks. I read double: 0 and string: car
Enter a double and a string: Thanks. I read double: 0 and string: truck
Enter a double and a string: Thanks. I read double: 99.1234 and string: bottles
Enter a double and a string: Thanks. I read double: 0 and string: abcdefgh
```

But the same thing run on my laptop is gobble characters:


```
g++ --version && g++ -std=c++17 -Wall -Wextra -Werror -pedantic -o simplest_example.exe simplest_example.cpp && echo "car port" | ./simplest_example.exe && echo "truck stop" | ./simplest_example.exe && echo "99.1234 bottles" | ./simplest_example.exe && echo "abcdefgh ijk" | ./simplest_example.exe

Configured with: --prefix=/Applications/Xcode.app/Contents/Developer/usr --with-gxx-include-dir=/usr/include/c++/4.2.1
Apple LLVM version 10.0.0 (clang-1000.11.45.5)
Target: x86_64-apple-darwin17.7.0
Thread model: posix
InstalledDir: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
Enter a double and a string: Thanks. I read double: 0 and string: r
Enter a double and a string: Thanks. I read double: 0 and string: truck
Enter a double and a string: Thanks. I read double: 99.1234 and string: bottles
Enter a double and a string: Thanks. I read double: 0 and string: gh
```


### So Which Difference is Significant?

Running on coliru showed the same code producing a different result.
But a few things had changed:

* the operating system: Linux v MacOSX
* the compiler: GCC v LLVM
* the C++ standard library implementation: [Libstdc++ v Libc++

On MacOSX, [I learned](https://forums.hardwarezone.com.sg/software-clinic-3/c-c-standard-libraries-linux-gcc-clang-5743469.html)
that running `g++` uses Apple's release of LLVM and the clang compiler, and clang supports both:

* Libstdc++, the GNU standard C++ library that comes standard in Linux
* Libc++, the LLVM/Clang's standard C++ library

And unsurprisingly, it uses Libc++ by default. Libstdc++ actually now throws deprecation warnings.

So what happens if I just switch the standard library?
First explicitly verify that I see the issue with libc++:

    $ g++ -stdlib=libc++ -o simplest_example.libc.exe simplest_example.cpp
    $ ./simplest_example.libc.exe
    Enter a double and a string: car port
    Thanks. I read double: 0 and string: r

But now with libstdc++, problem is magically solved:

    $ g++ -stdlib=libstdc++ -o simplest_example.libstdc.exe simplest_example.cpp
    clang: warning: libstdc++ is deprecated; move to libc++ [-Wdeprecated]
    $ ./simplest_example.libstdc.exe
    Enter a double and a string: car port
    Thanks. I read double: 0 and string: car


So, one step closer to understanding this: it is a behaviour specific to Libc++, the LLVM/Clang's standard C++ library.


### A Bit of Research: What does the Spec Say?

So `Libc++` is behaving differently. But is this actually 'bad behaviour' according to the C++ spec?

Starting from the top, down the rabbit hole we go;-)

#### Level 1: `operator>>`

The C++ [`std::basic_istream::operator>>`](https://en.cppreference.com/w/cpp/io/basic_istream/operator_gtgt)
provides a specific overload for doubles `basic_istream& operator>>( double& value );`:

* behaves as a FormattedInputFunction. After constructing and checking the sentry object, which may skip leading whitespace, extracts a floating point value by calling `std::num_get::get()`.
* doesn't directly specify the parsing rules. Implies these are delegated to `std::num_get::get()`
* specifies that if extraction fails:
    * `value` is left unmodified and failbit is set (until C++11)
    * zero is written to `value` and failbit is set (since C++11)
    * but does not specify what should happen to the stream in this case


#### Level 2: `num_get`

So drilling down into [`std::num_get::get()`](https://en.cppreference.com/w/cpp/locale/num_get/get).
It defines an iterator for doubles:

    iter_type get( iter_type in, iter_type end, std::ios_base& str,
                   std::ios_base::iostate& err, double& v ) const;

And provides quite a bit more in terms of specified behaviour:

* Explicitly states that these functions is called by all formatted input stream operators such as `std::cin >> n;`.
* Reads characters from the input iterator `in` and generates the value of the type of `v`, taking into account
    * IO stream formatting flags from `str.flags()`
    * character classification rules from `std::use_facet<std::ctype<charT>>(str.getloc())`
    * and numeric punctuation characters from `std::use_facet<std::numpunct<charT>>(str.getloc())`.
* Defines a three stage conversion process:
    * conversion specifier selection
    * character extraction
    * conversion and storage
* Specifies that the input is parsed "as if" by `std::strtod` for doubles (since C++17)
* Again specifies that if extraction fails:
    * If the conversion function fails to convert the entire field, the value ​0​ is stored in v (since C++11)
    * but again does not directly specify what should happen to the stream in this case

There is one somewhat cryptic note:

> Because stage 2 filters out characters such as 'p', 'N' or 'i',
> the hexadecimal floating-point numbers such as "0x1.23p-10" and the strings "NaN" or "inf"
> may be rejected by do_get(double) even if they are valid input to strtod: this is LWG #2381


[LWG #2381](http://cplusplus.github.io/LWG/lwg-active.html#2381)
appears to be particularly focused on the conversion of
[floating point literals](https://en.cppreference.com/w/cpp/language/floating_literal):
and representations of infinity.

> These are all strings that are correctly parsed by std::strtod, but not by the stream extraction operators.
> They contain characters that are deemed invalid in stage 2 of parsing.
> If we're going to say that we're converting by the rules of strtold, then we should accept all the things that strtold accepts.

In fact, clang/Libc++ does a little better than GCC/Libstd++ in this respect.
It can parse correctly-formatted hex floating point literals, whereas Libstd++ baulks at the exponent and just converts the leading 0:

    $ echo "0xABp-4 rest" | ./simplest_example.libstdc.exe
    Enter a double and a string: Thanks. I read double: 0 and string: xABp-4
    $ echo "0xABp-4 rest" | ./simplest_example.libc.exe
    Enter a double and a string: Thanks. I read double: 10.6875 and string: rest


But if clang/Libc++ encounters additional characters after the valid hex floating point literal,
it's behaviour is as I've already seen: it depends!

If the character might be otherwise "valid" in a number (e.g. `p`), it bombs the conversion and gobbles all the input:

    $ echo "0x1a.bp+07p rest" | ./simplest_example.libc.exe
    Enter a double and a string: Thanks. I read double: 0 and string: rest

But if the character is not "valid" in a number (e.g. `r`), it completes the conversion and leaves the unused characters in the stream:

    $ echo "0x1a.bp+07rrrr rest" | ./simplest_example.libc.exe
    Enter a double and a string: Thanks. I read double: 3416 and string: rrrr
    $ echo "0x1a.bp+07 rest" | ./simplest_example.libc.exe
    Enter a double and a string: Thanks. I read double: 3416 and string: rest


#### Level 3: `strtod`

Although the stream spec says that the input is parsed "as if" by `std::strtod` for doubles (since C++17) - i.e. doesn't say that it has to be -
what is the behaviour of [`std::strtod`](https://en.cppreference.com/w/cpp/string/byte/strtof)?

    double      strtod( const char* str, char** str_end );

Firstly, the specification is much clearer about what happens in the event of failure:

> If no conversion can be performed, ​0​ is returned and *str_end is set to str.

This clearly means that characters are not consumed from the stream if there was an error in conversion.

[test_strtod.cpp](./test_strtod.cpp) is a quick test that tries to parse `car` as a double.
As seen earlier, clang/Libc++ will gobble the `ca` if parsed as double from a stream.
But `strtod` is fine with both versions of the library. The string is not converted, and the end pointer not incremented:

    $ g++ -stdlib=libstdc++ -o test_strtod.libstdc.exe test_strtod.cpp
    clang: warning: libstdc++ is deprecated; move to libc++ [-Wdeprecated]
    $ ./test_strtod.libstdc.exe
    Parsing 'car':
    '' -> 0
    errno: 0
    p: car
    end: car

    $ g++ -stdlib=libc++ -o test_strtod.libc.exe test_strtod.cpp
    $ ./test_strtod.libc.exe
    Parsing 'car':
    '' -> 0
    errno: 0
    p: car
    end: car


#### Back to `num_get`

So, stepping back one level, how does `num_get` behave when trying to parse `car` as a double?

[test_num_get.cpp](./test_num_get.cpp) is a quick test:

    $ g++ -std=c++17 -stdlib=libstdc++ -o test_num_get.libstdc.exe test_num_get.cpp && ./test_num_get.libstdc.exe
    clang: warning: libstdc++ is deprecated; move to libc++ [-Wdeprecated]
    parsing car as double gives 42
    err: 4
    gcount: 0
    tellg: 0
    remainder: car

    $ g++ -std=c++17 -stdlib=libc++ -o test_num_get.libc.exe test_num_get.cpp && ./test_num_get.libc.exe
    parsing car as double gives 0
    err: 4
    gcount: 0
    tellg: 2
    remainder: r

This appears to isolate the trouble in the `std::num_get::get` implementation, and there appear to be (different) issues
with each.

With GCC/libstdc++:

* the conversion fails and leaves all the unconverted characters in the stream (GOOD)
* but it does not set the return values as expected since C++11 (BAD)

With Clang/libc++:

* the conversion fails but gobbles all the number-like characters from the stream (`ca`) (BAD)
* and set the return value to 0 as expected since C++11 (GOOD)


### Searching for Bug Reports

So with that research in hand, I had enough keywords to try to find anything relevant in the [LLVM/Clang bug reports](https://bugs.llvm.org),
and I found
[Bug 17782 - num_get::do_get(in, end, double) broken if double is followed by character](https://bugs.llvm.org/show_bug.cgi?id=17782)

* it is confirmed but unresolved
* reported 2013-11-02 03:35 PDT by still unresolved as of 2019-01-05

This bug report has been focusing primarily on the failure to convert valid numbers when followed by unexpected but number-like characters,
and actually produced [LWG #2381](http://cplusplus.github.io/LWG/lwg-active.html#2381) mentioned earlier.

A number of other bugs have been closed as duplicates including:

* [Bug 36099 - Input stream formatted input for `float` produces incorrect result for non-hexadecimal-prefixed input containing hexadecimal characters without an exponent](https://bugs.llvm.org/show_bug.cgi?id=36099)
* [Bug 28704 - num_get::do_get incorrect digit grouping check](https://bugs.llvm.org/show_bug.cgi?id=28704)
* [Bug 19354 - failed stream extraction consumes characters after clear (libstdc++ vs libc++)](https://bugs.llvm.org/show_bug.cgi?id=19354) - which turns out to be exactly the issue I was focusing on!


There doesn't appear to be any clarity on that bug yet and no sign of a fix (or even if a fix is warranted).

The current consensus appears to be that libc++ is probably functioning according to the specification,
by focusing on clarifying the statement with respect to stage 2 processing (*A* instead of *THE*):

> The function stops reading characters from the sequence as soon as one character cannot be part of *A* valid numerical expression

However, by my reading and the latest comments from Charles Reilly 2018-08-05 10:42:30 PDT,
the discussion might be missing the bigger picture, and getting caught up in the ambiguity caused by the incomplete specification of the 3-step processing algorithm.


Looking once again at the specification for 25.4.2.1.2 num_get virtual functions (The final draft of C++17 n4659):

> If it is not discarded, then a check is made to determine if c is allowed as the next character of an input field
> of the conversion specifier returned by Stage 1. If so, it is accumulated.

After all this investigation, I think I can read that a bit more clearly, and it really does hinge on
the interpretation of "if c is allowed as the next character"

If one reads that as meaning "for the number I am trying to read, is this valid?"

* then when parsing "-4.9A", the "A" is a valid (hex) character, but does not make a valid number when preceeded by "-4.9"
* so not considered valid and conversion should stop there
* so expect -4.9 to be returned, and the stream pointer positioned at the "A" character
* this is how libstdc++ behaves
* but libc++ fails: returns 0 and stream pointer moved to after the "A" (gobbling up "-4.9A" without conversion)

If one reads that as meaning "for the type (conversion specifier) I am trying to read, is this valid?"

* then when parsing "-4.9A", the "A" is a valid (hex) character, and thus valid to accummulate
* so "-4.9A" is the result of stage 2, which is not a valid number
* this is how libc++ behaves
* but begs the question: if you fail to convert:
    * should the charaters still be consumed (as done by libc++)
    * or should they be left on the stream (as one would expect if conversion is done "as if" by `strtod`)



So this all seems to boil down to two issues that are perhaps helpful to keep seperate and distinct:

* when valid numeric characters are encountered that no longer result in a valid number representation (such as the "A" in "-4.9A", or the "CA" in "CAR"):
    * should the conversion be smart enough to convert as much as is possible ("-4.9" in the "-4.9A" case, or nothing in the case of "CAR")
    * or should it reject the whole conversion as invalid (i.e. "-4.9A" is not convertable)
* when a conversion fails (whether at stage 2 or 3), what should happen to the unconvertable characters?
    * should they be left on the stream i.e. "CAR" fails, so "CAR" is still at the stream head
    * or accummulated and discarded i.e. "CAR" fails, with stream head now at "R" because the numeric (hex) characters C and A were discarded during the failed processing


It seems to me that GCC/libstdc++ has it right on both these points:

* conversion stops accummulating characters at the first character that cannot be used in a valid conversion (even if it is a number-like character)
* no characters are discarded from the stream unless they are consumed in a valid conversion

Unfortunately, that is purely a "common sense" interpretation.
The real underlying issue is that the C++ standard does not spell this out (clearly at least).

And as noted earlier, GCC/libstdc++ has it's own issues:

* can't seem to handle floating point literals correctly
* does not set the return value to 0 when conversion fails (per C++17)



## Examining the Libc++ Implementation

If I'm following the source correctly, the guts of the implementation
is in [`include/locale`](https://github.com/llvm-mirror/libcxx/blob/master/include/locale),
specifically [`__do_get_floating_point` at around line 1003](https://github.com/llvm-mirror/libcxx/blob/master/include/locale#L1003):

    template <class _CharT, class _InputIterator>
    template <class _Fp>
    _InputIterator
    num_get<_CharT, _InputIterator>::__do_get_floating_point(iter_type __b, iter_type __e,
                                            ios_base& __iob,
                                            ios_base::iostate& __err,
                                            _Fp& __v) const
    {
        ...
    }

This uses num_get template for stage 2 float extraction
with [`__stage2_float_loop` at around line 506](https://github.com/llvm-mirror/libcxx/blob/master/include/locale#L506)

    template <class _CharT>
    int
    __num_get<_CharT>::__stage2_float_loop(_CharT __ct, bool& __in_units, char& __exp, char* __a, char*& __a_end,
                        _CharT __decimal_point, _CharT __thousands_sep, const string& __grouping,
                        unsigned* __g, unsigned*& __g_end, unsigned& __dc, _CharT* __atoms)
    {
        ...
    }


And stage 3 conversion with [`__num_get_float` at around line 506](https://github.com/llvm-mirror/libcxx/blob/master/include/locale#L824)

    template <class _Tp>
    _LIBCPP_HIDDEN
    _Tp
    __num_get_float(const char* __a, const char* __a_end, ios_base::iostate& __err)
    {
        ...
    }

It seems related tests are in
[double.pass.cpp](https://github.com/llvm-mirror/libcxx/blob/master/test/std/input.output/iostream.format/input.streams/istream.formatted/istream.formatted.arithmetic/double.pass.cpp)
but there are no test cases for any of the scenarios covered here.


I won't pretend to have read and understood the source fully, but a couple of this strike me:

* the clear separation of stage 2 and 3 processing means that extraction of characters (stage 2) is oblivious to their convertability (stage 3)
* and there's no feedback from stage 3 that any/all of the extracted characters were convertable


Specifically in stage 3 [`__num_get_float`](https://github.com/llvm-mirror/libcxx/blob/master/include/locale#L838),
aborts and returns 0 if the conversion to double did not consume all the characters extracted in stage 2.

The extracted-character stream pointers `__a` and `__a_end` are `const`, and `__p2` is not returned,
so `__do_get_floating_point` is left not knowing how much of the string might have been convertable.

        if (__p2 != __a_end)
        {
            __err = ios_base::failbit;
            return 0;
        }

On return to `__do_get_floating_point`, it does not attempt to re-position the stream pointer
if `__num_get_float` failed, meaning all charcters extracted by stage 2 are consumed whether
`__num_get_float` succeeds or fails.


If I'm reading that correctly(?), it might be possible to "fix" this with minor surgery:

* if `__num_get_float` fails, `__do_get_floating_point` should rollback the stream pointer to reject all the characters extracted in stage 2
* if `__num_get_float` can perform a partial conversion (i.e. not all of the characters extracted in stage 2):
    * treat this as success, return the extracted value
    * and pass back the position in the stream that was converted (`__p2`) - so `__do_get_floating_point` can adjust the stream position accordingly.

NOTE: these are just some off-the-cuff comments - I am far from an expert here.



## Putting it All Together

The [DoubleTrouble.cpp](./DoubleTrouble.cpp) program demonstrates all the various scenarios discussed so far.

Using the LLVM/clang libc++:

    $ g++ -std=c++17 -stdlib=libc++ -o DoubleTrouble.libc.exe DoubleTrouble.cpp && ./DoubleTrouble.libc.exe
    # Valid floats followed by miscellaneous input
    Reading '-4.9 A':
      - result=-4.9 [OK, matches expected] (gcount: 0, tellg: 4)
      - remainder on stream='A' [OK, matches expected]
    Reading '-4.9A':
      - result=0 [BAD, does not match expected: -4.9] (gcount: 0, tellg: -1)
      - remainder on stream='' [BAD, does not match expected: 'A']
    Reading '-4.9 Z':
      - result=-4.9 [OK, matches expected] (gcount: 0, tellg: 4)
      - remainder on stream='Z' [OK, matches expected]
    Reading '-4.9Z':
      - result=-4.9 [OK, matches expected] (gcount: 0, tellg: 4)
      - remainder on stream='Z' [OK, matches expected]
    # Floating point literals, some followed by miscellaneous input
    Reading '0x1a.bp+07':
      - result=3416 [OK, matches expected] (gcount: 0, tellg: -1)
      - remainder on stream='' [OK, matches expected]
    Reading '0x1a.bp+07aaaa':
      - result=0 [BAD, does not match expected: 3416] (gcount: 0, tellg: -1)
      - remainder on stream='' [BAD, does not match expected: 'aaaa']
    Reading '0x1a.bp+07zzzz':
      - result=3416 [OK, matches expected] (gcount: 0, tellg: 10)
      - remainder on stream='zzzz' [OK, matches expected]
    # Things that might look like numbers at first, but aren't
    Reading 'car':
      - result=0 [OK, matches expected] (gcount: 0, tellg: -1)
      - remainder on stream='r' [BAD, does not match expected: 'car']
    Reading 'truck':
      - result=0 [OK, matches expected] (gcount: 0, tellg: -1)
      - remainder on stream='truck' [OK, matches expected

Using the GCC libstdc++:

    g++ -std=c++17 -stdlib=libstdc++ -o DoubleTrouble.libstdc.exe DoubleTrouble.cpp && ./DoubleTrouble.libstdc.exe
    clang: warning: libstdc++ is deprecated; move to libc++ [-Wdeprecated]
    # Valid floats followed by miscellaneous input
    Reading '-4.9 A':
      - result=-4.9 [OK, matches expected] (gcount: 0, tellg: 4)
      - remainder on stream='A' [OK, matches expected]
    Reading '-4.9A':
      - result=-4.9 [OK, matches expected] (gcount: 0, tellg: 4)
      - remainder on stream='A' [OK, matches expected]
    Reading '-4.9 Z':
      - result=-4.9 [OK, matches expected] (gcount: 0, tellg: 4)
      - remainder on stream='Z' [OK, matches expected]
    Reading '-4.9Z':
      - result=-4.9 [OK, matches expected] (gcount: 0, tellg: 4)
      - remainder on stream='Z' [OK, matches expected]
    # Floating point literals, some followed by miscellaneous input
    Reading '0x1a.bp+07':
      - result=0 [BAD, does not match expected: 3416] (gcount: 0, tellg: 1)
      - remainder on stream='x1a.bp+07' [BAD, does not match expected: '']
    Reading '0x1a.bp+07aaaa':
      - result=0 [BAD, does not match expected: 3416] (gcount: 0, tellg: 1)
      - remainder on stream='x1a.bp+07aaaa' [BAD, does not match expected: 'aaaa']
    Reading '0x1a.bp+07zzzz':
      - result=0 [BAD, does not match expected: 3416] (gcount: 0, tellg: 1)
      - remainder on stream='x1a.bp+07zzzz' [BAD, does not match expected: 'zzzz']
    # Things that might look like numbers at first, but aren't
    Reading 'car':
      - result=42 [BAD, does not match expected: 0] (gcount: 0, tellg: -1)
      - remainder on stream='car' [OK, matches expected]
    Reading 'truck':
      - result=42 [BAD, does not match expected: 0] (gcount: 0, tellg: -1)
      - remainder on stream='truck' [OK, matches expected]


## Conculsion?

This lead me down the C++ standards rabbit hole - a useful and interesting exercise in it's own right.

I must say I'm a little shocked to find that for something as apparently trivial as reading doubles from a string stream:

* the C++ standard is so ambiguous as to correct behaviour
* and (so perhaps not surprisingly) leading implementations of the standard library vary quite widely in their behaviour

Along the way I found a good document called
[Tips and tricks for using C++ I/O (input/output)](http://www.augustcouncil.com/~tgibson/tutorial/iotips.html#directly)
that suggests:

> Reading in numbers directly is problematic
> ..
> Using getline to input numbers is a more robust alternate to reading numbers directly

I now know that is unfortunately quite true!
It seems improvement really requires a tightening up of the specification as a pre-requisite.


## Credits and References
* [std::basic_istream::operator>>](https://en.cppreference.com/w/cpp/io/basic_istream/operator_gtgt) - cppreference
* [std::istream::operator>>](http://www.cplusplus.com/reference/istream/istream/operator%3E%3E/) - cplusplus
* [std::cin, extraction, and dealing with invalid text input](https://www.learncpp.com/cpp-tutorial/5-10-stdcin-extraction-and-dealing-with-invalid-text-input/)
* [Tips and tricks for using C++ I/O (input/output)](http://www.augustcouncil.com/~tgibson/tutorial/iotips.html#directly)
