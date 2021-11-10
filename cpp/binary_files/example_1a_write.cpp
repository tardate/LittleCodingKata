#include <iostream>
#include <fstream>
#include "person.h"

using namespace std;

int main() {
  string filename = "data.bin";

  Person person = { "Joey", 42, 1.7 };

  ofstream output;

  output.open(filename, ios::binary);

  cout << "Writing Person to " << filename << ".." << endl;

  if (!output.is_open()) {
    cout << "Could not create " << filename << endl;
  }

  output.write(reinterpret_cast<char *>(&person), sizeof(person));

  if (!output) {
    cout << "Could not write data to file " << filename << endl;
  }

  output.close();

  return 0;
}
