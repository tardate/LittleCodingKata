# #090 QR Codes with Python

Generating QR codes with python, as images and as C header files for embedded applications.

## Notes

A quick test of the [qrcode](https://pypi.org/project/qrcode/) Python library for generating QR codes,
and exploring various output formats.

NB: these tests were performed with Python 3.7.4

## QR Code Basics

[QR code](https://en.wikipedia.org/wiki/QR_code) is the trademark for a type of matrix barcode first designed in 1994 for the automotive industry in Japan.
Since, of course, it has been predominantly used for smartphone quick-links.

The amount of data that can be stored in the QR code symbol depends on:

* datatype (mode, or input character set)
* version (1, ..., 40, indicating the overall dimensions of the symbol, i.e. 4 × version number + 17 dots on each side)
* error correction level.

Error corrections:

* L (Low) - 7% of codewords can be restored
* M (Medium) - 15% of codewords can be restored
* Q (Quartile) - 25% of codewords can be restored
* H (High) - 30% of codewords can be restored

## Installation

This example uses the qrcode python client, which depends on pillow. Install with pip:

```
$ pip install -r requirements.txt
```

## Command Line Test

The qrcode library has a command line interface invoked with `qr`:

```
$ qr --help
Usage: qr - Convert stdin (or the first argument) to a QR Code.

When stdout is a tty the QR Code is printed to the terminal and when stdout is
a pipe to a file an image is written. The default image format is PNG.

Options:
  --version             show program's version number and exit
  -h, --help            show this help message and exit
  --factory=FACTORY     Full python path to the image factory class to create
                        the image with. You can use the following shortcuts to
                        the built-in image factory classes: pil, pymaging,
                        svg, svg-fragment, svg-path.
  --optimize=OPTIMIZE   Optimize the data by looking for chunks of at least
                        this many characters that could use a more efficient
                        encoding method. Use 0 to turn off chunk optimization.
  --error-correction=ERROR_CORRECTION
                        The error correction level to use. Choices are L (7%),
                        M (15%, default), Q (25%), and H (30%).
```

Generating a QR code for a website:

```
qr "https://leap.tardate.com" > leap.png
```

Resulting image:

![leap](./assets/leap.png?raw=true)

## Programmatic Generation

The simple [example.py](./example.py) script demonstrates generation in code.
It accepts a format parameter to dictate the output file format.
The output is streamed to stdout, so whould be redriected to a file for storage:

```
$ ./example.py -m "qr to png" -f png > assets/test.png
$ ./example.py -m "qr to gif" -f gif > assets/test.gif
$ ./example.py -m "qr to bmp" -f bmp > assets/test.bmp
```

Resulting images:

| png | gif | bmp |
|-----|-----|-----|
| ![png](./assets/test.png?raw=true) | ![gif](./assets/test.gif?raw=true) | ![bmp](./assets/test.bmp?raw=true) |

### Generating for Embedded

A `c` formatter provides a simple conversion to an Arduino-compatible C datastruture that
may be included in embedded programs.
The code was inspired by the [`tobitmap` implementation from PIL](https://github.com/python-pillow/Pillow/blob/master/src/PIL/Image.py#L722)

`$ ./example.py -m 'https://leap.tardate.com' -f c -b 0 > assets/leap.h`

The `-b 0` parameter indicates generate with no border boxes (optional).

This generates an array of bytes in a header file structure, ready for inclusion in an Arduino sketch:

    #pragma once

    // Original QR code details
    // * Version : 2
    // * Error correction : 0
    // * Box size (pixels) : 8
    // * Border size (boxes) : 0
    // * Message : https://leap.tardate.com

    #define qrcode_width  200
    #define qrcode_height  200

    static const uint8_t PROGMEM qrcode_data[] = {
      0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
      0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0x00,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
      // ... etc ...
      0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff,
      0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0xff,0x00,0x00,0x00,0xff,0xff,0xff
    };


## Credits and References

* [QR code](https://en.wikipedia.org/wiki/QR_code) - wikipedia
* [qrcode](https://pypi.org/project/qrcode/) - pypi
* [pillow](https://pillow.readthedocs.io/en/stable/)
