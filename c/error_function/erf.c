#include <math.h>
#include <stdio.h>

void evaluate(double x) {
  double probability =  erf(x);

  printf(
    "The probability that Normal(0, 1) random variable has a value "
    "between %g and %g is: %g\n", -x, x, probability
  );

  double area = erf( x * sqrt( 1 / 2. ) );

  printf(
    "The integral of a Normal(0, 1) distribution "
    "between %g and %g is: %g\n", -x, x, area
  );
}

int main() {
  evaluate(0.25);
  evaluate(1.96);
}
