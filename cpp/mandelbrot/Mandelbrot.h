#pragma once

namespace lck {

class Mandelbrot {
public:
  static const int MAX_ITERATIONS = 1000;

public:
  Mandelbrot();
  virtual ~Mandelbrot();

  static int getIterations(double x, double y);
};

} /* namespace lck */
