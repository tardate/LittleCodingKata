#include <iostream>
#include <iomanip>

enum class cap { title, middle, end };

void print(const char* text, double num, cap c) {
  if (c == cap::title) {
    std::cout <<
    "┌──────────┬────────────┬──────────────────────────┐\n"
    "│  number  │   iomanip  │      representation      │\n"
    "├──────────┼────────────┼──────────────────────────┤\n";
  }

  std::cout << std::left
  << "│ " << std::setw(8) << text << " │ fixed      │ "
  << std::setw(24) << std::fixed        << num << " │\n"
  << "│ " << std::setw(8) << text << " │ scientific │ "
  << std::setw(24) << std::scientific   << num << " │\n"
  << "│ " << std::setw(8) << text << " │ hexfloat   │ "
  << std::setw(24) << std::hexfloat     << num << " │\n"
  << "│ " << std::setw(8) << text << " │ default    │ "
  << std::setw(24) << std::defaultfloat << num << " │\n";

  if (c != cap::end) {
    std::cout <<
    "├──────────┼────────────┼──────────────────────────┤\n";
  } else {
    std::cout <<
    "└──────────┴────────────┴──────────────────────────┘\n";
  }
}

int main() {
  print("0.0", 0.0, cap::title);
  print("0.01", 0.01, cap::middle);
  print("0.00001", 0.00001, cap::middle);
  print("11/3", 11.0/3, cap::end);
}
