#include <iostream>
#include <locale>
#include <string>
#include <sstream>
#include <iterator>

int main () {
    std::string source("car");

    double d = 42; // canary value so can tell if has been changed
    std::ios::iostate err;

    std::istringstream ss(source);
    std::istreambuf_iterator<char> beg(ss), end;

    std::use_facet<std::num_get<char> >(ss.getloc()).get(beg, end, ss, err, d);

    std::cout << "parsing " << source << " as double gives " << d << std::endl;

    std::cout << "err: " << err << std::endl;
    std::cout << "gcount: " << ss.gcount() << std::endl;
    std::cout << "tellg: " << ss.tellg() << std::endl;

    std::string remainder;
    ss >> remainder;

    std::cout << "remainder: " << remainder << std::endl;

    return 0;
}
