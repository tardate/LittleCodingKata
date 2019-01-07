#include <iostream>
#include <exception>
using namespace std;


/// @brief demonstrates a custom exception
///
class CustomException: public exception {
public:

  /// @brief Get string identifying exception
  ///
  virtual const char * what() const noexcept {
    return "Something bad happened";
  }

};

/// @brief generates various exceptions
/// @param selector chooses the exception to raise.
///
void mightGoWrong(int selector) {

  switch(selector) {

    case 1 :
      throw "Oh deary me";
      break;

    case 2 :
      throw string("Out of bacon");
      break;

    case 3 :
      throw bad_alloc();
      break;

    case 4 :
      throw exception();
      break;

    case 5 :
      throw CustomException();
      break;

    default:
      throw 33;
  }

}

/// @brief a class that blows-up in the constructor
///
class BombsInTheConstructor {
public:
  BombsInTheConstructor() {
    char *pMemory = new char[999999999999999];
    delete [] pMemory;
  }

};

/// @brief run a demo suite of exceptions
///
int main() {

  cout << endl << "Testing a range of standard and custom exceptions.." << endl << endl;

  for(int trials=0; trials<6; ++trials) {

    try {
      mightGoWrong(trials);
    }
    catch(int e) {
      cout << "Error code: " << e << endl;
    }
    catch(char const * e) {
      cout << "Basic error message: " << e << endl;
    }
    catch(string &e) {
      cout << "String error message caught by reference: " << e << endl;
    }
    catch(CustomException &e) {
      cout << "CustomException message caught by reference: " << e.what() << endl;
    }
    catch(bad_alloc &e) { // must catch this before ancestor exception classes
      cout << "bad_alloc error message caught by reference: " << e.what() << endl;
    }
    catch(exception &e) {
      cout << "Generic exception error message caught by reference: " << e.what() << endl;
    }
  }

  cout << endl << "Now testing an exception in a constructor.." << endl << endl;

  try {
    BombsInTheConstructor sad_trombone;
  }
  catch(bad_alloc &e) {
    cout << "bad_alloc message: " << e.what() << endl;
  }

  cout << endl << "And we're still running!" << endl;

  cout << endl << "But the next has no handler:" << endl << endl;

  mightGoWrong(0);

  return 0;

}
