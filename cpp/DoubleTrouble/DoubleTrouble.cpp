#include <iostream>
#include <sstream>
using namespace std;


void attempt_conversion(string example, double expected_result, string expected_remainder) {
    std::istringstream reader;
    reader.str(example);

    cout << "Reading '" << reader.str() << "': ";

    double d = 42;
    reader >> d;
    cout << "result=" << d << " ";
    if (d == expected_result) {
        cout << "[OK, matches expected]";
    } else {
        cout << "[BAD, does not match expected: " << expected_result << "]";
    }
    cout << " (gcount: " << reader.gcount() << ", tellg: " << reader.tellg() << ")";

    // if(reader.fail() && !reader.eof()) {
        reader.clear();
    // }
    std::string s;
    reader >> s;
    cout << ", remainder on stream='" << s << "' ";
    if (s == expected_remainder) {
        cout << "[OK, matches expected]";
    } else {
        cout << "[BAD, does not match expected: '" << expected_remainder << "']";
    }
    cout << endl;
}


int main() {

    cout << "# Valid floats followed by miscellaneous input" << endl;
    attempt_conversion("-4.9 A", -4.9, "A");
    attempt_conversion("-4.9A", -4.9, "A");
    attempt_conversion("-4.9 Z", -4.9, "Z");
    attempt_conversion("-4.9Z", -4.9, "Z");

    cout << "# Floating point literals followed by miscellaneous input" << endl;
    attempt_conversion("0x1a.bp+07", 3416, "");
    attempt_conversion("0x1a.bp+07aaaa", 3416, "aaaa");
    attempt_conversion("0x1a.bp+07zzzz", 3416, "zzzz");


    cout << "# Things that might look like numbers at first, but aren't" << endl;
    attempt_conversion("car", 0, "car");
    attempt_conversion("truck", 0, "truck");

    return 0;
}
