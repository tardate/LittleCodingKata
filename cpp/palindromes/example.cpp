#include <iostream>
#include <string>

using namespace std;

string reverse(string s) {
   int n = s.size();
   for (int i = 0; i < n / 2; ++i) swap(s[i], s[n - i - 1]);
   return s;
}

void check_by_explicitly_reversing_the_string(string given) {
   cout << "Checking by explicitly reversing the string: ";

   string reversed = reverse(given);
   if (given == reversed)
      cout << "Yes, " << given << " is a palindrome." << endl;
   else
      cout << "No, " << given << " is not a palindrome." << endl;
}

void check_by_magic(string given) {
   cout << "Checking with a range comparison: ";

   if (equal(given.begin(), given.end(), given.rbegin())) {
      cout << "Yes, " << given << " is a palindrome." << endl;
   } else {
      cout << "No, " << given << " is not a palindrome." << endl;
   }
}

int main() {
   cout << "If you type in a word, I'll tell you if it is a palindrome." << endl;
   string given;
   cin >> given;

   check_by_explicitly_reversing_the_string(given);
   check_by_magic(given);

   return 0;
}
