# About YAML

Notes on structure, generation and validation of YAML.

## Notes

[YAML](https://en.wikipedia.org/wiki/YAML) is a human-readable data-serialization language, commonly used for configuration files.

Core format features:

* Python-style indentation for nesting
* natively encodes scalars (strings, integers, and floats)
* uses '[]' for lists
* users '{}'' for maps


## Some Examples

See [./examples](./examples) for  some example YAML files.

The script `test_examples.rb` can be used to test all the example files.

```
$ ./test_examples.rb
Run options: --seed 36493

# Running:

...

Finished in 0.001647s, 1821.4937 runs/s, 5464.4810 assertions/s.

3 runs, 9 assertions, 0 failures, 0 errors, 0 skips
```

## Credits and References

* [](https://yaml.org/)
* [Yet Another Markup Language (YAML) 1.0](https://yaml.org/spec/history/2001-12-10.html)
* [YAML](https://en.wikipedia.org/wiki/YAML) - wikipedia
* [YAML Tools](https://onlineyamltools.com/)
* [Ruby YAML](https://apidock.com/ruby/YAML)
