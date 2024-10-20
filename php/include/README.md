# #230 include

How to include or require other files in a PHP script

## Notes

The
[include](https://www.php.net/manual/en/function.include.php)
and
[require](https://www.php.net/manual/en/function.require.php)
functions are used to include other source files in the current script.
These functions are identical except on failure:

* `require` will throw a fatal `E_COMPILE_ERROR`
* `include` will emit a warning `E_WARNING`

## Cascading Includes

Inclusions can be cascaded. In this example, a variable and constant is dinfed in a file indirectly included in the example:
See [example1](./example1)

    $ php example1/example.php
    Running: example.php
    CALLED: A $adjective $color $fruit
    RESULT: A
    DEFAULT_FRUIT: DEFAULT_FRUIT
    Now including f_inner.php
    Included: f_inner.php
    f_inner defining : $color and $fruit
    Included: f_inner_inner.php
    f_inner_inner.php defining $adjective and DEFAULT_FRUIT
    CALLED: A $adjective $color $fruit
    RESULT: A juicy green pear
    DEFAULT_FRUIT: apple

## Include Paths

Unless absolute paths are specified for the

When evaluating a include/require function call, PHP will look in these locations:

* the absolute file path given
* under the[include path](https://www.php.net/manual/en/ini.core.php#ini.include-path)
* calling script's own directory
* current working directory
* else fail

## Credits and References

* [include](https://www.php.net/manual/en/function.include.php) - PHP function reference
* [get_include_path](https://www.php.net/manual/en/function.get-include-path.php) - PHP function reference
* [require](https://www.php.net/manual/en/function.require.php) - PHP function reference
* [include path](https://www.php.net/manual/en/ini.core.php#ini.include-path)
