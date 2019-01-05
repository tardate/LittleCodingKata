#include <iostream>
using namespace std;

int main() {
    string name;
    double d;

    while (cin) {
        cin >> name;
        if (cin) {
            cout << "Name: " << name;
            while (cin >> d) {
              cout << " " << d;
            }
            cin.clear();
            cout << endl;
        }
    }
    return 0;
}
