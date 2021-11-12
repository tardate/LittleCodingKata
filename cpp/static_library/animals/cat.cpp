#include "cat.h"
#include <iostream>

namespace lcklib {

  void hello() {
    std::cout << "Hello there!!!" << std::endl;
  }

  Cat::Cat() {}

  Cat::~Cat() {}

  void Cat::speak() {
    std::cout << "Meeeouwww!!!" << std::endl;
  }

}
