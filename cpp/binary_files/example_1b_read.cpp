#include <iostream>
#include <fstream>
#include "person.h"

using namespace std;

int main() {
  string filename = "data.bin";

  Person person;

  ifstream input;

  input.open(filename, ios::binary);

  cout << "Reading Person from " << filename << ".." << endl;

  if (!input.is_open()) {
    cout << "Could not read " << filename << endl;
  }

  input.read(reinterpret_cast<char *>(&person), sizeof(Person));

  if (!input) {
    cout << "Could not read data from file " << filename << endl;
  }

  input.close();

  cout << person.name << ": " << person.age << ": " << person.height << endl;

  return 0;
}
