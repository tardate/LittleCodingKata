#include <complex>
#include "Mandelbrot.h"

using namespace std;

namespace lck {

Mandelbrot::Mandelbrot() {
  // TODO Auto-generated constructor stub
}

Mandelbrot::~Mandelbrot() {
  // TODO Auto-generated destructor stub
}

int Mandelbrot::getIterations(double x, double y) {
  complex<double> z = 0;
  complex<double> c(x, y);

  int iterations = 0;

  while(iterations < MAX_ITERATIONS) {
    z = z*z + c;

    if(abs(z) > 2) {
      break;
    }

    iterations++;
  }

  return iterations;
}

} /* namespace lck */
