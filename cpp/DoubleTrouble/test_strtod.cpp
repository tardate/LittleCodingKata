#include <iostream>
#include <string>
#include <cerrno>
#include <cstdlib>

int main()
{
    const char* p = "car";
    char* end;
    std::cout << "Parsing '" << p << "':" << std::endl;
    double d = 42; // canary value so can tell if has been changed
    d = std::strtod(p, &end);
    std::cout << "'" << std::string(p, end-p) << "' -> " << d << std::endl;
    std::cout << "errno: " << errno << std::endl;
    std::cout << "p: " << p << std::endl;
    std::cout << "end: " << end << std::endl;
    return 0;
}
