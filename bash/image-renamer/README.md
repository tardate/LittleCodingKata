# #xxx Image/File Renamer

Ever have a bunch of files (like screenshots) that you want to give a standardised, sequential name and possibly generate a markdown link? Here's a script for that.

## Notes

The [image-renamer.sh](./image-renamer.sh) script is a little utility for renaming a bunch of files.

I use this for including screenshots in markdown files.

It is a simple bash script that just takes a couple of options then iterates and renames accordingly.
It spits out the resulting filename in a few different formats for different usages.

```sh
$ ./image-renamer.sh -h
Usage:
  ./image-renamer.sh <source_path> [-b base_name] [-p print_style] [-s sort_order]
  Example: ./image-renamer.sh ./assets/sample-data -b image- -p md -s time
Options:
  <source_path>   Path to the source directory containing images.
  -b base_name    Optional stem name for the renamed files (default: "image-").
  -p print_style  Optional output style for the renamed files (default: "md").
                  Supported styles: md, html, plain.
  -s sort_order   Optional order of files to process (default: "time").
                  Supported orders: time, name.
  -h              Show this help message.

```

### Test Data

Before all of the following tests, I create a fresh data set in [./example-data](./example-data/)
with the [make-test-data.sh](./make-test-data.sh) script:

```sh
$ ./make-test-data.sh
Making a fresh copy of ./example-data
```

### Renaming files in a relative folder

```sh
$ ./image-renamer.sh "example-data/sample-*.png"
![image-1](example-data/image-1.png)
![image-2](example-data/image-2.png)
![image-3](example-data/image-3.png)
![image-4](example-data/image-4.png)
![image-5](example-data/image-5.png)
![image-6](example-data/image-6.png)
![image-7](example-data/image-7.png)
![image-8](example-data/image-8.png)
```

So when I include that output in this markdown file, we see:

![image-1](./example-data/image-1.png)
![image-2](./example-data/image-2.png)
![image-3](./example-data/image-3.png)
![image-4](./example-data/image-4.png)
![image-5](./example-data/image-5.png)
![image-6](./example-data/image-6.png)
![image-7](./example-data/image-7.png)
![image-8](./example-data/image-8.png)

### HTML Output

```sh
$ ./image-renamer.sh "example-data/sample-*.png" -p html
<a href="example-data/image-1.png">image-1</a>
<a href="example-data/image-2.png">image-2</a>
<a href="example-data/image-3.png">image-3</a>
<a href="example-data/image-4.png">image-4</a>
<a href="example-data/image-5.png">image-5</a>
<a href="example-data/image-6.png">image-6</a>
<a href="example-data/image-7.png">image-7</a>
<a href="example-data/image-8.png">image-8</a>
```

### Plain Output

```sh
$ ./image-renamer.sh "./example-data/sample*.png" -p text
./example-data/image-1.png
./example-data/image-2.png
./example-data/image-3.png
./example-data/image-4.png
./example-data/image-5.png
./example-data/image-6.png
./example-data/image-7.png
./example-data/image-8.png
```

### Referencing files in the current folder

```sh
$ cd example-data/
$ ../image-renamer.sh "sample*.png"
![image-1.png](./image-1.png)
![image-2.png](./image-2.png)
![image-3.png](./image-3.png)
![image-4.png](./image-4.png)
![image-5.png](./image-5.png)
![image-6.png](./image-6.png)
![image-7.png](./image-7.png)
![image-8.png](./image-8.png)
```

### Changing the base name

```sh
$ ./image-renamer.sh "./example-data/sample*.png" -b graphics-
![graphics-1](./example-data/graphics-1.png)
![graphics-2](./example-data/graphics-2.png)
![graphics-3](./example-data/graphics-3.png)
![graphics-4](./example-data/graphics-4.png)
![graphics-5](./example-data/graphics-5.png)
![graphics-6](./example-data/graphics-6.png)
![graphics-7](./example-data/graphics-7.png)
![graphics-8](./example-data/graphics-8.png)
```

## Credits and References

* [name](url)
