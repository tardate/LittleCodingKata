#pragma once

namespace lck {

struct RGB {
  double r;
  double g;
  double b;

  RGB(double r, double g, double b);
};

RGB operator-(const RGB& first, const RGB& second);

} /* namespace lck */
