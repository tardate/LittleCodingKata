# Image Resize

Simple image resizing with python and the Pillow library and a little yak shaving with EXIF tags.

## Notes

The original [Python Imaging Library (PIL)](https://pypi.org/project/PIL/) has been superseded by
the [Pillow](https://pypi.org/project/Pillow/) fork as perhaps the most popular image manipulation library for python.
The history is described in [this wikipedia article](https://en.wikipedia.org/wiki/Python_Imaging_Library).

## Installation

This script uses [Pillow](https://pypi.org/project/Pillow/) as described in [requirements.txt](./requirements.txt). Install with pip:

```sh
$ python --version
Python 3.7.3
$ pip install -r requirements.txt
Collecting pillow
  Using cached Pillow-9.3.0-cp37-cp37m-macosx_10_10_x86_64.whl (3.3 MB)
Installing collected packages: pillow
Successfully installed pillow-9.3.0
```

## Example

The [example.py](./example.py) script takes any input image and resizes it.

The Image module provides two functions that could be used:

* [resize](https://pillow.readthedocs.io/en/stable/reference/Image.html#PIL.Image.Image.resize) - resize to requested size ignoring the aspect ratio
* [thumbnail](https://pillow.readthedocs.io/en/stable/reference/Image.html#PIL.Image.Image.thumbnail) - resize to best fit while retaining the aspect ratio

I'm using resize in the example.

```sh
$ ./example.py -h
usage: example.py [-h] [-x X] [-y Y] filename

Resize an image

positional arguments:
  filename    source file

optional arguments:
  -h, --help  show this help message and exit
  -x X        resize to width in pixels (default 420)
  -y Y        resize to height in pixels (default 420)
```

As an example, I'm using this photograph:

![source](./data/source.jpg)

```sh
$ ./example.py data/source.jpg
Source: data/source.jpg (2992w x 2992h)
Resized: data/source-resized-420x420.jpg (420w x 420h)
```

Producing this output file:

![source-resized-420x420](./data/source-resized-420x420.jpg)

Custom resize dimensions may be provided:

```sh
$ ./example.py data/source.jpg -x 80 -y 60
Source: data/source.jpg (2992w x 2992h)
Resized: data/source-resized-80x60.jpg (80w x 60h)
```

Producing this very low resolution output file:

![source-resized-80x60](./data/source-resized-80x60.jpg)

## A Little Yak Shaving - EXIF Orientation and Bugs

My first attempt at this script resized the image correctly, but with a -90˚ rotation.

* [stackoverflow](https://stackoverflow.com/questions/4228530/pil-thumbnail-is-rotating-my-image) to the rescue: this was because the original image had an EXIF orientation tag that was being lost in the resize

My second attempt applied the
[exif_transpose](https://pillow.readthedocs.io/en/stable/reference/ImageOps.html#PIL.ImageOps.exif_transpose)
to retain the orientation indicated by the EXIF tags. But this failed with a `TypeError: object of type 'int' has no len()` in the `PIL/TiffImagePlugin` module.

After a bit of digging around, it turns out that EXIF tags have been a source of many issues e.g. [LensSpecification](https://github.com/python-pillow/Pillow/issues/4346).

In my case, it was the [GPS Info field 0x8825](https://exiftool.org/TagNames/EXIF.html) causing problems:

```sh
0x8825: 656 type:<class 'int'>
```

As a result, I've added a `remove_orientation` function that blows this EXIF field away before performing the `exif_transpose`:

```python
def remove_orientation(image):
    exif = image.getexif()
    for tag in exif.keys():
        # print(f'0x{tag:04x}: {exif[tag]} type:{type(exif[tag])}')
        if tag in [0x8825]:
            # remove the GPS exif fields because exif_transpose can't handle the tags I have in the source image
            del exif[tag]
    image.info['exif'] = exif.tobytes()
    return ImageOps.exif_transpose(image)
```

NB: to be super-safe, I could alternatively throw away all tags except orientation (0x0112)

## Credits and References

* [Pillow](https://pypi.org/project/Pillow/)
* [PIL](https://pypi.org/project/PIL/)
* [Python Imaging Library](https://en.wikipedia.org/wiki/Python_Imaging_Library) - wikipedia
* [PIL thumbnail is rotating my image?](https://stackoverflow.com/questions/4228530/pil-thumbnail-is-rotating-my-image) - stackoverflow
* [EXIF tags](https://exiftool.org/TagNames/EXIF.html)
* [Image exif_transpose not working with Pillow 7](https://github.com/python-pillow/Pillow/issues/4346)
