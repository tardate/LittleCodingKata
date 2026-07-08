# #470 Chilkat Library with C

A quick look at the Chilkat component library and a demonstration of using it with C.

## Notes

A stumbled upon the component library produced by
[Chilkat Software Inc.](https://www.chilkatsoft.com/products.asp) some time ago.
It grabbed my attention because it appears to be one of those few cases where a small business
has been created and maintained over decades by offering a software component library license.
It is unusual for the range of environments and languages it supports with a common API:

* Systems/Environments: Windows, Linux, Alpine Linux, MacOS, iOS, Android™, PowerLinux, ARM Linux, Raspberry Pi, MinGW, MSYS2
* Programming Languages: C#, VB.NET, ASP.NET, ASP, VB6, FoxPro, VBScript, Delphi, SQL Server, C/C++, Objective-C, Swift, Xojo, Node.js, Electron, C++ Builder, Powershell, Perl, PHP, Ruby, Java, Python, Go, Lianja, PureBasic, all languages supporting ActiveX (such as PowerBuilder, DataFlex, etc.).

### Library Installation

[Chilkat C/C++ Library Downloads](https://www.chilkatsoft.com/downloads_CPP.asp)
are available for both
libstdc++ (GNU Project), and libc++ (LLVM / Clang Project).

For this example, I'll use the
[Chilkat C/C++ Libs for MacOS (clang/C++/libstdc++)](https://www.chilkatsoft.com/chilkatMacOSX.asp).

```sh
wget https://chilkatdownload.com/11.5.0/chilkat-macosx-cpp.zip
unzip chilkat-macosx-cpp.zip
rm chilkat-macosx-cpp.zip
echo 'chilkat-macosx-*' > .gitignore
```

The C/C++ headers are contained in include directory: `chilkat-macosx-cpp/include`.

The universal static (.a) and dynamic libs (.dylib) are located in the libStatic and libDyn directories.
I'll link with the static library: `chilkat-macosx-cpp/libStatic/libchilkat.a`.

On macOS, must also a few system libraries and macOS frameworks:

* `-lpthread`: POSIX threads
* `-lresolv`: DNS resolver library
* `-ldl`: Dynamic linking library
* `-framework CoreFoundation`: macOS
* `-framework Security`: macOS

### Pretty Print JSON (Formatter, Beautifier)

This example from <https://www.example-code.com/C/json_pretty_print.asp> demonstrates how to emit JSON in a pretty, human-readable format with indenting of nested arrays and objects.

I've chosen this example because `CkJsonObject` is one of the few components available for use without a license.

Common pattern: Load or create a `JsonObject`, navigate named members and nested paths, retrieve child arrays as `JsonArray` objects when ordered lists are encountered, update values as needed, then emit or save the final JSON. Use `JsonObject` for named JSON members and `JsonArray` for ordered lists.

See [CkJsonObject C Reference](https://www.chilkatsoft.com/refdoc/c_CkJsonObjectRef.html).

See [example.c](./example.c) for an adaptation of the example. I've modified it to take a JSON filename as a program argument, read the file and pretty-print it with the `CkJsonObject` component.

### Compile and Link

To link a macOS "C" application with the Chilkat library using gcc, you must compile the C source files into object files using gcc and perform the final link phase using g++.
This is because Chilkat is written in C++, and the final executable requires the C++ runtime libraries (libc++ or libstdc++).

I've created a [Makefile](./Makefile) to setup the compile and link stages appropriately.

Compile and link:

```sh
$ make clean
rm -f example *.o
rm -fR *.dSYM
$ make
gcc -Wall -O0 -I./chilkat-macosx-cpp/include -c example.c -o example.o
g++ example.o -L./chilkat-macosx-cpp/libStatic -lchilkat -lpthread -lresolv -ldl -framework CoreFoundation -framework Security -o example
```

Running the example with a JSON example file [data.json](./data.json):

```sh
$ ./example
Usage: ./example <filename>
$ cat data.json
{"name":"donut","image":{"fname":"donut.jpg","w":200,"h":200},"thumbnail":{"fname":"donutThumb.jpg","w":32,"h":32}}
$ ./example data.json
{
  "name": "donut",
  "image": {
    "fname": "donut.jpg",
    "w": 200,
    "h": 200
  },
  "thumbnail": {
    "fname": "donutThumb.jpg",
    "w": 32,
    "h": 32
  }
}
```

### Final Code

See [example.c](./example.c):

```c
#include <stdlib.h>
#include <stdio.h>
#include <C_CkJsonObject.h>

void PrettyPrintJSON(const char *jsonStr) {
  BOOL success;
  HCkJsonObject json;

  success = FALSE;

  json = CkJsonObject_Create();

  success = CkJsonObject_Load(json,jsonStr);
  if (success != TRUE) {
    printf("%s\n",CkJsonObject_lastErrorText(json));
    CkJsonObject_Dispose(json);
    return;
  }

  // To pretty-print, set the EmitCompact property equal to FALSE
  CkJsonObject_putEmitCompact(json,FALSE);

  // If bare-LF line endings are desired, turn off EmitCrLf
  // Otherwise CRLF line endings are emitted.
  CkJsonObject_putEmitCrLf(json,FALSE);

  // Emit the formatted JSON:
  printf("%s\n",CkJsonObject_emit(json));

  CkJsonObject_Dispose(json);
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    fprintf(stderr, "Usage: %s <filename>\n", argv[0]);
    return 1;
  }

  FILE *file = fopen(argv[1], "r");
  if (file == NULL) {
    fprintf(stderr, "Error: Could not open file %s\n", argv[1]);
    return 1;
  }

  fseek(file, 0, SEEK_END);
  long filesize = ftell(file);
  fseek(file, 0, SEEK_SET);

  char *jsonStr = (char *)malloc(filesize + 1);
  fread(jsonStr, 1, filesize, file);
  jsonStr[filesize] = '\0';
  fclose(file);

  PrettyPrintJSON(jsonStr);
  return 0;
}
```

## Credits and References

* <https://www.chilkatsoft.com/products.asp>
* <https://www.chilkatsoft.com/downloads_CPP.asp>
* [CkJsonObject C Reference](https://www.chilkatsoft.com/refdoc/c_CkJsonObjectRef.html)
