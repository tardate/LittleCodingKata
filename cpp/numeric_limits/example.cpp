#include <limits>
#include <iostream>

void show_limits() {
  std::cout << "## Numeric Limits" << std::endl;

  std::cout << "type\tlowest()\tmin()\t\tmax()" << std::endl;
  std::cout << "----\t--------\t-----\t\t-----" << std::endl;
  std::cout << "bool\t"
            << std::numeric_limits<bool>::lowest() << "\t\t"
            << std::numeric_limits<bool>::min() << "\t\t"
            << std::numeric_limits<bool>::max() << std::endl;
  std::cout << "uchar\t"
            << +std::numeric_limits<unsigned char>::lowest() << "\t\t"
            << +std::numeric_limits<unsigned char>::min() << "\t\t"
            << +std::numeric_limits<unsigned char>::max() << std::endl;
  std::cout << "int\t"
            << std::numeric_limits<int>::lowest() << '\t'
            << std::numeric_limits<int>::min() << '\t'
            << std::numeric_limits<int>::max() << std::endl;
  std::cout << "float\t"
            << std::numeric_limits<float>::lowest() << '\t'
            << std::numeric_limits<float>::min() << '\t'
            << std::numeric_limits<float>::max() << std::endl;
  std::cout << "double\t"
            << std::numeric_limits<double>::lowest() << '\t'
            << std::numeric_limits<double>::min() << '\t'
            << std::numeric_limits<double>::max() << std::endl;
}

int main(void) {
  show_limits();
  return 0;
}
