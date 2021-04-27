# Numeric Limits

Numeric limits information available in the C++ standard library.

## Notes

The C standard library relies on macros to define numeric limits.
The C++ library instead provides a class template for a standardized way to query properties of arithmetic types.
The standard library makes available specializations for all arithmetic types.

### Running the Example

See [example.cpp](./example.cpp) for details. A makefile compiles and runs:

```
$ make
c++ -std=c++17 -Wall -O3    example.cpp   -o example
./example
## Numeric Limits
type  lowest()  min()   max()
----  --------  -----   -----
bool  0   0   1
uchar 0   0   255
int -2147483648 -2147483648 2147483647
float -3.40282e+38  1.17549e-38 3.40282e+38
double  -1.79769e+308 2.22507e-308  1.79769e+308
```

## Credits and References

* [std::numeric_limits](https://en.cppreference.com/w/cpp/types/numeric_limits)
