# #171 World in C++

The clichéd starting point, in C++.

## Notes

Demonstrating the C++ standard input/output library to write some text on the screen.

```
#include <iostream>

using namespace std;

int main() {
  cout << "Hello!" << endl;
  return 0;
}
```

Build and run the example [hello.cpp](./hello.cpp):

```
$ make
c++ -std=c++17 -g -Wall -O3    hello.cpp   -o hello
./hello
Hello!
```

## Credits and References

* [std::cout](https://en.cppreference.com/w/cpp/io/cout)
* [std::endl](https://en.cppreference.com/w/cpp/io/manip/endl)
