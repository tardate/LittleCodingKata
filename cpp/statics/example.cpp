#include <iostream>

using namespace std;


void incr_static_variable_in_function() {
  static int static_variable_in_function = 0;
  cout << "incr_static_variable_in_function() => static_variable_in_function is now : " << ++static_variable_in_function << endl;
}


class StaticDemo {
public:
  static int const STATIC_CLASS_CONST = 100;

private:
  int id;
  static int static_class_variable;

public:
  StaticDemo() {
    id = static_class_variable++;
  }

  int getId() {
    return id;
  }

  void showId() {
    cout << "  id initialised from static_class_variable: " << id << endl;
    cout << "  static_class_variable is now : " << static_class_variable << endl;
  }

  static void staticClassMethod() {
    cout << "StaticDemo::staticClassMethod() => " << endl;
    cout << "  StaticDemo::STATIC_CLASS_CONST    : " << STATIC_CLASS_CONST << endl;
    cout << "  StaticDemo::static_class_variable : " << static_class_variable << endl;
  }
};


int StaticDemo::static_class_variable = StaticDemo::STATIC_CLASS_CONST;


void static_object_id() {
  static StaticDemo static_object;
  cout << "static_object_id() => " << endl;
  static_object.showId();
}


int main() {

  for(int i = 0; i < 3; ++i) incr_static_variable_in_function();

  static_object_id();

  StaticDemo object_1;
  StaticDemo object_2;

  cout << "object_1 => " << endl; object_1.showId();
  cout << "object_2 => " << endl; object_2.showId();

  StaticDemo::staticClassMethod();

  static_object_id();

  return 0;
}
