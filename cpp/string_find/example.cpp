#include <iostream>
#include <string>
using namespace std;

int main() {
  string str("There are two needles in this haystack with needles.");
  string str2("needle");
  size_t find_from = 0;
  int needles_found = 0;

  do {
    find_from = str.find(str2, find_from);
    if (find_from != string::npos) {
      ++needles_found;
      cout << "'needle' #" << needles_found << " found at: " << int(find_from) << endl;
      ++find_from;
    }
  } while (find_from != string::npos);

  if (needles_found == 0) {
    cout << "didn't find any needles" << endl;
  }

  return 0;
}
