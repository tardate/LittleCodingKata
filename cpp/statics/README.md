# #183 static

About the static keyword in C++ - static variables, static objects, static member variables, static member functions.

## Notes

### Static Variables inside Functions

Static variables when used inside function are initialized only once, and then they hold there value even through function calls.

```
void counter() {
  static int variable = 0;
  cout << "variable is now : " << ++variable << endl;
}
```

### Static Class Objects

Static keyword works in the same way for class objects too. Objects declared static are allocated storage in static storage area, and have scope till the end of program.

```
void static_object_id() {
  static StaticDemo static_object;
  cout << "static_object id is still : " << static_object.getId() << endl;
}
```

### Static Class Variables

Static class variables have a single storage and are shared by all object instances of the class.
The static class variable must be initialised/allocated at some point outside of the class definition.
If the sttic is also const, then it can be initialised inline in the class definition

```
class Test {
private:
  int id;
  static int counter;

public
  static int const MAX = 42;

public:
  Test() {
    id = counter++;
  }
  int getId() {
    return id;
  }
};

int Test::counter = 0;
```


#### Static Class Methods

These functions work for the class as whole rather than for a particular object of a class.
They can't access instance variables, but can access static members.

```
class Test {
private:
  static int counter;

public:
  Test() {}
  static int getCounter() {
    return counter;
  }
};

int Test::counter = 0;

Test::getCounter();
```

### Running the Example

See [example.cpp](./example.cpp) for details. A makefile compiles and runs:

```
$ make
c++ -std=c++17 -g -Wall -O3    example.cpp   -o example
./example;
incr_static_variable_in_function() => static_variable_in_function is now : 1
incr_static_variable_in_function() => static_variable_in_function is now : 2
incr_static_variable_in_function() => static_variable_in_function is now : 3
static_object_id() =>
  id initialised from static_class_variable: 100
  static_class_variable is now : 101
object_1 =>
  id initialised from static_class_variable: 101
  static_class_variable is now : 103
object_2 =>
  id initialised from static_class_variable: 102
  static_class_variable is now : 103
StaticDemo::staticClassMethod() =>
  StaticDemo::STATIC_CLASS_CONST    : 100
  StaticDemo::static_class_variable : 103
static_object_id() =>
  id initialised from static_class_variable: 100
  static_class_variable is now : 103
```

## Credits and References

* [static members](https://en.cppreference.com/w/cpp/language/static)
* [Static Keyword in C++](https://www.studytonight.com/cpp/static-keyword.php)
* [Static Members of a C++ Class](https://www.tutorialspoint.com/cplusplus/cpp_static_members.htm)
