#! /usr/bin/env python
import argparse
import qrcode
from PIL import Image, ImageOps
import io
import sys


def serialize_for_c(qr, border, message):
    """ generates a c-style representation of the qr code to stdout. """
    # size the output for an even fit to an 8-bit matrix
    output_size = 8 * (4 * qr.version + 17 + 2 * border)

    # NB: trying to invert the colors here doesn't work with qrcode-6.1
    img = qr.make_image(fill_color='black', back_color='white')

    resized_img = img.resize((output_size, output_size), Image.NEAREST)
    width = resized_img.width
    height = resized_img.height
    bytes_per_row = width // 8

    print('#pragma once\n')
    print('// Original QR code details')
    print('// * Version : {}'.format(qr.version))
    print('// * Error correction : {}'.format(qr.error_correction))
    print('// * Box size (pixels) : {}'.format(qr.box_size))
    print('// * Border size (boxes) : {}'.format(border))
    print('// * Message : {}\n'.format(message))

    print('#define qrcode_width  {}'.format(width))
    print('#define qrcode_height  {}\n'.format(height))
    print('static const uint8_t PROGMEM qrcode_data[] = {')

    content = bytes(resized_img.tobytes(encoder_name='raw'))
    for row in range(height):
        offset = row * bytes_per_row
        # invert the output so 1=black, 0=white
        row_hex = ['0x{:02x}'.format(~b & 0xff) for b in content[offset:offset+bytes_per_row]]
        if row == height - 1:
            output = '  {}'
        else:
            output = '  {},'
        print(output.format(','.join(row_hex)))

    print('};')


def serialize_image(qr, format):
    """ generates an image of the qr code in specified format to stdout. """
    img = qr.make_image(fill_color='black', back_color='white')
    with io.BytesIO() as output:
        img.save(output, format=format)
        content = output.getvalue()
    sys.stdout.buffer.write(content)


def generate(message, border=4):
    """ Return the generated QR code. """
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_M,
        box_size=8,
        border=border
    )
    qr.add_data(message)
    qr.make(fit=True)
    return qr


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Generate a QR code')
    parser.add_argument(
        '-m',
        help='message for the QR code',
        required=True
    )
    parser.add_argument(
        '-f', '--format',
        help='output format',
        choices=['png', 'gif', 'bmp', 'c'],
        default='png'
    )
    parser.add_argument(
        '-b',
        help='border size (in blocks',
        type=int,
        default=4
    )
    args = parser.parse_args()
    qr = generate(args.m, border=args.b)
    if args.format == 'c':
        serialize_for_c(qr, border=args.b, message=args.m)
    else:
        serialize_image(qr, args.format)
