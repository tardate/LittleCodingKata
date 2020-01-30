#include <gsl/gsl_sf_erf.h>
#include <gsl/gsl_cdf.h>
#include <stdio.h>

void evaluate(double x) {
  double probability = gsl_sf_erf(x);

  printf(
    "The probability that Normal(0, 1) random variable has a value "
    "between %g and %g is: %g\n", -x, x, probability
  );

  double area = 1 - 2 * gsl_cdf_gaussian_P(-x, 1);

  printf(
    "The integral of a Normal(0, 1) distribution "
    "between %g and %g is: %g\n", -x, x, area
  );
}

int main() {
  evaluate(0.25);
  evaluate(1.96);
}
