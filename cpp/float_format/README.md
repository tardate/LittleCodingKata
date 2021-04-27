# Float Format

Testing floating point number formatting with the C++

## Notes

The C++ standard library provides support for modifying the default formatting of floating point numbers.

Formats supported: fixed, scientific, hexfloat for default.


### Running the Example

See [example.cpp](./example.cpp) for details. A makefile compiles and runs:

```
$ make
c++ -std=c++17 -g -Wall -O3    example.cpp   -o example
./example;
┌──────────┬────────────┬──────────────────────────┐
│  number  │   iomanip  │      representation      │
├──────────┼────────────┼──────────────────────────┤
│ 0.0      │ fixed      │ 0.000000                 │
│ 0.0      │ scientific │ 0.000000e+00             │
│ 0.0      │ hexfloat   │ 0x0p+0                   │
│ 0.0      │ default    │ 0                        │
├──────────┼────────────┼──────────────────────────┤
│ 0.01     │ fixed      │ 0.010000                 │
│ 0.01     │ scientific │ 1.000000e-02             │
│ 0.01     │ hexfloat   │ 0x1.47ae147ae147bp-7     │
│ 0.01     │ default    │ 0.01                     │
├──────────┼────────────┼──────────────────────────┤
│ 0.00001  │ fixed      │ 0.000010                 │
│ 0.00001  │ scientific │ 1.000000e-05             │
│ 0.00001  │ hexfloat   │ 0x1.4f8b588e368f1p-17    │
│ 0.00001  │ default    │ 1e-05                    │
├──────────┼────────────┼──────────────────────────┤
│ 11/3     │ fixed      │ 3.666667                 │
│ 11/3     │ scientific │ 3.666667e+00             │
│ 11/3     │ hexfloat   │ 0x1.d555555555555p+1     │
│ 11/3     │ default    │ 3.66667                  │
└──────────┴────────────┴──────────────────────────┘
```

## Credits and References

* [std::fixed, std::scientific, std::hexfloat, std::defaultfloat](https://en.cppreference.com/w/cpp/io/manip/fixed)
