#! /usr/bin/env python
import argparse
import os
from PIL import Image
from PIL import ImageOps


def show_image_details(name, file_name, image):
    width, height = image.size
    print(f'{name}: {file_name} ({width}w x {height}h)')


def remove_orientation(image):
    exif = image.getexif()
    for tag in exif.keys():
        # print(f'0x{tag:04x}: {exif[tag]} type:{type(exif[tag])}')
        if tag in [0x8825]:
            # remove the GPS exif fields because exif_transpose can't the tags I have in the source image
            del exif[tag]
    image.info['exif'] = exif.tobytes()
    return ImageOps.exif_transpose(image)


def image_resize(file_name, new_size):
    image = Image.open(file_name)
    show_image_details('Source', file_name, image)

    image = remove_orientation(image)
    new_image = image.resize(new_size)
    root, ext = os.path.splitext(file_name)
    new_file_name = f'{root}-resized-{"x".join(map(str, new_size))}{ext}'
    show_image_details('Resized', new_file_name, new_image)
    new_image.save(new_file_name)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Resize an image")
    parser.add_argument('filename', help='source file', type=str)
    parser.add_argument('-x', help='resize to width in pixels (default 420)', type=int, default=420)
    parser.add_argument('-y', help='resize to height in pixels (default 420)', type=int, default=420)
    args = parser.parse_args()
    image_resize(args.filename, (args.x, args.y))
