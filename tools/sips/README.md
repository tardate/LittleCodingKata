# #201 sips

Using sips - scriptable image processing system on macOS.

## Notes

TIL there's a "scriptable image processing" tool hiding in the macOS distribution: `sips`

This tool is used to query or modify raster image files and ColorSync ICC profiles.
Its functionality can also be used through the "Image Events" AppleScript suite.

Note: `sips -h` and `sips -H` give much more information than `man sips`.

## Inspecting Images

See `sips -H` for property details. CAn get individual properties, or to get all:

```
$ sips -g all examples/*.png
/.../LittleCodingKata/tools/sips/examples/example-original.png
  pixelWidth: 2514
  pixelHeight: 1658
  typeIdentifier: public.png
  format: png
  formatOptions: default
  dpiWidth: 144.000
  dpiHeight: 144.000
  samplesPerPixel: 4
  bitsPerSample: 8
  hasAlpha: yes
  space: RGB
  profile: Color LCD
```

### Converting File Format

Use `setProperty` to change the format:

```
$ sips -s format jpeg examples/example-original.png --out examples/converted_format.jpg
/.../LittleCodingKata/tools/sips/examples/example-original.png
  /.../LittleCodingKata/tools/sips/examples/converted_format.jpg
$ sips -g all examples/converted_format.jpg
/.../LittleCodingKata/tools/sips/examples/converted_format.jpg
  pixelWidth: 2514
  pixelHeight: 1658
  typeIdentifier: public.jpeg
  format: jpeg
  formatOptions: default
  dpiWidth: 144.000
  dpiHeight: 144.000
  samplesPerPixel: 3
  bitsPerSample: 8
  hasAlpha: no
  space: RGB
  profile: Color LCD
```

### Converting Image Dimensions

Re-sampling with a max limit, preserves aspect ratio:

```
sips -s format jpeg --resampleHeightWidthMax 1024 examples/example-original.png --out examples/converted_format_and_size.jpg
```

### Batch Conversion

Either convert in-situ by not specifying an output:

```
$ sips -s format jpeg --resampleHeightWidthMax 1024 examples/*.png
```

Or target an output directory, and glob the input files:

```
$ sips -s format jpeg --resampleHeightWidthMax 1024 examples/*.png --out examples/batch1
/.../LittleCodingKata/tools/sips/examples/example-original.png
Warning: Output file suffix changed to jpg
  /.../LittleCodingKata/tools/sips/examples/batch1/example-original.png
/.../LittleCodingKata/tools/sips/examples/example-original2.png
Warning: Output file suffix changed to jpg
  /.../LittleCodingKata/tools/sips/examples/batch1/example-original2.png
```

## Credits and References

* [sips man page](https://ss64.com/osx/sips.html)
* [name](https://aplawrence.com/foo-mac/image-processing.html)
