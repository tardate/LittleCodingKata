# #219 Files

Simple binary file operations with C++.

## Notes


### Binary Output file streams

Open [ofstream](http://www.cplusplus.com/reference/fstream/ofstream/) in binary mode:

    ofstream output;
    output.open("filename", ios::binary);

Write as a char stream into struct:

    Person person = {...};
    output.write(reinterpret_cast<char *>(&person), sizeof(Person));


### Binary Input file streams

Open [ifstream](http://www.cplusplus.com/reference/fstream/ifstream/) in binary mode:

    ifstream input;
    input.open("filename", ios::binary);

Read as a char stream into struct:

    Person person;
    input.read(reinterpret_cast<char *>(&person), sizeof(Person));

###  Structure-Packing

Use [Structure-Packing Pragmas](https://gcc.gnu.org/onlinedocs/gcc-4.4.4/gcc/Structure_002dPacking-Pragmas.html)
to force byte alignment e.g.

    #pragma pack(push, 1)
    struct Person {
      char name[50];
      int age;
      double height;
    };
    #pragma pack(pop)

### Running the Example

    $ make
    c++ -std=c++17 -Wall -O3    example_1a_write.cpp   -o example_1a_write
    c++ -std=c++17 -Wall -O3    example_1b_read.cpp   -o example_1b_read
    ./example_1a_write; ./example_1b_read;
    Writing Person to data.bin..
    Reading Person from data.bin..
    Joey: 42: 1.7


## Credits and References

* [Structure-Packing Pragmas](https://gcc.gnu.org/onlinedocs/gcc-4.4.4/gcc/Structure_002dPacking-Pragmas.html)
* [ifstream](http://www.cplusplus.com/reference/fstream/ifstream/)
* [ofstream](http://www.cplusplus.com/reference/fstream/ofstream/)
