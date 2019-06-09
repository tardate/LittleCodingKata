# Using Temporary Files with Ruby

[:arrow_forward: return to the Catalog](https://codingkata.tardate.com)

## Notes

The
[Tempfile](https://ruby-doc.org/stdlib-2.6.3/libdoc/tempfile/rdoc/Tempfile.html)
class in the ruby standard library provides a simple interface for creating
and managing temporary files.

### File Name Generation

Tempfile provides threadsafe generation of unique filenames, and accepts hints on the base name, path and extension:

```
Tempfile.new('foo').path
 => "/var/folders/28/_tsmhg4172s_wy7vswfkzq9h0000gn/T/foo20190720-858-2bg33b"
Tempfile.new('foo', '/var/folders/28/_tsmhg4172s_wy7vswfkzq9h0000gn/T').path
 => "/var/folders/28/_tsmhg4172s_wy7vswfkzq9h0000gn/T/foo20190720-858-tp775f"
Tempfile.new(['foo', '.jpg']).path
 => "/var/folders/28/_tsmhg4172s_wy7vswfkzq9h0000gn/T/foo20190720-858-bry74e.jpg"
```

### Cleaning Up Files

Tempfile automatically removes tempfiles after the tempfile handle is out of scope and the garbage collector runs.

Explicitly removing generated files is possible, and probably a good idea if many temp files are being created.
This can be performed with `unlink`, `close(true)` or `close!` methods.

If one wants to generate a temp file and prevent it's automatic removal, one technique is to undefine
the finalizer on the tempfile handle: `ObjectSpace.undefine_finalizer(file)`

### Running Some Tests

[tempfiles_test.rb](./tempfiles_test.rb) demonstrates a number of ways of working with Tempfiles,
including implicit and explcit file cleanup approaches.

```
$ ruby tempfiles_test.rb
Run options: --seed 42461

# Running:

...

Finished in 0.006527s, 459.6146 runs/s, 2451.2778 assertions/s.

3 runs, 16 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [Tempfile](https://ruby-doc.org/stdlib-2.6.3/libdoc/tempfile/rdoc/Tempfile.html) - ruby-doc 2.6.3
