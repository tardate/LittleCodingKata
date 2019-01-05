#include <iostream>
using namespace std;

int main() {
    cout << "Enter a double and a string: ";
    double d = 42; // canary value so can tell if has been changed
    string s = "";
    cin >> d;
    if(!cin) cin.clear();
    cin >> s;
    cout << "Thanks. I read double: " << d << " and string: " << s << endl;
    return 0;
}